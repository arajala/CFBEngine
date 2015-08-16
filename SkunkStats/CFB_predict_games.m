function CFB_predict_games(model, lib, year, week)
%
addpath ../Base
addpath C:\libsvm-3.18\matlab
addpath C:\liblinear-1.94\matlab

%% === Read in this weeks matchups, find features ===
fileName = sprintf('../Scores/Scores-%s-%s.cfb', year, week);
fid = fopen(fileName, 'r');
testData = zeros(0, 0);
moreScores = true;
iGame = 1;
teams = cell(0, 2);
while moreScores
    thisScore = fgetl(fid);
    if thisScore == -1
        moreScores = false;
        continue
    end
    % Lookup team index
    commas = find(thisScore == ',');
    teams{iGame,1} = thisScore(1:commas(1)-1);
    teams{iGame,2} = thisScore(commas(1)+1:commas(2)-1);
    iTeam1 = CFB_lookup(teams{iGame,1});
    iTeam2 = CFB_lookup(teams{iGame,2});
    % Get data features
    lastWeek = sprintf('0%d', eval(week)-1);
    if length(lastWeek) == 3
        lastWeek = lastWeek(2:3);
    end
    if eval(week) == 1
      lastYear = sprintf('%d', eval(year)-1);
      testData(iGame,:) = CFB_find_features(iTeam1, iTeam2, lastYear, '16');
    elseif eval(week) < 4
        lastYear = sprintf('%d', eval(year)-1);
        preFraction = 1 / eval(week);
        testData(iGame,:) = preFraction * CFB_find_features(iTeam1, iTeam2, lastYear, '16') + ...
            (1-preFraction) * CFB_find_features(iTeam1, iTeam2, year, lastWeek);
    else
        testData(iGame,:) = CFB_find_features(iTeam1, iTeam2, year, lastWeek);
    end
    iGame = iGame + 1;
end
testLabels = zeros(size(testData, 1), 1);
fclose(fid);

%% === Test the model ===
if strcmp(lib, 'libsvm')
    [predLabels acc conf] = svmpredict(testLabels, testData, model, '-b 0 -q');
elseif strcmp(lib, 'liblin')
    [predLabels acc conf] = linpredict(testLabels, sparse(testData), model, '-b 1 -q');
else
    fprintf('Unknown library, exiting.\n');
    return
end

%% === Predict games and rank by confidence ===
nGames = size(predLabels, 1);
results = cell(nGames, 4);
for iGame = 1:nGames
    results{iGame,1} = teams{iGame,1};
    results{iGame,2} = teams{iGame,2};
    if predLabels(iGame,1) == 1
        results{iGame,3} = 2;
        results{iGame,4} = abs(conf(iGame,1));
    else
        results{iGame,3} = 1;
        results{iGame,4} = abs(conf(iGame,1));
    end
end
results = CFB_sort_results(results, 4);

%% === Print games to console and file ===
predictions = '';
for iGame = 1:nGames
    predictions = sprintf('%s%s @ %s, predicted winner: %s, confidence: %.4f\n', ...
        predictions, results{iGame,1}, results{iGame,2}, results{iGame,results{iGame,3}}, results{iGame,4});
end
fprintf('%s', predictions);
predictionsFile = sprintf('Predictions-%s-%s.cfb', year, week);
fid = fopen(predictionsFile, 'w');
fprintf(fid, '%s', predictions);
fclose(fid);

%%
end
