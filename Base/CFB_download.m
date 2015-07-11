function CFB_download(varargin)
% For input guide, call CFB_download_2() with no inputs
%

%% === Parse input ===
opt = CFB_parse_varargin(varargin);
if isempty(opt)
    return
end

%% === Read scores ===
if opt.scores.download
    for iWeek = 1:opt.scores.nWeeks
        thisFile = sprintf('Scores-%s-%s.cfb', opt.scores.year, opt.scores.weeks(iWeek,:));
        thisUrl = sprintf('http://www.ncaa.com/scoreboard/football/fbs/%s/%s', opt.scores.year, opt.scores.weeks(iWeek,:));
        CFB_download_scores(thisFile, thisUrl, opt.scores.print);
    end
end

%% === Read stats ===
if opt.stats.download
    CFB_download_stats(opt.stats.year, opt.stats.week, opt.stats.print);
	CFB_calc(opt.stats.year, opt.stats.week);
end

%% === Read injuries ===
if opt.injuries.download
    fprintf('derp this doesnt work yet\n');
end

%%
end
