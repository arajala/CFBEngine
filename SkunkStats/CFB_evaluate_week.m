function predictions = CFB_evaluate_week(year, week)
%
addpath ../Base

%% === Open predictions file and score file ===
predFile = sprintf('Predictions-%s-%s_m5.cfb', year, week);
scoreFile = sprintf('../Scores/Scores-%s-%s.cfb', year, week);
scoreFid = fopen(scoreFile, 'r');

%% === Loop through scores and check predictions ===
nFinalGames = 0;
nTBDGames = 0;
predictions = [0; 0];
moreScores = true;
while moreScores
    % Reopen predictions every round
    predFid = fopen(predFile, 'r');
    thisScore = fgetl(scoreFid);
    if thisScore == -1
        moreScores = false;
        continue
    end
    % Lookup team index
    commas = find(thisScore == ',');
    team1 = thisScore(1:commas(1)-1);
    team2 = thisScore(commas(1)+1:commas(2)-1);
    iTeam1 = CFB_lookup(team1, year);
    iTeam2 = CFB_lookup(team2, year);
    score1 = thisScore(commas(2)+1:commas(3)-1);
    score2 = thisScore(commas(3)+1:end);
    % Find scores
    if strcmp(score1, 'NA') || strcmp(score2, 'NA')
        nTBDGames = nTBDGames + 1;
    else
        score1 = eval(score1);
        score2 = eval(score2);
        % Find predictions
        morePreds = true;
        while morePreds
            thisPred = fgetl(predFid);
            if thisPred == -1
                fprintf('Could not find prediction for %s @ %s.\n', team1, team2);
                morePreds = false;
                continue
            end
            iAt = strfind(thisPred, ' @ ');
            iComma = strfind(thisPred, ',');
            iPredTeam1 = CFB_lookup(thisPred(1:iAt), year);
            iPredTeam2 = CFB_lookup(thisPred(iAt+3:iComma(1)-1), year);
            if iTeam1 == iPredTeam1 && iTeam2 == iPredTeam2
                iWinner = strfind(thisPred, ':');
                iPredWinner = CFB_lookup(thisPred(iWinner+2:iComma(2)-1), year);
                if score2 > score1 && iPredWinner == iTeam2
                    fprintf('Prediction RIGHT: %s @ %s, winner: %s.\n', team1, team2, team2);
                    predictions(1) = predictions(1) + 1;
                elseif score1 > score2 && iPredWinner == iTeam1
                    fprintf('Prediction RIGHT: %s @ %s, winner: %s.\n', team1, team2, team1);
                    predictions(1) = predictions(1) + 1;
                elseif score2 > score1 && iPredWinner == iTeam1
                    fprintf('Prediction WRONG: %s @ %s, winner: %s.\n', team1, team2, team2);
                    predictions(2) = predictions(2) + 1;
                elseif score1 > score2 && iPredWinner == iTeam2
                    fprintf('Prediction WRONG: %s @ %s, winner: %s.\n', team1, team2, team1);
                    predictions(2) = predictions(2) + 1;
                else
                    fprintf('Prediction WRONG: %s @ %s, winner: TIE.\n', team1, team2);
                    predictions(2) = predictions(2) + 1;
                end
                break
            end
        end
        nFinalGames = nFinalGames + 1;
    end
    % Close the predictions to reopen again
    fclose(predFid);
end

%% === Print results to console ===
fprintf('%d games played, predictions: %d-%d. %d games left.\n', ...
    nFinalGames, predictions(1), predictions(2), nTBDGames);

%% === Clean up ===
fclose(scoreFid);

%%
end
