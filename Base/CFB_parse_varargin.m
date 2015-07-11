function opt = CFB_parse_varargin(varargin)
% Parent function: CFB_download
% Child function:
%

%% === Fix varargin ===
varargin = varargin{1};

%% === Display help ===
if isempty(varargin)
    help = sprintf('Possible arguments:\n');
    help = sprintf('%s\tTo download a category:\n', help);
    help = sprintf('%s\t\t''stats <year> <week>''\n',  help);
    help = sprintf('%s\t\t''scores <year> <week>''\n', help);
    help = sprintf('%s\t\t''injuries''\n', help);
    help = sprintf('%s\tTo print out the results after downloading:\n', help);
    help = sprintf('%s\t\t''-p stats''\n', help);
    help = sprintf('%s\t\t''-p scores''\n', help);
    help = sprintf('%s\t\t''-p injuries''\n', help);
    fprintf('%s', help);
    opt = [];
    return
end

%% === Set defaults ===
opt.stats.download = 0;
opt.stats.year = '';
opt.stats.print = 0;
opt.scores.download = 0;
opt.scores.year = '';
opt.scores.nWeeks = 1;
opt.scores.weeks = '';
opt.scores.print = 0;
opt.injuries.download = 0;
opt.injuries.print = 0;
currYear = 2014;
currWeek = 1;

%% === Parse inputs ===
for iArg = 1:length(varargin)
    spaces = find(isspace(varargin{iArg}));
    nSpaces = length(spaces);
    if nSpaces > 0
        flag = varargin{iArg}(1:spaces(1)-1);
        val = varargin{iArg}(spaces(1)+1:end);
    else
        flag = varargin{iArg};
        val = '';
    end
    switch lower(flag)
        case 'stats'
            if strcmp(val, '')
                fprintf('No stats year-week specified, using %s-%s\n', currYear, currWeek);
                year = currYear;
                week = currWeek;
            else
                year = varargin{iArg}(spaces(1)+1:spaces(2)-1);
                week = varargin{iArg}(spaces(2)+1:end);
            end
            opt.stats.download = 1;
            opt.stats.year = year;
            opt.stats.week = week;
        case 'scores'
            if nSpaces == 0
                fprintf('No scores year-date specified, using %s-%s\n', currYear, currWeek);
                year = currYear;
                week = currWeek;
            else
                year = varargin{iArg}(spaces(1)+1:spaces(2)-1);
                week = varargin{iArg}(spaces(2)+1:end);
            end
            opt.scores.download = 1;
            opt.scores.year = year;
            opt.scores.weeks = week;
        case 'injuries'
            if nSpaces == 0
                fprintf('No injury year-week specified, using %s-%s\n', currYear, currWeek);
                year = currYear;
                week = currWeek;
            else
                year = varargin{iArg}(spaces(1)+1:spaces(2)-1);
                week = varargin{iArg}(spaces(2)+1:end);
            end
            opt.injuries.download = 1;
            opt.injuries.year = year;
            opt.injuries.week = week;
        case '-p'
            switch val
                case 'stats'
                    opt.stats.print = 1;
                case 'scores'
                    opt.scores.print = 1;
                case 'injuries'
                    opt.injuries.print = 1;
            end
    end
end

%%
end