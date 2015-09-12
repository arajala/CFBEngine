function trainData = CFB_find_features(iTeam1, iTeam2, year, week)
%

%% === Read in stats ===
NTEAMS = 129;
NOTEAM = 135;
teamStatNames = fopen('../teamStatNames.cfb', 'r');
moreStats = true;
trainData = zeros(1, 154);
%trainData(1,1) = -1;
%trainData(1,2) = 1;
thisWeek = sprintf('0%s', week);
thisWeek = thisWeek(end-1:end);
calcStatsFile = sprintf('../Stats/CalculatedStats-%s-%s.cfb', year, thisWeek);
theseStats = csvread(calcStatsFile);
if iTeam2 == NOTEAM
    theseStats(iTeam2,:) = zeros(1, size(theseStats,2));
end
%trainData(1,3) = theseStats(iTeam1,2) / theseStats(iTeam1,1);   % w / gp
trainData(1,4) = theseStats(iTeam1,4) / theseStats(iTeam1,1);   % mov / gp
trainData(1,5) = theseStats(iTeam1,5) / (theseStats(iTeam1,5) + theseStats(iTeam1,6));   % opp w / opp gp
trainData(1,6) = theseStats(iTeam1,7) / (theseStats(iTeam1,7) + theseStats(iTeam1,8));   % opp opp w / opp wopp gp
%trainData(1,7) = theseStats(iTeam1,9) / (theseStats(iTeam1,9) + theseStats(iTeam1,10));   % home w / home gp
%trainData(1,8) = theseStats(iTeam1,11) / (theseStats(iTeam1,11) + theseStats(iTeam1,12)); % road w / road gp
trainData(1,9) = theseStats(iTeam1,13) / (theseStats(iTeam1,13) + theseStats(iTeam1,14)); % recent w / recent gp
%trainData(1,10) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
trainData(1,11) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
trainData(1,12) = theseStats(iTeam2,5) / (theseStats(iTeam2,5) + theseStats(iTeam2,6));
trainData(1,13) = theseStats(iTeam2,7) / (theseStats(iTeam2,7) + theseStats(iTeam2,8));
%trainData(1,14) = theseStats(iTeam2,9) / (theseStats(iTeam2,9) + theseStats(iTeam2,10));
%trainData(1,15) = theseStats(iTeam2,11) / (theseStats(iTeam2,11) + theseStats(iTeam2,12));
trainData(1,16) = theseStats(iTeam2,13) / (theseStats(iTeam2,13) + theseStats(iTeam2,14));
trainData(trainData ~= trainData) = 0;
while moreStats
    thisStatName = fgetl(teamStatNames);
    if thisStatName == -1
        moreStats = false;
        continue
    end
    thisWeek = sprintf('0%s', week);
    thisWeek = thisWeek(end-1:end);
    thisFileName = sprintf('../Stats/%s-%s-%s.cfb', thisStatName, year, thisWeek);
    theseStats = csvread(thisFileName);
    nStats = size(theseStats, 2);
    if iTeam1 == NTEAMS || iTeam2 == NTEAMS
        theseStats(NTEAMS,:) = zeros(1, nStats);
    end
    if iTeam2 == NOTEAM
        theseStats(iTeam2,:) = zeros(1, size(theseStats,2));
    end
    switch thisStatName
        case '3rdDownConversionPct'
            trainData(1,17) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,18) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,19) = theseStats(iTeam1,4);
            trainData(1,20) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,21) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,22) = theseStats(iTeam2,4);
        case '4thDownConversionPct'
            trainData(1,23) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,24) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,25) = theseStats(iTeam1,4);
            trainData(1,26) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,27) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,28) = theseStats(iTeam2,4);
        case 'CompletionPercentage'
            trainData(1,29) = theseStats(iTeam1,4);
            trainData(1,30) = theseStats(iTeam2,4);
        case 'FewestPenaltyYardsPerGame'
            trainData(1,31) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,32) = theseStats(iTeam1,4);
            trainData(1,33) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,34) = theseStats(iTeam2,4);
        case 'FirstDownsDefense'
            trainData(1,35) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,36) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,37) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,38) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,39) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,40) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,41) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,42) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
        case 'FirstDownsOffense'
            trainData(1,43) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,44) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,45) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,46) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,47) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,48) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,49) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,50) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
        case 'KickoffReturns'
            trainData(1,51) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,52) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,53) = theseStats(iTeam1,5);
            trainData(1,54) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,55) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,56) = theseStats(iTeam2,5);
        case 'NetPunting'
            trainData(1,57) = theseStats(iTeam1,2)/ theseStats(iTeam1,1);
            trainData(1,58) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,59) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,60) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,61) = theseStats(iTeam1,6);
            trainData(1,62) = theseStats(iTeam2,2)/ theseStats(iTeam2,1);
            trainData(1,63) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,64) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,65) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
            trainData(1,66) = theseStats(iTeam2,6);
        case 'PassesHadIntercepted'
            trainData(1,67) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,68) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
        case 'PassesIntercepted'
            trainData(1,69) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,70) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,71) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,72) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
        case 'PassingOffense'
            trainData(1,73) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,74) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,75) = theseStats(iTeam1,6);
            trainData(1,76) = theseStats(iTeam1,7);
            trainData(1,77) = theseStats(iTeam1,8) / theseStats(iTeam1,1);
            trainData(1,78) = theseStats(iTeam1,9);
            trainData(1,79) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,80) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,81) = theseStats(iTeam2,6);
            trainData(1,82) = theseStats(iTeam2,7);
            trainData(1,83) = theseStats(iTeam2,8) / theseStats(iTeam2,1);
            trainData(1,84) = theseStats(iTeam2,9);
        case 'PassingYardsAllowed'
            trainData(1,85) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,86) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,87) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,88) = theseStats(iTeam1,6);
            trainData(1,89) = theseStats(iTeam1,7);
            trainData(1,90) = theseStats(iTeam1,8);
            trainData(1,91) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,92) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,93) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
            trainData(1,94) = theseStats(iTeam2,6);
            trainData(1,95) = theseStats(iTeam2,7);
            trainData(1,96) = theseStats(iTeam2,8);
        case 'PuntReturns'
            trainData(1,97) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,98) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,99) = theseStats(iTeam1,5);
            trainData(1,100) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,101) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,102) = theseStats(iTeam2,5);
        case 'RushingDefense'
            trainData(1,103) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,104) = theseStats(iTeam1,4);
            trainData(1,105) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,106) = theseStats(iTeam1,6);
            trainData(1,107) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,108) = theseStats(iTeam2,4);
            trainData(1,109) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
            trainData(1,110) = theseStats(iTeam2,6);
        case 'RushingOffense'
            trainData(1,111) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,112) = theseStats(iTeam1,4);
            trainData(1,113) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,114) = theseStats(iTeam1,6);
            trainData(1,115) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,116) = theseStats(iTeam2,4);
            trainData(1,117) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
            trainData(1,118) = theseStats(iTeam2,6);
        case 'SacksAllowed'
            trainData(1,119) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,120) = theseStats(iTeam1,4);
            trainData(1,121) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,122) = theseStats(iTeam2,4);
        case 'ScoringOffense'
            trainData(1,123) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,124) = theseStats(iTeam1,3) / theseStats(iTeam1,1);
            trainData(1,125) = theseStats(iTeam1,4) / theseStats(iTeam1,1);
            trainData(1,126) = theseStats(iTeam1,5) / theseStats(iTeam1,1);
            trainData(1,127) = theseStats(iTeam1,6) / theseStats(iTeam1,1);
            trainData(1,128) = theseStats(iTeam1,7) / theseStats(iTeam1,1);
            trainData(1,129) = theseStats(iTeam1,9);
            trainData(1,130) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,131) = theseStats(iTeam2,3) / theseStats(iTeam2,1);
            trainData(1,132) = theseStats(iTeam2,4) / theseStats(iTeam2,1);
            trainData(1,133) = theseStats(iTeam2,5) / theseStats(iTeam2,1);
            trainData(1,134) = theseStats(iTeam2,6) / theseStats(iTeam2,1);
            trainData(1,135) = theseStats(iTeam2,7) / theseStats(iTeam2,1);
        case 'TeamPassingEfficiency'
            trainData(1,137) = theseStats(iTeam1,7);
            trainData(1,138) = theseStats(iTeam2,7);
        case 'TeamPassingEfficiencyDefense'
            trainData(1,139) = theseStats(iTeam1,7);
            trainData(1,140) = theseStats(iTeam2,7);
        case 'TimeOfPossession'
            trainData(1,141) = theseStats(iTeam1,3);
            trainData(1,142) = theseStats(iTeam2,3);
        case 'TotalDefense'
            trainData(1,143) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,144) = theseStats(iTeam1,4);
            trainData(1,145) = theseStats(iTeam1,7);
            trainData(1,146) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,147) = theseStats(iTeam2,4);
            trainData(1,148) = theseStats(iTeam2,7);
        case 'TotalOffense'
            trainData(1,149) = theseStats(iTeam1,2) / theseStats(iTeam1,1);
            trainData(1,150) = theseStats(iTeam1,4);
            trainData(1,151) = theseStats(iTeam1,7);
            trainData(1,152) = theseStats(iTeam2,2) / theseStats(iTeam2,1);
            trainData(1,153) = theseStats(iTeam2,4);
            trainData(1,154) = theseStats(iTeam2,7);
        otherwise
            fprintf('Typo: %s\n', thisStatName);
            return
    end
end

%% === Clean up ===
fclose(teamStatNames);
trainData(trainData ~= trainData) = 0;

%%
end
