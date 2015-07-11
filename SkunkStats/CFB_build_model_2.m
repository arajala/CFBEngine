function model = CFB_build_model_2(lib, args, startYear, startWeek, endYear, endWeek)
%
addpath ../Base
addpath C:\libsvm-3.18\matlab
addpath C:\liblinear-1.94\matlab

%% === Loop through years and weeks ===
iStartYear = eval(startYear);
iStartWeek = eval(startWeek);
iEndYear = eval(endYear);
iEndWeek = eval(endWeek);
trainData = zeros(0, 0);
trainLabels = zeros(0, 1);
iGame = 1;
for iYear = iStartYear:iEndYear
    for iWeek = iStartWeek:iEndWeek
%         if iWeek == 7
%             disp('Skipping week 7')
%             continue
%         end
        thisWeek = sprintf('0%d', iWeek);
        thisWeek = thisWeek(end-1:end);
        thisFile = sprintf('../Scores/Scores-%d-%s.cfb', iYear, thisWeek);
        thisFid = fopen(thisFile, 'r');
        moreScores = 1;
        while moreScores
            thisScore = fgetl(thisFid);
            if thisScore == -1
                moreScores = 0;
                continue
            end
            % Lookup team index
            commas = find(thisScore == ',');
            team1 = thisScore(1:commas(1)-1);
            team2 = thisScore(commas(1)+1:commas(2)-1);
            iTeam1 = CFB_lookup(team1);
            iTeam2 = CFB_lookup(team2);
            % Get data features
            sYear = sprintf('%d', iYear);
            sWeek = sprintf('%d', iWeek);
            trainData(iGame,:) = CFB_find_features(iTeam1, iTeam2, sYear, sWeek);
            % Get labels
            score1 = thisScore(commas(2)+1:commas(3)-1);
            score2 = thisScore(commas(3)+1:end);
            try
                score1 = eval(score1);
                score2 = eval(score2);
            catch
                disp('Warning: N/A scores, skipping')
                continue
            end
            if score2 > score1
                trainLabels(iGame,1) = 1;
            else
                trainLabels(iGame,1) = -1;
            end
            % Inc
            iGame = iGame + 1;
        end
        fclose(thisFid);
    end
end

%% === Train the model ===
trainData(trainData ~= trainData) = 0;
if strcmp(lib, 'libsvm')
    model = svmtrain(trainLabels, trainData, args);
elseif strcmp(lib, 'liblin')
    model = lintrain(trainLabels, sparse(trainData), args);
end

%%
end
