function model = CFB_build_model(lib, args)
%
addpath ../Base
addpath C:\libsvm-3.18\matlab
addpath C:\liblinear-1.94\matlab

%% === Read in 2014-00 scores and stats ===
fid = fopen('../Scores/Scores-2014-00.cfb', 'r');
moreScores = true;
trainData = zeros(0, 0);
trainLabels = zeros(0, 1);
iGame = 1;
while moreScores
    thisScore = fgetl(fid);
    if thisScore == -1
        moreScores = false;
        continue
    end
    % Lookup team index
    commas = find(thisScore == ',');
    team1 = thisScore(1:commas(1)-1);
    team2 = thisScore(commas(1)+1:commas(2)-1);
    iTeam1 = CFB_lookup(team1);
    iTeam2 = CFB_lookup(team2);
    % Get data features
    trainData(iGame,:) = CFB_find_features(iTeam1, iTeam2, '2014', '00');
    % Get labels
    score1 = thisScore(commas(2)+1:commas(3)-1);
    score2 = thisScore(commas(3)+1:end);
    score1 = eval(score1);
    score2 = eval(score2);
    if score2 > score1
        trainLabels(iGame,1) = 1;
    else
        trainLabels(iGame,1) = -1;
    end
    % Inc
    iGame = iGame + 1;
end

%% === Read in 2013-12 scores ===
fclose(fid);
fid = fopen('../Scores/Scores-2013-12.cfb', 'r');
moreScores = true;
while moreScores
    thisScore = fgetl(fid);
    if thisScore == -1
        moreScores = false;
        continue
    end
    % Lookup team index
    commas = find(thisScore == ',');
    team1 = thisScore(1:commas(1)-1);
    team2 = thisScore(commas(1)+1:commas(2)-1);
    iTeam1 = CFB_lookup(team1);
    iTeam2 = CFB_lookup(team2);
    % Get data features
    trainData(iGame,:) = CFB_find_features(iTeam1, iTeam2, '2014', '00');
    % Get labels
    score1 = thisScore(commas(2)+1:commas(3)-1);
    score2 = thisScore(commas(3)+1:end);
    score1 = eval(score1);
    score2 = eval(score2);
    if score2 > score1
        trainLabels(iGame,1) = 1;
    else
        trainLabels(iGame,1) = -1;
    end
    % Inc
    iGame = iGame + 1;
end

%% === Train model, weights ===
trainData(trainData ~= trainData) = 0;
if strcmp(lib, 'libsvm')
    model = svmtrain(trainLabels, trainData, args);
elseif strcmp(lib, 'liblin')
    model = lintrain(trainLabels, sparse(trainData), args);
end

%%
end
