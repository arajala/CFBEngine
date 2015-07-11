function oppStrengths = CFB_find_oppStrengths(year, week)
%
addpath ../Base

%% === Parse overall data for team strengths ===
NTEAMS = 124;
nWeeks = eval(week);
oppStrengths = zeros(NTEAMS, nWeeks);
weekOffset = 1;
for iWeek = 0:nWeeks
    % Do we include week 0?
    if iWeek == 0 && eval(week) > 3
        weekOffset = 0;
        continue
    end
    % Open the file
    lastWeek = iWeek - 1;
    if lastWeek == -1
        oppStrengths(:,1) = zeros(NTEAMS, 1);
        continue
    end
    if lastWeek <= 9
        lastWeek = sprintf('0%d', lastWeek);
    else
        lastWeek = sprintf('%d', lastWeek);
    end
    thisFile = sprintf('OverallData-%s-%s.cfb', year, lastWeek);
    thisFid = fopen(thisFile);
    moreTeams = true;
    iTeam = 1;
    while moreTeams
        thisData = fgetl(thisFid);
        if thisData == -1
            moreTeams = false;
            continue
        end
        % Look up data and save overall strengths
        commas = find(thisData == ',');
        oppStrengths(iTeam,iWeek+weekOffset)= eval(thisData(1:commas(1)-1));
        iTeam = iTeam + 1;
    end
    % Clean up
    fclose(thisFid);
end

%%
end
