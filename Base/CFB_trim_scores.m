function [trimmedStr originalStr] = CFB_trim_scores(originalStr)
% Parent function: CFB_download_scores
% Child function:
%
% originalStr - full html string from urlread
%

%% === HTML markers ===
gameStartMarker = '<section class="game';
gameEndMarker = '</section>';

%% === Find the start, or return '' ===
iStart = strfind(originalStr, gameStartMarker);
if isempty(iStart)
    trimmedStr = '';
    return
end

%% === Trim and find the end ===
originalStr = originalStr(iStart:end);
iEnd = strfind(originalStr, gameEndMarker);
if isempty(iEnd)
    iEnd = length(originalStr);
end

%% === Return the trimmed string for html2csv and original string===
trimmedStr = originalStr(1:iEnd);
originalStr = originalStr(iEnd:end);

%%
end
