function teamIndex = CFB_lookup(teamStr, year)
% Parent function:
% Child function:
%

%% === Open the team master list ===
fid = fopen(sprintf('..\teams-%s.cfb', year), 'r');
originalStr = teamStr;

%% === Remove punctuation ===
teamStr = CFB_lookup_rmPunct(teamStr);

%% === Correct general abbreviations ===
teamStr = CFB_lookup_correctGeneral(teamStr);

%% === Correct specific abbreviations ===
teamStr = CFB_lookup_correctSpecific(teamStr);

%% === Search for a match ===
teamIndex = 1;
moreTeams = true;
while moreTeams
    thisTeam = fgetl(fid);
    if thisTeam == -1
        moreTeams = false;
        continue
    end
    if strcmp(thisTeam, teamStr)
        %fprintf('Matching %s to %s - Take action if not correct.\n', originalStr, thisTeam);
        fclose(fid);
        return
    end
    teamIndex = teamIndex + 1;
end

%% === FCS teams are the last index, not in file ===
%fprintf('No match for %s via %s was found, must be FCS team - Take action if not correct.\n', originalStr, teamStr);
fclose(fid);

%%
end

%%
function teamStr = CFB_lookup_correctSpecific(teamStr)
%%

if strcmp(teamStr, 'FloridaAtlantic')
    teamStr = 'FlaAtlantic';
elseif strcmp(teamStr, 'USC')
    teamStr = 'SouthernCalifornia';
elseif strcmp(teamStr, 'Connecticut')
    teamStr = 'UConn';
elseif strcmp(teamStr, 'SouthAlabama')
    teamStr = 'SouthAla';
elseif strcmp(teamStr, 'MiamiOhio')
    teamStr = 'MiamiOH';
elseif strcmp(teamStr, 'MiamiFla')
    teamStr = 'MiamiFL';
elseif strcmp(teamStr, 'TexasSanAntonio')
    teamStr = 'UTSA';
elseif strcmp(teamStr, 'NCSt')
    teamStr = 'NorthCarolinaSt';
elseif strcmp(teamStr, 'CentMichigan')
    teamStr = 'CentralMich';
elseif strcmp(teamStr, 'WesternKentucky')
    teamStr = 'WesternKy';
elseif strcmp(teamStr, 'Mississippi')
    teamStr = 'OleMiss';
elseif strcmp(teamStr, 'GaSouthern')
    teamStr = 'GeorgiaSouthern';
elseif strcmp(teamStr, 'WKentucky')
    teamStr = 'WesternKy';
elseif strcmp(teamStr, 'MiddleTennSt')
    teamStr = 'MiddleTenn';
elseif strcmp(teamStr, 'NCarolina')
    teamStr = 'NorthCarolina';
elseif strcmp(teamStr, 'NorthernIllinois')
    teamStr = 'NorthernIll';
elseif strcmp(teamStr, 'WMichigan')
    teamStr = 'WesternMich';
elseif strcmp(teamStr, 'SDiegoSt')
    teamStr = 'SanDiegoSt';
elseif strcmp(teamStr, 'BostonColl')
    teamStr = 'BostonCollege';
elseif strcmp(teamStr, 'NMexSt')
    teamStr = 'NewMexicoSt';
elseif strcmp(teamStr, 'LaLafayet')
    teamStr = 'LaLafayette';
elseif strcmp(teamStr, 'UMass')
    teamStr = 'Massachusetts';
elseif strcmp(teamStr, 'FloridaIntl')
    teamStr = 'FIU';
elseif strcmp(teamStr, 'LAMonroe')
    teamStr = 'LaMonroe';
elseif strcmp(teamStr, 'EastMichigan')
    teamStr = 'EasternMich';
end

%%
end
%%

%%
function teamStr = CFB_lookup_correctGeneral(teamStr)
%%

% Correct 'State' to 'St'
iState = strfind(teamStr, 'State');
if ~isempty(iState)
    teamStr(iState:iState+4) = 'St   ';
    teamStr(teamStr == ' ') = '';
end
% Correct '* Florida' to '* Fla'
iFlorida = strfind(teamStr, 'Florida');
if ~isempty(iFlorida) && iFlorida ~= 1
    teamStr(iFlorida:iFlorida+6) = 'Fla    ';
    teamStr(teamStr == ' ') = '';
end

%%
end
%%

%%
function teamStr = CFB_lookup_rmPunct(teamStr)
%%

teamStr(teamStr == ' ') = '';
teamStr(teamStr == '.') = '';
teamStr(teamStr == '-') = '';
teamStr(teamStr == '(') = '';
teamStr(teamStr == ')') = '';
teamStr(teamStr == '&') = '';

%%
end

