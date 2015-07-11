function rushYardMargins = CFB_find_rushYardMargins(year, week, nFCSgames)
%
addpath ../Base

%% === Parse statistics data for teamRO - teamRD ===
NTEAMS = 129;
nWeeks = eval(week);
rushYardMargins = zeros(NTEAMS, max([1 nWeeks]));
weekOffset = 1;
for iWeek = 0:nWeeks
    % Do we include week 0?
    if iWeek == 0 && eval(week) > 3
        weekOffset = 0;
        continue
    end
    % Open the files
    thisWeek = sprintf('0%d', iWeek);
    if length(thisWeek) == 3
        thisWeek = thisWeek(2:3);
    end
    thisOFile = sprintf('../Stats/RushingOffense-%s-%s.cfb', year, thisWeek);
    thisDFile = sprintf('../Stats/RushingDefense-%s-%s.cfb', year, thisWeek);
    thisO = csvread(thisOFile);
    thisD = csvread(thisDFile);
    % Calculate the margin
    rushYardMargins((1:NTEAMS-1),iWeek+weekOffset) = thisO((1:NTEAMS-1),6) - thisD((1:NTEAMS-1),6);
    allFBSrya = sum(thisD((1:NTEAMS-1),3));
    allFBSry = sum(thisO((1:NTEAMS-1),3));
    if iWeek ~= 0
        rushYardMargins(NTEAMS,iWeek+weekOffset) = (allFBSrya - allFBSry) ./ sum(nFCSgames(1:iWeek+weekOffset));
    end
end

%%
end
