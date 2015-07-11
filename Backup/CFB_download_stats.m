function CFB_download_stats(file, url, nPages, print)
% Parent function: CFB_download
% Child functions: CFB_trim_stats, CFB_html2csv_stats
%
% file - .cfb file to save results
%
% url - web address to team statistics
%
% nPages - number of pages of statistics to parse
%
% print - toggle printing results to command window
%

%% === Ensure URL starts with http://, not www. ===
if ~strncmp(url, 'http://', 7)
    url = sprintf('%s%s', 'http://', url);
end

%% === Read in all statistics ===
SCHOOL = 1;
STAT = 2;
allStats = cell(1, 2);
nStats = 0;
for iPage = 1:nPages
    % Add page number to url
    fullUrl = sprintf('%s/p%d', url, iPage);
    % Read the url
    try
        str = urlread(fullUrl);
    catch
        fprintf('Error reading URL %s, skipping\n', fullUrl);
        continue
    end
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        iTeam = CFB_lookup(school);
        allStats{iTeam,SCHOOL} = school;
        allStats{iTeam,STAT} = stats;
        nStats = numel(find(stats == ',')) + 1;
    end
end

%% === Fill in missing teams ===
NTEAMS = 129 - 1;
for iTeam = 1:NTEAMS
    if size(allStats, 1) < iTeam || isempty(allStats{iTeam,SCHOOL})
        allStats{iTeam,SCHOOL} = CFB_reverse_lookup(iTeam);
        statStr = '';
        for iStat = 1:nStats
            statStr = sprintf('%s%s,', statStr, '0');
        end
        statStr = statStr(1:end-1);
        allStats{iTeam,STAT} = statStr;
    end
end

%% === Ensure filename has .cfb extension ===
if isempty(strfind(file, '.cfb'))
    file = sprintf('%s%s', file, '.cfb');
end

%% === Ensure filename has ../Stats/ directory ===
if isempty(strfind(file, '/Stats/'))
    file = sprintf('%s%s', '../Stats/', file);
end

%% === Print stats to file ===
CFB_print_stats(file, allStats, print, 0);

%%
end
