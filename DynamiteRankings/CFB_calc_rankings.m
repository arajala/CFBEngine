function CFB_calc_rankings(year, week)
%
addpath ../Base

%% === Read in overall data ===
dataFile = sprintf('OverallData-%s-%s.cfb', year, week);
data = csvread(dataFile);
calcStatsFile = sprintf('../Stats/CalculatedStats-%s-%s.cfb', year, week);
stats = csvread(calcStatsFile);

%% === Set min strength at 0 ===
strengths = data(:,1);
kStrengths = strengths - min(strengths);

%% === Calculate rank points ===
ranks = kStrengths .* (stats(:,2)+2) ./ (stats(:,1)+4);
[sRanks iRanks] = sort(ranks, 1, 'descend');
nRanks = length(iRanks);
jRanks = zeros(nRanks, 1);
for j = 1:nRanks
    jRanks(j,1) = find(iRanks == j);
end

%% === Find previous ranks and deltas ===
NTEAMS = 129;
if eval(week) == 0
    iPvsRanks = zeros(NTEAMS, 1);
else
    lastWeek = sprintf('0%d', eval(week)-1);
    if length(lastWeek) == 3
        lastWeek = lastWeek(2:3);
    end
    pvsFile = sprintf('OverallRankings-%s-%s.cfb', year, lastWeek);
    pvsData = csvread(pvsFile);
    iPvsRanks = pvsData(:,1);
end

%% === Make full rankings ===
strengths = data(:,1);
stds = data(:,2);
overallRankings = [jRanks, iPvsRanks, iPvsRanks-jRanks, ranks, strengths, stds];
rankFile = sprintf('OverallRankings-%s-%s.cfb', year, week);
csvwrite(rankFile, overallRankings);

%% === Format sorted ranks for printing ===
sortedRanks = '';
for i = 1:nRanks
    iTeam = iRanks(i);
    team = CFB_reverse_lookup(iTeam, year);
    if team == -1
        team = 'FCS';
    end
    sortedRanks = sprintf('%sRk: %d Pvs: %d D: %d Team: %s Pts: %.1f Points: %.1f SD: %.1f\n', ...
        sortedRanks, i, iPvsRanks(iTeam), iPvsRanks(iTeam)-i, team, sRanks(i), strengths(iTeam), stds(iTeam));
end
fprintf('%s', sortedRanks);
sortedFile = sprintf('SortedRankings-%s-%s.cfb', year, week);
sortedFid = fopen(sortedFile, 'w');
fprintf(sortedFid, sortedRanks);
fclose(sortedFid);

%%
end
