function [school stats] = CFB_html2csv_stats(str)
%

%% === HTML markers ===
schoolStartMarker = '/teams/';
schoolEndMarker = '</a>';
statStartMarker = ' class="yspscores';
statStartMarker2 = '">';
statEndMarker = '</';

%% === Find school name ===
% Find start and trim
iStart = strfind(str, schoolStartMarker);
if isempty(iStart)
    school = '';
    stats = '';
    return
end
str = str(iStart+12:end);
% Find end
iEnd = strfind(str, schoolEndMarker);
% Find school name
school = str(1:iEnd-1);
str = str(iEnd+8:end);

%% === Find stat values ===
stats = '';
moreStats = true;
while moreStats
    iStart = strfind(str, statStartMarker);
    if isempty(iStart)
        moreStats = false;
        continue
    end
    str = str(iStart:end);
    iStart = strfind(str, statStartMarker2);
    str = str(iStart+2:end);
    iEnd = strfind(str, statEndMarker);
    thisStat = str(1:iEnd-1);
    if strcmp(thisStat, '&nbsp;')
        continue
    end
    stats = sprintf('%s%s,', stats, thisStat);
    str = str(iEnd+4:end);
end

%% === Minor fixes ===
% Replace N/A's with 0s
iNA = strfind(stats, 'N/A');
nNA = length(iNA);
for i = 1:nNA
    stats = sprintf('%s0%s', stats(1:iNA(i)-1), stats(iNA(i)+3:end));
end
% Convert mm:ss TOP to minutes
iCln = strfind(stats, ':');
if ~isempty(iCln)
    mins = eval(stats(iCln-2:iCln-1)) * 60 + eval(stats(iCln+1:iCln+2));
    stats = sprintf('%s%d%s', stats(1:iCln-3), mins, stats(iCln+3:end));
end
% Trim last comma
stats = stats(1:end-1);

%%
end
