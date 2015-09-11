function [trimmedStr originalStr] = CFB_trim_stats(originalStr)
% Parent function: CFB_download_stats
% Child function:
%
% originalStr - full html string from urlread
%

%% === HTML markers ===
statStartMarker = '<td>';
statEndMarker = '</tr>';

%% === Find the start, or return '' ===
iStart = strfind(originalStr, statStartMarker);
if isempty(iStart)
    trimmedStr = '';
    return
end

%% === Trim and find the end ===
originalStr = originalStr(iStart:end);
iEnd = strfind(originalStr, statEndMarker);
if isempty(iEnd)
    iEnd = length(originalStr);
end

%% === Return the trimmed string for html2csv and original string
trimmedStr = originalStr(1:iEnd);
originalStr = originalStr(iEnd:end);

%%
end
