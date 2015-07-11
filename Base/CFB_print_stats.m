function CFB_print_stats(year, week, toStats, poStats, roStats, rcoStats, tdStats, pdStats, rdStats, rcdStats, stpStats, strStats)
%

%% === 3rd Down Conversion Pct ===
nTeams = size(toStats, 1);
TDCP = zeros(nTeams, 4);
TDCP(:,1) = toStats(:,1);
TDCP(:,2) = round(toStats(:,7) ./ (toStats(:,8) ./ 100));
TDCP(:,3) = toStats(:,7);
TDCP(:,4) = toStats(:,8) ./ 100;
TDCP(TDCP ~= TDCP) = 0;
file = sprintf('../Stats/3rdDownConversionPct-%s-%s.cfb', year, week);
csvwrite(file, TDCP);

%% === 3rd Down Conversion Pct Defense ===


%% === 4th Down Conversion Pct ===
FDCP = zeros(nTeams, 4);
FDCP(:,1) = toStats(:,1);
FDCP(:,2) = toStats(:,9);
FDCP(:,3) = round(toStats(:,9) ./ (toStats(:,10) ./ 100));
FDCP(:,4) = toStats(:,10) ./ 100;
FDCP(FDCP ~= FDCP) = 0;
file = sprintf('../Stats/4thDownConversionPct-%s-%s.cfb', year, week);
csvwrite(file, FDCP);

%% === 4th Down Conversion Pct Defense ===


%% === Blocked Kicks Allowed ===


%% === Blocked Punts Allowed ===


%% === Completion Percentage ===
CP = zeros(nTeams, 4);
CP(:,1) = poStats(:,1);
CP(:,2) = round(poStats(:,3) .* poStats(:,1));
CP(:,3) = round(poStats(:,2) .* poStats(:,1));
CP(:,4) = poStats(:,4);
file = sprintf('../Stats/CompletionPercentage-%s-%s.cfb', year, week);
csvwrite(file, CP);

%% === Fewest Penalty Yards Per Game ===
FPYPG = zeros(nTeams, 4);
FPYPG(:,1) = toStats(:,1);
FPYPG(:,2) = toStats(:,11);
FPYPG(:,3) = toStats(:,12);
FPYPG(:,4) = toStats(:,12) ./ toStats(:,1);
FPYPG(FPYPG ~= FPYPG) = 0;
file = sprintf('../Stats/FewestPenaltyYardsPerGame-%s-%s.cfb', year, week);
csvwrite(file, FPYPG);

%% === First Downs Defense ===
FDD = zeros(nTeams, 5);
FDD(:,1) = pdStats(:,1);
FDD(:,2) = rdStats(:,8);
FDD(:,3) = pdStats(:,9);
%FDD(:,4) = 
FDD(:,5) = rdStats(:,8) + pdStats(:,9);
file = sprintf('../Stats/FirstDownsDefense-%s-%s.cfb', year, week);
csvwrite(file, FDD);

%% === First Downs Offense ===
FDO = zeros(nTeams, 5);
FDO(:,1) = poStats(:,1);
FDO(:,2) = roStats(:,8);
FDO(:,3) = poStats(:,9);
%FDO(:,4) = 
FDO(:,5) = roStats(:,8) + poStats(:,9);
file = sprintf('../Stats/FirstDownsOffense-%s-%s.cfb', year, week);
csvwrite(file, FDO);

%% === Kickoff Return Defense ===


%% === Kickoff Returns ===
KR = zeros(nTeams, 5);
KR(:,1) = strStats(:,1);
KR(:,2) = strStats(:,5);
KR(:,3) = strStats(:,6);
%KR(:,4) = 
KR(:,5) = strStats(:,7);
file = sprintf('../Stats/KickoffReturns-%s-%s.cfb', year, week);
csvwrite(file, KR);

%% === Net Punting ===
NP = zeros(nTeams, 6);
NP(:,1) = stpStats(:,1);
NP(:,2) = stpStats(:,2) .* stpStats(:,3);
%NP(:,3) =
NP(:,4) = stpStats(:,2);
%NP(:,5) =
NP(:,6) = stpStats(:,3);
file = sprintf('../Stats/NetPunting-%s-%s.cfb', year, week);
csvwrite(file, NP);

%% === Passes Had Intercepted ===
PHI = zeros(nTeams, 3);
PHI(:,1) = poStats(:,1);
PHI(:,2) = round(poStats(:,2) .* poStats(:,1));
PHI(:,3) = poStats(:,8);
file = sprintf('../Stats/PassesHadIntercepted-%s-%s.cfb', year, week);
csvwrite(file, PHI);

%% === Passes Intercepted ===
PI = zeros(nTeams, 5);
PI(:,1) = pdStats(:,1);
PI(:,2) = round(pdStats(:,2) .* pdStats(:,1));
PI(:,3) = pdStats(:,8);
%PI(:,4) = 
PI(:,5) = tdStats(:,7);
file = sprintf('../Stats/PassesIntercepted-%s-%s.cfb', year, week);
csvwrite(file, PI);

%% === Passing Offense ===
PO = zeros(nTeams, 9);
PO(:,1) = poStats(:,1);
PO(:,2) = round(poStats(:,2) .* poStats(:,1));
PO(:,3) = round(poStats(:,3) .* poStats(:,1));
PO(:,4) = poStats(:,8);
PO(:,5) = poStats(:,5);
PO(:,6) = poStats(:,5) ./ round(poStats(:,2) .* poStats(:,1));
PO(:,7) = poStats(:,5) ./ round(poStats(:,3) .* poStats(:,1));
PO(:,8) = poStats(:,7);
PO(:,9) = poStats(:,6);
PO(PO ~= PO) = 0;
file = sprintf('../Stats/PassingOffense-%s-%s.cfb', year, week);
csvwrite(file, PO);

%% === Passing Yards Allowed ===
PYA = zeros(nTeams, 8);
PYA(:,1) = pdStats(:,1);
PYA(:,2) = round(pdStats(:,3) .* pdStats(:,1));
PYA(:,3) = round(pdStats(:,2) .* pdStats(:,1));
PYA(:,4) = pdStats(:,5);
PYA(:,5) = pdStats(:,7);
PYA(:,6) = pdStats(:,5) ./ round(pdStats(:,2) .* pdStats(:,1));
PYA(:,7) = pdStats(:,5) ./ round(pdStats(:,3) .* pdStats(:,1));
PYA(:,8) = pdStats(:,6);
PYA(PYA ~= PYA) = 0;
file = sprintf('../Stats/PassingYardsAllowed-%s-%s.cfb', year, week);
csvwrite(file, PYA);

%% === Punt Return Defense ===


%% === Punt Returns ===
PR = zeros(nTeams, 5);
PR(:,1) = strStats(:,1);
PR(:,2) = strStats(:,2);
PR(:,3) = strStats(:,3);
%PR(:,4) = 
PR(:,5) = strStats(:,3) ./ strStats(:,2);
PR(PR ~= PR) = 0;
file = sprintf('../Stats/PuntReturns-%s-%s.cfb', year, week);
csvwrite(file, PR);

%% === Red Zone Defense ===


%% === Red Zone Offense ===


%% === Rushing Defense ===
RD = zeros(nTeams, 6);
RD(:,1) = rdStats(:,1);
RD(:,2) = rdStats(:,2);
RD(:,3) = rdStats(:,3);
RD(:,4) = rdStats(:,4);
RD(:,5) = rdStats(:,7);
RD(:,6) = rdStats(:,6);
file = sprintf('../Stats/RushingDefense-%s-%s.cfb', year, week);
csvwrite(file, RD);

%% === Rushing Offense ===
RO = zeros(nTeams, 6);
RO(:,1) = roStats(:,1);
RO(:,2) = roStats(:,2);
RO(:,3) = roStats(:,3);
RO(:,4) = roStats(:,4);
RO(:,5) = roStats(:,7);
RO(:,6) = roStats(:,6);
file = sprintf('../Stats/RushingOffense-%s-%s.cfb', year, week);
csvwrite(file, RO);

%% === Sacks Allowed ===
SA = zeros(nTeams, 4);
SA(:,1) = poStats(:,1);
SA(:,2) = poStats(:,11);
SA(:,3) = poStats(:,12);
SA(:,4) = poStats(:,11) ./ poStats(:,1);
SA(SA ~= SA) = 0;
file = sprintf('../Stats/SacksAllowed-%s-%s.cfb', year, week);
csvwrite(file, SA);

%% === Scoring Defense ===


%% === Scoring Offense ===
SO = zeros(nTeams, 9);
SO(:,1) = toStats(:,1);
SO(:,2) = poStats(:,7) + roStats(:,7);
%SO(:,3) = 
%SO(:,4) = 
%SO(:,5) = 
%SO(:,6) = 
%SO(:,7) = 
SO(:,8) = round(toStats(:,2) .* toStats(:,1));
SO(:,9) = toStats(:,2);
file = sprintf('../Stats/ScoringOffense-%s-%s.cfb', year, week);
csvwrite(file, SO);

%% === Tackles For Loss Allowed ===


%% === Team Passing Efficiency ===
TPE = zeros(nTeams, 7);
TPE(:,1) = poStats(:,1);
TPE(:,2) = round(poStats(:,2) .* poStats(:,1));
TPE(:,3) = round(poStats(:,3) .* poStats(:,1));
TPE(:,4) = poStats(:,8);
TPE(:,5) = poStats(:,5);
TPE(:,6) = poStats(:,7);
TPE(:,7) = ((8.4.*poStats(:,5)) + (330.*poStats(:,7)) - (200.*poStats(:,8)) + (100.*round(poStats(:,3).*poStats(:,1)))) ./ round(poStats(:,2).*poStats(:,1));
TPE(TPE ~= TPE) = 0;
file = sprintf('../Stats/TeamPassingEfficiency-%s-%s.cfb', year, week);
csvwrite(file, TPE);

%% === Team Passing Efficiency Defense ===
TPED = zeros(nTeams, 7);
TPED(:,1) = pdStats(:,1);
TPED(:,2) = round(pdStats(:,2) .* pdStats(:,1)); %att
TPED(:,3) = round(pdStats(:,3) .* pdStats(:,1)); %cmp
TPED(:,4) = pdStats(:,8); %ind
TPED(:,5) = pdStats(:,5); %yds
TPED(:,6) = pdStats(:,7); %td
TPED(:,7) = ((8.4.*pdStats(:,5)) + (330.*pdStats(:,7)) - (200.*pdStats(:,8)) + (100.*round(pdStats(:,3).*pdStats(:,1)))) ./ round(pdStats(:,2).*pdStats(:,1));
TPED(TPED ~= TPED) = 0;
file = sprintf('../Stats/TeamPassingEfficiencyDefense-%s-%s.cfb', year, week);
csvwrite(file, TPED);

%% === Team Sacks ===


%% === Team Tackles For Loss ===


%% === Time Of Possession ===
TOP = zeros(nTeams, 3);
TOP(:,1) = toStats(:,1);
TOP(:,2) = toStats(:,13) .* toStats(:,1);
TOP(:,3) = toStats(:,13);
file = sprintf('../Stats/TimeOfPossession-%s-%s.cfb', year, week);
csvwrite(file, TOP);

%% === Total Defense ===
TD = zeros(nTeams, 7);
TD(:,1) = tdStats(:,1);
TD(:,2) = round(pdStats(:,2) .* pdStats(:,1)) + rdStats(:,2);
TD(:,3) = tdStats(:,4) + tdStats(:,5);
TD(:,4) = (tdStats(:,4) + tdStats(:,5)) ./ (round(pdStats(:,2) .* pdStats(:,1)) + rdStats(:,2));
TD(:,5) = pdStats(:,7) + rdStats(:,7);
%TD(:,6) = 
TD(:,7) = tdStats(:,3);
TD(TD ~= TD) = 0;
file = sprintf('../Stats/TotalDefense-%s-%s.cfb', year, week);
csvwrite(file, TD);

%% === Total Offense ===
TO = zeros(nTeams, 7);
TO(:,1) = toStats(:,1);
TO(:,2) = round(poStats(:,2) .* poStats(:,1)) + roStats(:,2);
TO(:,3) = toStats(:,4) + toStats(:,5);
TO(:,4) = (toStats(:,4) + toStats(:,5)) ./ (round(poStats(:,2) .* poStats(:,1)) + roStats(:,2));
TO(:,5) = poStats(:,7) + roStats(:,7);
%TO(:,6) = 
TO(:,7) = toStats(:,3);
TO(TO ~= TO) = 0;
file = sprintf('../Stats/TotalOffense-%s-%s.cfb', year, week);
csvwrite(file, TO);

%% === Turnover Margin ===


%%
end
