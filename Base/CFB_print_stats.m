function CFB_print_stats(year, week, toStats, poStats, roStats, tdStats, pdStats, ...
rdStats, stpStats, stprStats, stkrStats, d3Stats, d4Stats, penStats, oppD1Stats, ...
d1Stats, sackStats, oScoreStats, timeStats)
%

%% === 3rd Down Conversion Pct ===
nTeams = size(toStats, 1);
TDCP = zeros(nTeams, 4);
TDCP(:,1) = d3Stats(:,1); % GP
TDCP(:,2) = d3Stats(:,2); % 3D attempts
TDCP(:,3) = d3Stats(:,3); % 3D conv
TDCP(:,4) = d3Stats(:,4); % 3D %
TDCP(TDCP ~= TDCP) = 0;
file = sprintf('../Stats/3rdDownConversionPct-%s-%s.cfb', year, week);
csvwrite(file, TDCP);

%% === 3rd Down Conversion Pct Defense ===


%% === 4th Down Conversion Pct ===
FDCP = zeros(nTeams, 4);
FDCP(:,1) = d4Stats(:,1); % GP
FDCP(:,2) = d4Stats(:,3); % Conv
FDCP(:,3) = d4Stats(:,2); % Atte
FDCP(:,4) = d4Stats(:,4); % Pct
FDCP(FDCP ~= FDCP) = 0;
file = sprintf('../Stats/4thDownConversionPct-%s-%s.cfb', year, week);
csvwrite(file, FDCP);

%% === 4th Down Conversion Pct Defense ===


%% === Blocked Kicks Allowed ===


%% === Blocked Punts Allowed ===


%% === Completion Percentage ===
CP = zeros(nTeams, 4);
CP(:,1) = poStats(:,1); % GP
CP(:,2) = poStats(:,3);  % COM
CP(:,3) = poStats(:,2);  % ATT
CP(:,4) = poStats(:,4); % PCT
file = sprintf('../Stats/CompletionPercentage-%s-%s.cfb', year, week);
csvwrite(file, CP);

%% === Fewest Penalty Yards Per Game ===
FPYPG = zeros(nTeams, 4);
FPYPG(:,1) = penStats(:,1);  % GP
FPYPG(:,2) = penStats(:,2); % PEN
FPYPG(:,3) = penStats(:,3); % PYARDS
FPYPG(:,4) = penStats(:,5); % YPG
FPYPG(FPYPG ~= FPYPG) = 0;
file = sprintf('../Stats/FewestPenaltyYardsPerGame-%s-%s.cfb', year, week);
csvwrite(file, FPYPG);

%% === First Downs Defense ===
FDD = zeros(nTeams, 5);
FDD(:,1) = oppD1Stats(:,1);  % GP
FDD(:,2) = oppD1Stats(:,2);  % OPP RUSH 1D
FDD(:,3) = oppD1Stats(:,3);  % OPP PASS 1D
%FDD(:,4) = 
FDD(:,5) = oppD1Stats(:,5);; % OPP 1D
file = sprintf('../Stats/FirstDownsDefense-%s-%s.cfb', year, week);
csvwrite(file, FDD);

%% === First Downs Offense ===
FDO = zeros(nTeams, 5);
FDO(:,1) = d1Stats(:,1);  % GP
FDO(:,2) = d1Stats(:,2);  % RUSH 1D
FDO(:,3) = d1Stats(:,3);  % PASS 1D
%FDO(:,4) = 
FDO(:,5) = d1Stats(:,5); % 1D
file = sprintf('../Stats/FirstDownsOffense-%s-%s.cfb', year, week);
csvwrite(file, FDO);

%% === Kickoff Return Defense ===


%% === Kickoff Returns ===
KR = zeros(nTeams, 5);
KR(:,1) = stkrStats(:,1); % GP
KR(:,2) = stkrStats(:,2); % KR
KR(:,3) = stkrStats(:,3); % KR YDS
%KR(:,4) = 
KR(:,5) = stkrStats(:,4); % KR AVG
file = sprintf('../Stats/KickoffReturns-%s-%s.cfb', year, week);
csvwrite(file, KR);

%% === Net Punting ===
NP = zeros(nTeams, 6);
NP(:,1) = stpStats(:,1);  % GP
NP(:,2) = stpStats(:,3); % P YDS
%NP(:,3) =
NP(:,4) = stpStats(:,2);  % P
%NP(:,5) =
NP(:,6) = stpStats(:,4);  % NET YDS
file = sprintf('../Stats/NetPunting-%s-%s.cfb', year, week);
csvwrite(file, NP);

%% === Passes Had Intercepted ===
PHI = zeros(nTeams, 3);
PHI(:,1) = poStats(:,1); % GP
PHI(:,2) = poStats(:,2); % ATT
PHI(:,3) = poStats(:,8); % INT
file = sprintf('../Stats/PassesHadIntercepted-%s-%s.cfb', year, week);
csvwrite(file, PHI);

%% === Passes Intercepted ===
PI = zeros(nTeams, 5);
PI(:,1) = pdStats(:,1); % GP
PI(:,2) = pdStats(:,2);  % OPP ATT
PI(:,3) = pdStats(:,8); % OPP INT
%PI(:,4) = 
PI(:,5) = pdStats(:,7); % INT RET TDS
file = sprintf('../Stats/PassesIntercepted-%s-%s.cfb', year, week);
csvwrite(file, PI);

%% === Passing Offense ===
PO = zeros(nTeams, 9);
PO(:,1) = poStats(:,1); % GP
PO(:,2) = poStats(:,2);  % ATT
PO(:,3) = poStats(:,3);  % COM
PO(:,4) = poStats(:,8); % INT
PO(:,5) = poStats(:,5); % YDS
PO(:,6) = poStats(:,6);  % YDS/ATT
PO(:,7) = poStats(:,5) ./ poStats(:,3);  % YDS/COMP
PO(:,8) = poStats(:,7); % TD
PO(:,9) = poStats(:,11); % YPG
PO(PO ~= PO) = 0;
file = sprintf('../Stats/PassingOffense-%s-%s.cfb', year, week);
csvwrite(file, PO);

%% === Passing Yards Allowed ===
PYA = zeros(nTeams, 8);
PYA(:,1) = pdStats(:,1);  % GP
PYA(:,2) = pdStats(:,3); % OPP COM
PYA(:,3) = pdStats(:,2); % OPP ATT
PYA(:,4) = pdStats(:,5);  % OPP YDS
PYA(:,5) = pdStats(:,7);  % OPP TD
PYA(:,6) = pdStats(:,6); % OPP YDS/ATT
PYA(:,7) = pdStats(:,5) ./ pdStats(:,3); % OPP YDS/COMP
PYA(:,8) = pdStats(:,11);  % OPP YPG
PYA(PYA ~= PYA) = 0;
file = sprintf('../Stats/PassingYardsAllowed-%s-%s.cfb', year, week);
csvwrite(file, PYA);

%% === Punt Return Defense ===


%% === Punt Returns ===
PR = zeros(nTeams, 5);
PR(:,1) = stprStats(:,1); % GP
PR(:,2) = stprStats(:,2); % PR
PR(:,3) = stprStats(:,3); % PR YDS
%PR(:,4) = 
PR(:,5) = stprStats(:,4); % PR AVG
PR(PR ~= PR) = 0;
file = sprintf('../Stats/PuntReturns-%s-%s.cfb', year, week);
csvwrite(file, PR);

%% === Red Zone Defense ===


%% === Red Zone Offense ===


%% === Rushing Defense ===
RD = zeros(nTeams, 6);
RD(:,1) = rdStats(:,1); % GP
RD(:,2) = rdStats(:,2); % OPP R
RD(:,3) = rdStats(:,3); % OPP YDS
RD(:,4) = rdStats(:,4); % OPP YDS/R
RD(:,5) = rdStats(:,5); % OPP R TD
RD(:,6) = rdStats(:,7); % OPP YPG
file = sprintf('../Stats/RushingDefense-%s-%s.cfb', year, week);
csvwrite(file, RD);

%% === Rushing Offense ===
RO = zeros(nTeams, 6);
RO(:,1) = roStats(:,1); % GP
RO(:,2) = roStats(:,2); % R
RO(:,3) = roStats(:,3); % R YDS
RO(:,4) = roStats(:,4); % YD/R
RO(:,5) = roStats(:,5); % R TD
RO(:,6) = roStats(:,7); % YPG
file = sprintf('../Stats/RushingOffense-%s-%s.cfb', year, week);
csvwrite(file, RO);

%% === Sacks Allowed ===
SA = zeros(nTeams, 4);
SA(:,1) = sackStats(:,1); % GP
SA(:,2) = sackStats(:,2);  % OPP SACKS
SA(:,3) = sackStats(:,3);  % OPP SACK YDS
SA(:,4) = sackStats(:,4);  % AVG S/GP
SA(SA ~= SA) = 0;
file = sprintf('../Stats/SacksAllowed-%s-%s.cfb', year, week);
csvwrite(file, SA);

%% === Scoring Defense ===


%% === Scoring Offense ===
SO = zeros(nTeams, 9);
SO(:,1) = oScoreStats(:,1); % GP
SO(:,2) = oScoreStats(:,2);  % TD
%SO(:,3) = 
%SO(:,4) = 
%SO(:,5) = 
%SO(:,6) = 
%SO(:,7) = 
SO(:,8) = oScoreStats(:,7);  % PTS
SO(:,9) = oScoreStats(:,8); % PPG
file = sprintf('../Stats/ScoringOffense-%s-%s.cfb', year, week);
csvwrite(file, SO);

%% === Tackles For Loss Allowed ===


%% === Team Passing Efficiency ===
TPE = zeros(nTeams, 7);
TPE(:,1) = poStats(:,1);  % GP
TPE(:,2) = poStats(:,2); % ATT
TPE(:,3) = poStats(:,3); % COM
TPE(:,4) = poStats(:,8);  % INT
TPE(:,5) = poStats(:,5);  % YDS
TPE(:,6) = poStats(:,7);  % TD
TPE(:,7) = poStats(:,9); % EFF
TPE(TPE ~= TPE) = 0;
file = sprintf('../Stats/TeamPassingEfficiency-%s-%s.cfb', year, week);
csvwrite(file, TPE);

%% === Team Passing Efficiency Defense ===
TPED = zeros(nTeams, 7);
TPED(:,1) = pdStats(:,1);
TPED(:,2) = pdStats(:,2); %att
TPED(:,3) = pdStats(:,3); %cmp
TPED(:,4) = pdStats(:,8); %int
TPED(:,5) = pdStats(:,5); %yds
TPED(:,6) = pdStats(:,7); %td
TPED(:,7) = pdStats(:,9); %eff
TPED(TPED ~= TPED) = 0;
file = sprintf('../Stats/TeamPassingEfficiencyDefense-%s-%s.cfb', year, week);
csvwrite(file, TPED);

%% === Team Sacks ===


%% === Team Tackles For Loss ===


%% === Time Of Possession ===
TOP = zeros(nTeams, 3);
TOP(:,1) = timeStats(:,1); % GP
TOP(:,2) = timeStats(:,2); % TOP
TOP(:,3) = timeStats(:,3); % AVGTOP
file = sprintf('../Stats/TimeOfPossession-%s-%s.cfb', year, week);
csvwrite(file, TOP);

%% === Total Defense ===
TD = zeros(nTeams, 7);
TD(:,1) = tdStats(:,1); % GP
TD(:,2) = tdStats(:,4); % PLAYS
TD(:,3) = tdStats(:,5);  % YDS
TD(:,4) = tdStats(:,6);  % YDS/PLAY
TD(:,5) = pdStats(:,7) + rdStats(:,5);  % OFF TDS
%TD(:,6) = 
TD(:,7) = tdStats(:,7); % YPG
TD(TD ~= TD) = 0;
file = sprintf('../Stats/TotalDefense-%s-%s.cfb', year, week);
csvwrite(file, TD);

%% === Total Offense ===
TO = zeros(nTeams, 7);
TO(:,1) = toStats(:,1); % GP
TO(:,2) = toStats(:,4); % PLAYS
TO(:,3) = toStats(:,5);  % YDS
TO(:,4) = toStats(:,6);  % YDS/PLAY
TO(:,5) = poStats(:,7) + roStats(:,5);  % OFF TDS
%TO(:,6) = 
TO(:,7) = toStats(:,7); % YPG
TO(TO ~= TO) = 0;
file = sprintf('../Stats/TotalOffense-%s-%s.cfb', year, week);
csvwrite(file, TO);

%% === Turnover Margin ===


%%
end
