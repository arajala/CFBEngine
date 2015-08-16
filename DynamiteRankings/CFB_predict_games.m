function CFB_predict_games(year, week)
%
addpath ../Base

%% === Parameters ===
homeFieldAdvantage = 4;

%% === Load overall strengths from previous week ===
lastWeek = sprintf('%d', eval(week)-1);
if length(lastWeek) == 1
    lastWeek = sprintf('0%s', lastWeek);
end
file = sprintf('OverallRankings-%s-%s.cfb', year, lastWeek);
if strcmp(week, '01')
    lastYear = sprintf('%d', eval(year)-1);
    file = sprintf('OverallRankings-%s-%s.cfb', lastYear, '16');
end
overallRankings = csvread(file);

%% === Load scores from this week ===
if length(week) == 1
    thisWeek = sprintf('0%s', week);
else
    thisWeek = week;
end
file = sprintf('../Scores/Scores-%s-%s.cfb', year, thisWeek);
fid = fopen(file);
moreScores = true;
predictions = '';
while moreScores
    thisScore = fgetl(fid);
    if thisScore == -1
        moreScores = false;
        continue
    end
    % Look up team strengths
    commas = find(thisScore == ',');
    team1 = thisScore(1:commas(1)-1);
    team2 = thisScore(commas(1)+1:commas(2)-1);
    iTeam1 = CFB_lookup(team1);
    iTeam2 = CFB_lookup(team2);    
    strength1 = overallRankings(iTeam1,5);
    strength2 = overallRankings(iTeam2,5);
    % Pick and announce a winner
    if strength2+homeFieldAdvantage >= strength1
        winner = team2;
        winScore = strength2+homeFieldAdvantage - strength1;
    else
        winner = team1;
        winScore = strength1 - (strength2+homeFieldAdvantage);
    end
	  interest = overallRankings(iTeam1,4)+overallRankings(iTeam2,4)-winScore;
    predictions = sprintf('%s%.1f, %s @ %s, %s, %.1f\n', predictions, interest, team1, team2, winner, winScore);
    fprintf('Game: %s @ %s, Predicted Winner: %s by %.1f points\n', team1, team2, winner, winScore);
end

%% === Print predictions to file ===
predictionsFile = sprintf('Predictions-%s-%s.cfb', year, thisWeek);
predictionsFid = fopen(predictionsFile, 'w');
fprintf(predictionsFid, '%s', predictions);

%% === Clean up ===
fclose(fid);
fclose(predictionsFid);

%%
end
