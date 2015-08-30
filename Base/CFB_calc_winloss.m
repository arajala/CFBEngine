function [WL HWL AWL RWL] = CFB_calc_winloss(year, week)
% Parent function: CFB_calc_stats
% Child function:
%
% year, week - strings, end date for a cumulative win-loss record,
% cumulative
%

%% === Find files ===
NTEAMS = 129;

%% === Iterate through scores ===
WL = zeros(NTEAMS, 2);
HWL = zeros(NTEAMS, 2);
AWL = zeros(NTEAMS, 2); 
RWL = zeros(NTEAMS, 2);
W = 1;
L = 2;
nRecent = 3;
nWeeks = eval(week);
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
        % Lookup team index and add wins/losses
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
		if score2 > score1
			WL(iTeam2,W) = WL(iTeam2,W) + 1;
			WL(iTeam1,L) = WL(iTeam1,L) + 1;
			HWL(iTeam2,W) = HWL(iTeam2,W) + 1;
			AWL(iTeam1,L) = AWL(iTeam1,L) + 1;
			if iWeek > eval(week) - nRecent
				RWL(iTeam2,W) = RWL(iTeam2,W) + 1;
				RWL(iTeam1,L) = RWL(iTeam1,L) + 1;
			end
		elseif score2 < score1
			WL(iTeam2,L) = WL(iTeam2,L) + 1;
			WL(iTeam1,W) = WL(iTeam1,W) + 1;
			HWL(iTeam2,L) = HWL(iTeam2,L) + 1;
			AWL(iTeam1,W) = AWL(iTeam1,W) + 1;
			if iWeek > eval(week) - nRecent
				RWL(iTeam2,L) = RWL(iTeam2,L) + 1;
				RWL(iTeam1,W) = RWL(iTeam1,W) + 1;
			end
		else
			WL(iTeam2,L) = WL(iTeam2,L) + 1;
			WL(iTeam1,L) = WL(iTeam1,L) + 1;
			HWL(iTeam2,L) = HWL(iTeam2,L) + 1;
			AWL(iTeam1,L) = AWL(iTeam1,L) + 1;
			if iWeek > eval(week) - nRecent
				RWL(iTeam2,L) = RWL(iTeam2,L) + 1;
				RWL(iTeam1,L) = RWL(iTeam1,L) + 1;
			end
            fprintf('A tie currently counts as a loss for both teams\n');
		end
    end
    % Close file
    fclose(thisFid);
end

%%
end
