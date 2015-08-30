function CFB_calc_data(year, week)
%
addpath ../Base

%% === Coefficients ===
rushYardCoef = 0.0837058862488956;
homeFieldCoef = 4;

%% === Gather the categories ===
[pointMargins nFCSgames] = CFB_find_pointMargins(year, week);
%calcOppStrengths = CFB_find_oppStrengths(year, week);
rushYardMargins = CFB_find_rushYardMargins(year, week, nFCSgames);
homeFieldCorrs = CFB_find_homeFieldCorrs(year, week);

%% === Calculate the weekly strengths ===
NTEAMS = 129;
iWeek = eval(week);
weekOffset = 0;
if eval(week) < 4
    weekOffset = 1;
end
%weeklyStrengths = zeros(NTEAMS, iWeek);
%weeklyStrengths(:,iWeek+1) = pointMargins(:,iWeek+weekOffset)./nFCSgames(iWeek+weekOffset) + calcOppStrengths(:,iWeek+weekOffset) + ...
%    homeFieldCoef.*homeFieldCorrs(:,iWeek+weekOffset);

%% === Write dis junk to file ===
%weeklyData = [weeklyStrengths(:,iWeek+1) pointMargins(:,iWeek+weekOffset)./nFCSgames(iWeek+weekOffset) calcOppStrengths(:,iWeek+weekOffset)...
%    homeFieldCorrs(:,iWeek+weekOffset)];
%weeklyFile = sprintf('WeeklyData-%s-%s.cfb', year, week);
%csvwrite(weeklyFile, weeklyData);

%% === Calculate the overall strengths ===
% Set up system of equations
OPPS = CFB_calc_opponents(year, week);
iNonBye = cell(NTEAMS, 1);
GP = zeros(NTEAMS, 1);
oppStrengths = zeros(NTEAMS, NTEAMS);
overallSTD = zeros(NTEAMS, 1);
overallPointMargins = zeros(NTEAMS, 1);
overallRushYardMargins = zeros(NTEAMS, 1);
overallHomeFieldCorrs = zeros(NTEAMS, 1);
for iTeam = 1:NTEAMS
    % Find non bye weeks
    iNonBye{iTeam,1} = find(pointMargins(iTeam,:) ~= 0);
    GP(iTeam) = length(iNonBye{iTeam,1});
    % Handle FCS team
    if iTeam == NTEAMS
        iNonBye{iTeam,1} = (1:min(iWeek+weekOffset, 5));
        GP(iTeam,1) = sum(nFCSgames);
    end
    % Find stat means and weekly strength std
    if ~isempty(iNonBye{iTeam,1})
        %overallSTD(iTeam) = std(weeklyStrengths(iTeam,iNonBye{iTeam,1}));
        if iTeam == NTEAMS
            overallPointMargins(iTeam) = sum(pointMargins(iTeam,iNonBye{iTeam,1})) ./ sum(nFCSgames(iNonBye{iTeam,1}));
        else
            overallPointMargins(iTeam) = mean(pointMargins(iTeam,iNonBye{iTeam,1}));
        end
        if weekOffset == 1
            overallRushYardMargins(iTeam) = (rushYardMargins(iTeam, 1)+(GP(iTeam)-1)*rushYardMargins(iTeam,iWeek+1))/GP(iTeam);
        else
            overallRushYardMargins(iTeam) = rushYardMargins(iTeam, iWeek);
        end
        overallHomeFieldCorrs(iTeam) = mean(homeFieldCorrs(iTeam,iNonBye{iTeam,1}));
    else
        %overallSTD(iTeam) = 0;
        overallPointMargins(iTeam) = 0;
        overallRushYardMargins(iTeam) = 0;
        overallHomeFieldCorrs(iTeam) = 0;
    end
    % Calculate opponent strengths matrix
    nWeeks = eval(week);
    for jWeek = 1:nWeeks
        thisOpp = OPPS{iTeam,jWeek};
        if isempty(thisOpp)
            continue
        end
        iOpp = CFB_lookup(thisOpp, year);
        oppStrengths(iTeam,iOpp) = 1 / GP(iTeam);
    end 
end
% Solve the linear system
ID = eye(NTEAMS, NTEAMS);
B = overallPointMargins + rushYardCoef.*overallRushYardMargins + homeFieldCoef.*overallHomeFieldCorrs;
if eval(week) < 4
    week0File = sprintf('OverallData-%s-00.cfb', year);
    week0Data = csvread(week0File);
    B = B + week0Data(:,4) ./ GP;
end
B(B ~=B) = 0;
A = ID - oppStrengths;
overallStrengths = A\B;
if numel(find(overallStrengths ~= overallStrengths)) > 0
    overallStrengths = pinv(A) * B;
    fprintf('Dont sweat it, the singularity has been resolved.\n');
end

%% === Write dat junk to file ===
overallAvgOppStrengths = oppStrengths * overallStrengths;
overallData = [overallStrengths overallSTD overallPointMargins overallAvgOppStrengths ...
    overallRushYardMargins overallHomeFieldCorrs GP];
overallFile = sprintf('OverallData-%s-%s.cfb', year, week);
csvwrite(overallFile, overallData);

%%
end
