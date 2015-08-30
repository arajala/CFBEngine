function CFB_calc_rankings(model, lib, year, week)
%
addpath ../Base

%% === Calculate weights ===
if strcmp(lib, 'libsvm')
    weights = CFB_calc_weights(model);
elseif strcmp(lib, 'liblin')
    weights = model.w;
end

%% === Get features ===
NTEAMS = 129;
NOTEAM = 135;
features = zeros(NTEAMS, 154);
for iTeam = 1:NTEAMS
    features(iTeam,:) = CFB_find_features(iTeam, NOTEAM, year, week);
end

%% === Use features to calculate team score ===
ranks = features * weights';
[sRanks iRanks] = sort(ranks, 1, 'ascend');

%% === Print rankings ===
rankFile = sprintf('Rankings-%s-%s.cfb', year, week);
csvwrite(rankFile, ranks);
nTeams = size(sRanks, 1);
rankStr = '';
for iTeam = 1:nTeams
    team = CFB_reverse_lookup(iRanks(iTeam), year);
    if team == -1
        team = 'FCS';
    end
    rankStr = sprintf('%s%s: %.4f\n', rankStr, team, sRanks(iTeam));
end
fprintf('%s', rankStr);
sRankFile = sprintf('SortedRankings-%s-%s.cfb', year, week);
fid = fopen(sRankFile, 'w');
fprintf(fid, '%s', rankStr);
fclose(fid);

%%
end
