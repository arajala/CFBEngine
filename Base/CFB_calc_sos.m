function [OPPWL OPPOPPWL] = CFB_calc_sos(week, OPPS, WL)
% Parent function: CFB_calc_stats
% Child function:
%

%% === Initialize output ===
nTeams = size(WL, 1);
OPPWL = zeros(nTeams, 2);
OPPOPPWL = zeros(nTeams, 2);
W = 1;
L = 2;

%% === Loop through teams in OPPS and find w-l, opponents, opponents w-l ===
nWeeks = eval(week);
for iTeam = 1:nTeams
    for iWeek = 1:nWeeks
        % Find opponents and their records
        thisOpp = OPPS{iTeam,iWeek};
        if isempty(thisOpp)
            continue
        end
        iThisOpp = CFB_lookup(thisOpp);
        OPPWL(iTeam,W) = OPPWL(iTeam,W) + WL(iThisOpp,W);
        OPPWL(iTeam,L) = OPPWL(iTeam,L) + WL(iThisOpp,L);
        % Find opponents opponents and their records
        for iWeek2 = 1:nWeeks
            thisOppOpp = OPPS{iThisOpp,iWeek};
            if isempty(thisOppOpp)
                continue
            end
            iThisOppOpp = CFB_lookup(thisOppOpp);
            OPPOPPWL(iTeam,W) = OPPOPPWL(iTeam,W) + WL(iThisOppOpp,W);
            OPPOPPWL(iTeam,L) = OPPOPPWL(iTeam,L) + WL(iThisOppOpp,L);
        end
    end
end

%%
end
