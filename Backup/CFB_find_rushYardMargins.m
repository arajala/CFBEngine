function rushYardMargins = CFB_find_rushYardMargins(year, week)
%
addpath ../Base

%% === Parse statistics data for rushing yards per game ===
NTEAMS = 129;
nWeeks = eval(week);
rushYards = zeros(NTEAMS, max([1 nWeeks]));
weekOffset = 1;
for iWeek = 0:nWeeks
    % Do we include week 0?
    if iWeek == 0 && eval(week) > 3
        weekOffset = 0;
        continue
    end
    % Open the file
    thisWeek = sprintf('0%d', iWeek);
    if length(thisWeek) == 3
        thisWeek = thisWeek(2:3);
    end
    thisFile = sprintf('../Stats/RushingOffense-%s-%s.cfb', year, thisWeek);
    thisFid = fopen(thisFile);
    moreTeams = true;
    iTeam = 1;
    while moreTeams
        theseStats = fgetl(thisFid);
        if theseStats == -1
            moreTeams = false;
            continue
        end
        % Look up yards/game
        commas = find(theseStats == ',');
        rushYards(iTeam,iWeek+weekOffset) = eval(theseStats(commas(end)+1:end));
        iTeam = iTeam + 1;
    end
    % Clean up
    fclose(thisFid);
end
        
%% === Parse opponents schedules for rushing yards per game margins ===
rushYardMargins = zeros(NTEAMS, max([1 nWeeks]));
OPPS = CFB_calc_opponents(year, week);
nTeams = size(OPPS, 1);
for iTeam = 1:nTeams
    for iWeek = 0:nWeeks
        if iWeek == 0
            % Open overall data for preaseason data
            file = sprintf('OverallData-%s-00.cfb', year);
            overallData = csvread(file);
            rushYardMargins(iTeam,iWeek+weekOffset) = overallData(iTeam,5);
            continue
        end
        % Find opponents and their RYPG
        thisOpp = OPPS{iTeam,iWeek};
        if isempty(thisOpp)
            continue
        end
        iThisOpp = CFB_lookup(thisOpp);
        rushYardMargins(iTeam,iWeek+weekOffset) = rushYards(iTeam,iWeek+weekOffset) - rushYards(iThisOpp,iWeek+weekOffset);
    end
end

%%
end
