function CFB_calc(year, week)
% Parent function:
% Child functions: CFB_calc_winloss, CFB_calc_mov
%

%% === Calculate win loss records ===
[WL HWL AWL RWL] = CFB_calc_winloss(year, week);
nTeams = size(WL, 1);

%% === Calculate games played ===
GP = zeros(nTeams, 1);
GP(:,1) = WL(:,1) + WL(:,2);

%% === Calculate margins of victoy ===
MOV = CFB_calc_mov(year, week);

%% === Calculate opponents w-l and opponents opponents w-l ===
% Compile cell-array list of opponents by team index
OPPS = CFB_calc_opponents(year, week);
[OPPWL OPPOPPWL] = CFB_calc_sos(year, week, OPPS, WL);

%% === Arrange into matrix and csvwrite ===
allStats = [GP, WL, MOV, OPPWL, OPPOPPWL, HWL, AWL, RWL];
file = sprintf('../Stats/CalculatedStats-%s-%s.cfb', year, week);
csvwrite(file, allStats);

%%
end
