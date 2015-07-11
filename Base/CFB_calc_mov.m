function MOV = CFB_calc_mov(year, week)
% Parent function: CFB_calc_stats
% Child function:
%
% year, week - strings, end date for a cumulative margin of victory, matrix
%


%% === Iterate through scores ===
NTEAMS = 129;
nWeeks = eval(week);
MOV = zeros(NTEAMS, 1);
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
        % Lookup team index and add score differences
        commas = find(thisScore == ',');
        team1 = thisScore(1:commas(1)-1);
        team2 = thisScore(commas(1)+1:commas(2)-1);
        iTeam1 = CFB_lookup(team1);
        iTeam2 = CFB_lookup(team2);
        score1 = thisScore(commas(2)+1:commas(3)-1);
        score2 = thisScore(commas(3)+1:end);
        if strcmp(score1, 'NA') || strcmp(score2, 'NA')
            continue
        end
        score1 = eval(score1);
        score2 = eval(score2);
        MOV(iTeam1) = MOV(iTeam1) + score1 - score2;
        MOV(iTeam2) = MOV(iTeam2) + score2 - score1;
    end
    % Close file
    fclose(thisFid);
end

%%
end
