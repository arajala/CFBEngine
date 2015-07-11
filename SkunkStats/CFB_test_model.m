function [p15 pe15] = CFB_test_model(model, lib)
%
addpath ../Base
addpath C:\libsvm-3.18\matlab
addpath C:\liblinear-1.94\matlab

%% === Read in scores and stats ===
% fid12 = fopen('../Scores/Scores-2013-12.cfb', 'r');
% fidBO = fopen('../Scores/Scores-2013-17.cfb', 'r');
fid15 = fopen('../Scores/Scores-2014-07.cfb', 'r');
% % Predict week 12 year 2013
% moreScores = true;
% mov12 = zeros(0,1);
% testData12 = zeros(0, 0);
% testLabels12 = zeros(0, 1);
% iGame = 1;
% while moreScores
%     thisScore = fgetl(fid12);
%     if thisScore == -1
%         moreScores = false;
%         continue
%     end
%     % Lookup team index
%     commas = find(thisScore == ',');
%     team1 = thisScore(1:commas(1)-1);
%     team2 = thisScore(commas(1)+1:commas(2)-1);
%     iTeam1 = CFB_lookup(team1);
%     iTeam2 = CFB_lookup(team2);
%     % Get data features
%     testData12(iGame,:) = CFB_find_features(iTeam1, iTeam2, '2014', '00');
%     % Get labels
%     score1 = thisScore(commas(2)+1:commas(3)-1);
%     score2 = thisScore(commas(3)+1:end);
%     score1 = eval(score1);
%     score2 = eval(score2);
%     if score2 > score1
%         testLabels12(iGame,1) = 1;
%     else
%         testLabels12(iGame,1) = -1;
%     end
%     % Record margin of victory for evaluation
%     mov12(iGame,1) = score2 - score1;
%     % Inc
%     iGame = iGame + 1;
% end
% % Predict bowl week
% moreScores = true;
% movBO = zeros(0, 1);
% testDataBO = zeros(0, 0);
% testLabelsBO = zeros(0, 1);
% iGame = 1;
% while moreScores
%     thisScore = fgetl(fidBO);
%     if thisScore == -1
%         moreScores = false;
%         continue
%     end
%     % Lookup team index
%     commas = find(thisScore == ',');
%     team1 = thisScore(1:commas(1)-1);
%     team2 = thisScore(commas(1)+1:commas(2)-1);
%     iTeam1 = CFB_lookup(team1);
%     iTeam2 = CFB_lookup(team2);
%     % Get data features
%     testDataBO(iGame,:) = CFB_find_features(iTeam1, iTeam2, '2014', '00');
%     % Get labels
%     score1 = thisScore(commas(2)+1:commas(3)-1);
%     score2 = thisScore(commas(3)+1:end);
%     score1 = eval(score1);
%     score2 = eval(score2);
%     if score2 > score1
%         testLabelsBO(iGame,1) = 1;
%     else
%         testLabelsBO(iGame,1) = -1;
%     end
%     % Record margin of victory for evaluation
%     movBO(iGame,1) = score2 - score1;
%     % Inc
%     iGame = iGame + 1;
% end
% Predict week 15 year 2014
moreScores = true;
mov15 = zeros(0, 1);
testData15 = zeros(0, 0);
testLabels15 = zeros(0, 1);
iGame = 1;
while moreScores
    thisScore = fgetl(fid15);
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
    testData15(iGame,:) = CFB_find_features(iTeam1, iTeam2, '2014', '7');
    % Get labels
    score1 = thisScore(commas(2)+1:commas(3)-1);
    score2 = thisScore(commas(3)+1:end);
    try
        score1 = eval(score1);
        score2 = eval(score2);
    catch
        disp('Warning: N/A score, skipping')
        continue
    end
    if score2 > score1
        testLabels15(iGame,1) = 1;
    else
        testLabels15(iGame,1) = -1;
    end
    % Record margin of victory for evaluation
    mov15(iGame,1) = score2 - score1;
    % Inc
    iGame = iGame + 1;
end

%% === Test model ===
if strcmp(lib, 'libsvm')
%    [pl12 a12 pe12] = svmpredict(testLabels12, testData12, model, '-b 1');
%     [plBO aBO peBO] = svmpredict(testLabelsBO, testDataBO, model, '-b 1');
    [p15 a15 pe15] = svmpredict(testLabels15, testData15, model, '-b 0');
elseif strcmp(lib, 'liblin')
%    [pl12 a12 pe12] = linpredict(testLabels12, sparse(testData12), model, '-b 1');
%     [plBO aBO peBO] = linpredict(testLabelsBO, sparse(testDataBO), model, '-b 1');
    [pl15 a15 pe15] = linpredict(testLabels15, sparse(testData15), model, '-b 1');
end

%% === Evaluate test results ===
% nGames12 = size(pe12,1);
% score12 = 0;
% for iGame = 1:nGames12
%     if abs(mov12(iGame,1)) <= 7
%         if abs(pe12(iGame,1)-0.5) < 0.05
%             score12 = score12 + 5;
%         elseif abs(pe12(iGame,1)-0.5) < 0.10
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.15
%             score12 = score12 + 1;
%         end
%     end
%     if pl12(iGame,1) ~= testLabels12(iGame,1)
%         score12 = score12 - 5;
%         continue
%     end
%     if abs(mov12(iGame,1)) <= 14
%         if abs(pe12(iGame,1)-0.5) < 0.05
%             score12 = score12 + 1;
%         elseif abs(pe12(iGame,1)-0.5) < 0.10
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.15
%             score12 = score12 + 5;
%         elseif abs(pe12(iGame,1)-0.5) < 0.20
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.25
%             score12 = score12 + 1;
%         end
%     elseif abs(mov12(iGame,1)) <= 21
%         if abs(pe12(iGame,1)-0.5) < 0.10 && abs(pe12(iGame,1)-0.5) > 0.05
%             score12 = score12 + 1;
%         elseif abs(pe12(iGame,1)-0.5) < 0.15 && abs(pe12(iGame,1)-0.5) > 0.10
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.20 && abs(pe12(iGame,1)-0.5) > 0.15
%             score12 = score12 + 5;
%         elseif abs(pe12(iGame,1)-0.5) < 0.25 && abs(pe12(iGame,1)-0.5) > 0.20
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.30 && abs(pe12(iGame,1)-0.5) > 0.25
%             score12 = score12 + 1;
%         end
%     else
%         if abs(pe12(iGame,1)-0.5) < 0.15 && abs(pe12(iGame,1)-0.5) > 0.10
%             score12 = score12 + 1;
%         elseif abs(pe12(iGame,1)-0.5) < 0.20 && abs(pe12(iGame,1)-0.5) > 0.15
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.25 && abs(pe12(iGame,1)-0.5) > 0.20
%             score12 = score12 + 5;
%         elseif abs(pe12(iGame,1)-0.5) < 0.30 && abs(pe12(iGame,1)-0.5) > 0.25
%             score12 = score12 + 3;
%         elseif abs(pe12(iGame,1)-0.5) < 0.35 && abs(pe12(iGame,1)-0.5) > 0.30
%             score12 = score12 + 1;
%         end
%     end
% end
% nGamesBO = size(peBO,1);
% scoreBO = 0;
% for iGame = 1:nGamesBO
%     if abs(movBO(iGame,1)) <= 7
%         if abs(peBO(iGame,1)-0.5) < 0.05
%             scoreBO = scoreBO + 5;
%         elseif abs(peBO(iGame,1)-0.5) < 0.10
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.15
%             scoreBO = scoreBO + 1;
%         end
%     end
%     if plBO(iGame,1) ~= testLabelsBO(iGame,1)
%         scoreBO = scoreBO - 5;
%         continue
%     end
%     if abs(movBO(iGame,1)) <= 14
%         if abs(peBO(iGame,1)-0.5) < 0.05
%             scoreBO = scoreBO + 1;
%         elseif abs(peBO(iGame,1)-0.5) < 0.10
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.15
%             scoreBO = scoreBO + 5;
%         elseif abs(peBO(iGame,1)-0.5) < 0.20
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.25
%             scoreBO = scoreBO + 1;
%         end
%     elseif abs(movBO(iGame,1)) <= 21
%         if abs(peBO(iGame,1)-0.5) < 0.10 && abs(peBO(iGame,1)-0.5) > 0.05
%             scoreBO = scoreBO + 1;
%         elseif abs(peBO(iGame,1)-0.5) < 0.15 && abs(peBO(iGame,1)-0.5) > 0.10
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.20 && abs(peBO(iGame,1)-0.5) > 0.15
%             scoreBO = scoreBO + 5;
%         elseif abs(peBO(iGame,1)-0.5) < 0.25 && abs(peBO(iGame,1)-0.5) > 0.20
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.30 && abs(peBO(iGame,1)-0.5) > 0.25
%             scoreBO = scoreBO + 1;
%         end
%     else
%         if abs(peBO(iGame,1)-0.5) < 0.15 && abs(peBO(iGame,1)-0.5) > 0.10
%             scoreBO = scoreBO + 1;
%         elseif abs(peBO(iGame,1)-0.5) < 0.20 && abs(peBO(iGame,1)-0.5) > 0.15
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.25 && abs(peBO(iGame,1)-0.5) > 0.20
%             scoreBO = scoreBO + 5;
%         elseif abs(peBO(iGame,1)-0.5) < 0.30 && abs(peBO(iGame,1)-0.5) > 0.25
%             scoreBO = scoreBO + 3;
%         elseif abs(peBO(iGame,1)-0.5) < 0.35 && abs(peBO(iGame,1)-0.5) > 0.30
%             scoreBO = scoreBO + 1;
%         end
%     end
% end
% score = (score12 * nGames12 + scoreBO * nGamesBO) / (nGames12 + nGamesBO);

%% === Clean up ===
% fclose(fid12);
% fclose(fidBO);
fclose(fid15);

%%
end