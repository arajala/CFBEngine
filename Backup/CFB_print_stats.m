function CFB_print_stats(file, allStats, printStats, saveTeams)
% Parent function: CFB_download_stats
% Child function:
%
% file - the full filename to save stats in
%
% allStats - the cell array with both teamnames and statistics
%
% printTeams - binary toggle to print alhapbetical teams.cfb master list
%

%% === Sort the statistics ===
allStats = sortrows(allStats);

%% === Open the file ===
fid = fopen(file, 'w');

%% === Print only the statistics ===
% Create string
STAT = 2;
nStats = size(allStats, 1);
stats = '';
for iStat = 1:nStats
    stats = sprintf('%s%s\n', stats, allStats{iStat,STAT});
end
% Print to file
fprintf(fid, '%s', stats);
% Print to command window
if printStats
    fprintf('%s', stats);
end

%% === Close the file ===
fclose(fid);

%% === Print only the teams ===
if saveTeams
    SCHOOL = 1;
    teams = '';
    fid = fopen('../teams.cfb', 'w');
    for iStat = 1:nStats
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == ' ') = '';
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == '.') = '';
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == '-') = '';
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == '(') = '';
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == ')') = '';
        allStats{iStat,SCHOOL}(allStats{iStat,SCHOOL} == '&') = '';
        teams = sprintf('%s%s\n', teams, allStats{iStat,SCHOOL});
    end
    fprintf(fid, '%s', teams);
    fclose(fid);
end

%%
end
