function CFB_download(varargin)
% Parent function:
% Child functions: CFB_download_stats, CFB_download_scores
%
% For input guide, call CFB_download() with no inputs
%

%% === Parse input ===
opt = CFB_parse_varargin(varargin);
if isempty(opt)
    return
end

%% === Read stats ===
nPages = 3;
if opt.stats.download
    % Open the teamStat files
    teamStatUrls = fopen('../teamStatUrls.cfb', 'r');
    teamStatNames = fopen('../teamStatNames.cfb', 'r');
    % Loop through stats from file
    moreStats = true;
    while moreStats
        % Grab the next name and url from file
        thisStatUrl = fgetl(teamStatUrls);
        thisStatName = fgetl(teamStatNames);
        thisFileName = sprintf('%s-%s-%s', thisStatName, opt.stats.year, opt.stats.week);
        % Check for EOF
        if thisStatUrl == -1
            moreStats = false;
            continue
        end
        % Download from the full URL
        if strcmp(opt.stats.year, '2014')
            statYear = 'current';
        else
            statYear = opt.stats.year;
        end
        thisFullUrl = sprintf('http://www.ncaa.com/stats/football/fbs/%s/team/%s', statYear, thisStatUrl);
        fprintf('Downloading stat %s\n', thisStatName);
        CFB_download_stats(thisFileName, thisFullUrl, nPages, opt.stats.print);
    end
    % Clean up
    fclose(teamStatUrls);
    fclose(teamStatNames);
end

%% === Read scores ===
if opt.scores.download
    for iWeek = 1:opt.scores.nWeeks
        thisFile = sprintf('Scores-%s-%s.cfb', opt.scores.year, opt.scores.weeks(iWeek,:));
        thisUrl = sprintf('http://www.ncaa.com/scoreboard/football/fbs/%s/%s', opt.scores.year, opt.scores.weeks(iWeek,:));
        CFB_download_scores(thisFile, thisUrl, opt.scores.print);
    end
end

%% === Read injuries ===
if opt.injuries.download
    fprintf('derp this doesnt work yet\n');
end

%%
end
