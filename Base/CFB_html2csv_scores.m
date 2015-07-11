function score = CFB_html2csv_scores(str)
% Parent function: CFB_download_scores
% Child function:
%
% str - trimmed string from CFB_trim_scores
%

%% === HTML markers ===
teamStartMarker = '<h3>';
teamMidMarker = ' vs ';
teamEndMarker = '</h3>';
dummyTeam = '{{away.nameRaw}}';
gameStatusStartMarker1 = 'div class="game-status';
gameStatusStartMarker2 = '">';
gameStatusEndMarker = '</div';
lineScoreMarker = '<table class="linescore">';
finalScoreStartMarker = '<td class="final score">';
finalScoreEndMarker = '</td>';
scoreOffset = 24;

%% === Find team names ===
% Find start and trim
iStart = strfind(str, teamStartMarker);
if isempty(iStart)
    score = '';
    return
end
str = str(iStart+4:end);
% Find middle and end of team names
iMid = strfind(str, teamMidMarker);
iEnd = strfind(str, teamEndMarker);
% Separate team names
team1 = str(1:iMid-1);
team2 = str(iMid+4:iEnd-1);
% Check for dummy html
if strcmp(team1, dummyTeam)
    score = '';
    return
end

%% === Find game status ===
% Find start and trim
iStart = strfind(str, gameStatusStartMarker1);
str = str(iStart:end);
iStart = strfind(str, gameStatusStartMarker2);
str = str(iStart+2:end);
% Find end
iEnd = strfind(str, gameStatusEndMarker);
% Find game status
gameStatus = str(1:iEnd-1);

%% === Find scores ===
if strncmp(gameStatus, 'Final', 5)
    % Find score1 start and trim
    iStart = strfind(str, lineScoreMarker);
    str = str(iStart:end);
    iStart = strfind(str, finalScoreStartMarker);
    str = str(iStart+scoreOffset:end);
    % Find score1 end and score1
    iEnd = strfind(str, finalScoreEndMarker);
    score1 = str(1:iEnd-1);
    % Find score2 start and trim
    iStart = strfind(str, finalScoreStartMarker);
    str = str(iStart+scoreOffset:end);
    % Find score2 end and score2
    iEnd = strfind(str, finalScoreEndMarker);
    score2 = str(1:iEnd-1);
else
    score1 = 'NA';
    score2 = 'NA';
end

%% === Return score string ===
score = sprintf('%s,%s,%s,%s', team1, team2, score1, score2);

%%
end
