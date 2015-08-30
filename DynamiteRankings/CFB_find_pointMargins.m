function [pointMargins nFCSgames] = CFB_find_pointMargins(year, week)
%
addpath ../Base

%% === Parse scores for individual weekly margins ===
NTEAMS = 129;
nWeeks = eval(week);
pointMargins = zeros(NTEAMS, nWeeks);
nFCSgames = zeros(1, nWeeks+1);
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
        pointMargins(:,iWeek+weekOffset) = overallData(:,3);
        continue
    end
    % Open the file
    thisWeek = sprintf('0%d', iWeek);
    if length(thisWeek) == 3
        thisWeek = thisWeek(2:3);
    end
    thisFile = sprintf('../Scores/Scores-%s-%s.cfb', year, thisWeek);
    thisFid = fopen(thisFile);
    moreScores = true;
    while moreScores
        thisScore = fgetl(thisFid);
        if thisScore == -1
            moreScores = false;
            continue
        end
        % Look up team index and save point margins
        commas = find(thisScore == ',');
        team1 = thisScore(1:commas(1)-1);
        team2 = thisScore(commas(1)+1:commas(2)-1);
        iTeam1 = CFB_lookup(team1, year);
        iTeam2 = CFB_lookup(team2, year);
        score1 = thisScore(commas(2)+1:commas(3)-1);
        score2 = thisScore(commas(3)+1:end);
        if strcmp(score1, 'NA') || strcmp(score2, 'NA')
            continue
        end
        score1 = eval(score1);
        score2 = eval(score2);
        if (iTeam1 == NTEAMS) && (size(pointMargins, 2) == iWeek + weekOffset)
            pointMargins(iTeam1,iWeek+weekOffset) = pointMargins(iTeam1,iWeek+weekOffset) + score1 - score2;
        else
            pointMargins(iTeam1,iWeek+weekOffset) = score1 - score2;
        end
        if (iTeam2 == NTEAMS) && (size(pointMargins, 2) == iWeek + weekOffset)
            pointMargins(iTeam2,iWeek+weekOffset) = pointMargins(iTeam2,iWeek+weekOffset) + score2 - score1;
        else
            pointMargins(iTeam2,iWeek+weekOffset) = score2 - score1;
        end
        if iTeam1 == NTEAMS || iTeam2 == NTEAMS
            nFCSgames(iWeek+weekOffset) = nFCSgames(iWeek+weekOffset) + 1;
        end
    end
    %pointMargins(NTEAMS,(1+weekOffset:end)) = pointMargins(NTEAMS,(1+weekOffset:end)) ./ nFCSgames(iWeek+weekOffset);
    % Clean up
    fclose(thisFid);
end

%%
end
