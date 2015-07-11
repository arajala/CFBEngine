function homeFieldCorrs = CFB_find_homeFieldCorrs(year, week)
%
addpath ../Base

%% === Parse scores for home field advantage ===
NTEAMS = 129;
nWeeks = eval(week);
homeFieldCorrs = zeros(NTEAMS, nWeeks);
weekOffset = 1;
for iWeek = 0:nWeeks
    % Do we include week 0?
    if iWeek == 0 && eval(week) > 3
        weekOffset = 0;
        continue
    elseif iWeek == 0 && eval(week) < 4
        % Open overall data for preseason data
        file = sprintf('OverallData-%s-00.cfb', year);
        overallData = csvread(file);
        homeFieldCorrs(:,iWeek+weekOffset) = overallData(:,6);
        continue
    end
    % Open the file
    thisWeek = sprintf('0%d', iWeek);
    if length(thisWeek) == 3
        thisWeek = thisWeek(2:3);
    end
    thisFile = sprintf('../Scores/Scores-%s-%s.cfb', year, thisWeek);
    thisFid = fopen(thisFile, 'r');
    moreScores = true;
    while moreScores
        thisScore = fgetl(thisFid);
        if thisScore == -1
            moreScores = false;
            continue
        end
        % Lookup team index and save home field status
        commas = find(thisScore == ',');
        team1 = thisScore(1:commas(1)-1);
        team2 = thisScore(commas(1)+1:commas(2)-1);
        iTeam1 = CFB_lookup(team1);
        iTeam2 = CFB_lookup(team2);
        % No advantage during bowl week
        if strcmp(week, '17')
            homeFieldCorrs(iTeam1,iWeek+weekOffset) = 0;
            homeFieldCorrs(iTeam2,iWeek+weekOffset) = 0;
        else
            homeFieldCorrs(iTeam1,iWeek+weekOffset) = 1;
            homeFieldCorrs(iTeam2,iWeek+weekOffset) = -1;
        end
    end
    % Clean up
    fclose(thisFid);
end

%%
end
