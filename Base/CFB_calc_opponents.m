function OPPS = CFB_calc_opponents(year, week)
% Parent function: CFB_calc_stats
% Child function:
%
% year, week - strings, end date for list of opponents/schedule
%

%% === Iterate through scores ===
NTEAMS = 129;
nWeeks = eval(week);
OPPS = cell(NTEAMS, nWeeks);
if strcmp(week, '00') || strcmp(week, '0')
    weekOffset = 1;
else
    weekOffset = 0;
end
for iWeek = 0:nWeeks
	if iWeek == 0 && eval(week) ~= 0
		continue
	end
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
        % Lookup team index save opponents
        commas = find(thisScore == ',');
        team1 = thisScore(1:commas(1)-1);
        team2 = thisScore(commas(1)+1:commas(2)-1);
        iTeam1 = CFB_lookup(team1);
        iTeam2 = CFB_lookup(team2);
        OPPS{iTeam1,iWeek+weekOffset} = team2;
        OPPS{iTeam2,iWeek+weekOffset} = team1;
    end
    % Close file
    fclose(thisFid);
end

%% === Save the schedule ??? ===
% do we need this?

%%
end
