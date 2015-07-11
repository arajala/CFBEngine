function [school stats] = CFB_html2csv_stats(str)
% Parent function: CFB_download_stats
% Child function:
%
% str - trimmed string from CFB_trim_stats
%

%% === HTML markers ===
schoolStartMarker1 = '/schools/';
schoolStartMarker2 = '>';
schoolEndMarker = '</a>';
statStartMarker = '<td>';
statEndMarker = '</td>';

%% === Find school name ===
% Find start and trim
iStart = strfind(str, schoolStartMarker1);
if isempty(iStart)
    school = '';
    stats = '';
    return
end
str = str(iStart:end);
iStart = strfind(str, schoolStartMarker2);
str = str(iStart+1:end);
% Find end
iEnd = strfind(str, schoolEndMarker);
% Find school name
school = str(1:iEnd-1);


%% === Find stat values ===
stats = '';
moreStats = true;
while moreStats
    % Find start and trim
    iStart = strfind(str, statStartMarker);
    if isempty(iStart)
        moreStats = false;
        continue
    end
    str = str(iStart+4:end);
    % Find end and stat
    iEnd = strfind(str, statEndMarker);
    thisStat = str(1:iEnd-1);
    stats = sprintf('%s%s,', stats, thisStat);
    str = str(iEnd+4:end);
end

%% === Trim the last comma ===
stats = stats(1:end-1);

%%
end
