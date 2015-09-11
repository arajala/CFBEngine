function [school stats] = CFB_html2csv_stats(str)
%

%% === HTML markers ===
schoolStartMarker = '.html';
schoolEndMarker = '</a>';
statStartMarker = '<td>';
statEndMarker = '</td>';

%% === Find school name ===
% Find start and trim
iStart = strfind(str, schoolStartMarker);
if isempty(iStart)
    school = '';
    stats = '';
    return
end
str = str(iStart+7:end);
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
    str = str(iStart+4:end);
    iEnd = strfind(str, statEndMarker);
    thisStat = str(1:iEnd-1);
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
while ~isempty(iCln)
    thisCln = iCln(1);
    mins = eval(stats(thisCln-2:thisCln-1)) * 60 + eval(stats(thisCln+1:thisCln+2));
    stats = sprintf('%s%d%s', stats(1:thisCln-3), mins, stats(thisCln+3:end));
    iCln = strfind(stats, ':');
end
% Trim last comma
stats = stats(1:end-1);

%%
end
