function trainData = CFB_find_features(iTeam1, iTeam2)
%

%% === Read in stats ===
teamStatNames = fopen('../teamStatNames.cfb', 'r');
moreStats = true;
trainData = zeros(1, 376);
gamesPlayed = [0 0];
trainData(1,375) = -1;
trainData(1,376) = 1;
while moreStats
    thisStatName = fgetl(teamStatNames);
    if thisStatName == -1
        % Calculated stats
        theseStats = csvread('../Stats/CalculatedStats-2014-00.cfb');
        trainData(1,361) = theseStats(iTeam1,2);
        trainData(1,362) = theseStats(iTeam1,3);
        trainData(1,363) = theseStats(iTeam1,4);
        trainData(1,364) = theseStats(iTeam1,5);
        trainData(1,365) = theseStats(iTeam1,6);
        trainData(1,366) = theseStats(iTeam1,7);
        trainData(1,367) = theseStats(iTeam1,8);
        trainData(1,368) = theseStats(iTeam2,2);
        trainData(1,369) = theseStats(iTeam2,3);
        trainData(1,370) = theseStats(iTeam2,4);
        trainData(1,371) = theseStats(iTeam2,5);
        trainData(1,372) = theseStats(iTeam2,6);
        trainData(1,373) = theseStats(iTeam2,7);
        trainData(1,374) = theseStats(iTeam2,8);
        moreStats = false;
        continue
    end
    thisFileName = sprintf('../Stats/%s-2014-00.cfb', thisStatName);
    theseStats = csvread(thisFileName);
    nStats = size(theseStats, 2);
    if iTeam1 == 124 || iTeam2 == 124
        theseStats(124,:) = zeros(1, nStats);
    end
    switch thisStatName
        case '3rdDownConversionPct'
            gamesPlayed(1) = theseStats(iTeam1,1);
            gamesPlayed(2) = theseStats(iTeam2,1);
            trainData(1,1) = theseStats(iTeam1,2);
            trainData(1,2) = theseStats(iTeam1,3);
            trainData(1,3) = theseStats(iTeam1,4);
            trainData(1,4) = theseStats(iTeam2,2);
            trainData(1,5) = theseStats(iTeam2,3);
            trainData(1,6) = theseStats(iTeam2,4);
        case '3rdDownConversionPctDefense'
            trainData(1,7) = theseStats(iTeam1,2);
            trainData(1,8) = theseStats(iTeam1,3);
            trainData(1,9) = theseStats(iTeam1,4);
            trainData(1,10) = theseStats(iTeam2,2);
            trainData(1,11) = theseStats(iTeam2,3);
            trainData(1,12) = theseStats(iTeam2,4);
        case '4thDownConvPct'
            trainData(1,13) = theseStats(iTeam1,2);
            trainData(1,14) = theseStats(iTeam1,3);
            trainData(1,15) = theseStats(iTeam1,4);
            trainData(1,16) = theseStats(iTeam2,2);
            trainData(1,17) = theseStats(iTeam2,3);
            trainData(1,18) = theseStats(iTeam2,4);
        case '4thDownConvPctDefense'
            trainData(1,19) = theseStats(iTeam1,2);
            trainData(1,20) = theseStats(iTeam1,3);
            trainData(1,21) = theseStats(iTeam1,4);
            trainData(1,22) = theseStats(iTeam2,2);
            trainData(1,23) = theseStats(iTeam2,3);
            trainData(1,24) = theseStats(iTeam2,4);
        case 'BlockedKicks'
%             trainData(1,25) = theseStats(iTeam1,2);
%             trainData(1,26) = theseStats(iTeam2,2);
        case 'BlockedKicksAllowed'
            trainData(1,27) = theseStats(iTeam1,2);
            trainData(1,28) = theseStats(iTeam2,2);
        case 'BlockedPunts'
%             trainData(1,29) = theseStats(iTeam1,2);
%             trainData(1,30) = theseStats(iTeam1,3);
%             trainData(1,31) = theseStats(iTeam2,2);
%             trainData(1,32) = theseStats(iTeam2,3);
        case 'BlockedPuntsAllowed'
            trainData(1,33) = theseStats(iTeam1,2);
            trainData(1,34) = theseStats(iTeam1,3);
            trainData(1,35) = theseStats(iTeam2,2);
            trainData(1,36) = theseStats(iTeam2,3);
        case 'CompletionPercentage'
            trainData(1,37) = theseStats(iTeam1,2);
            trainData(1,38) = theseStats(iTeam1,3);
            trainData(1,39) = theseStats(iTeam1,4);
            trainData(1,40) = theseStats(iTeam2,2);
            trainData(1,41) = theseStats(iTeam2,3);
            trainData(1,42) = theseStats(iTeam2,4);
        case 'FewestPenalties'
            trainData(1,43) = theseStats(iTeam1,2);
            trainData(1,44) = theseStats(iTeam1,3);
            trainData(1,45) = theseStats(iTeam2,2);
            trainData(1,46) = theseStats(iTeam2,3);
        case 'FewestPenaltiesPerGame'
            trainData(1,47) = theseStats(iTeam1,2);
            trainData(1,48) = theseStats(iTeam1,3);
            trainData(1,49) = theseStats(iTeam2,2);
            trainData(1,50) = theseStats(iTeam2,3);
        case 'FewestPenaltyYards'
            trainData(1,51) = theseStats(iTeam1,2);
            trainData(1,52) = theseStats(iTeam1,3);
            trainData(1,53) = theseStats(iTeam2,2);
            trainData(1,54) = theseStats(iTeam2,3);
        case 'FewestPenaltyYardsPerGame'
            trainData(1,55) = theseStats(iTeam1,2);
            trainData(1,56) = theseStats(iTeam1,3);
            trainData(1,57) = theseStats(iTeam1,4);
            trainData(1,58) = theseStats(iTeam2,2);
            trainData(1,59) = theseStats(iTeam2,3);
            trainData(1,60) = theseStats(iTeam2,4);
        case 'FirstDownsDefense'
            trainData(1,61) = theseStats(iTeam1,2);
            trainData(1,62) = theseStats(iTeam1,3);
            trainData(1,63) = theseStats(iTeam1,4);
            trainData(1,64) = theseStats(iTeam1,5);
            trainData(1,65) = theseStats(iTeam2,2);
            trainData(1,66) = theseStats(iTeam2,3);
            trainData(1,67) = theseStats(iTeam2,4);
            trainData(1,68) = theseStats(iTeam2,5);
        case 'FirstDownsOffense'
            trainData(1,69) = theseStats(iTeam1,2);
            trainData(1,70) = theseStats(iTeam1,3);
            trainData(1,71) = theseStats(iTeam1,4);
            trainData(1,72) = theseStats(iTeam1,5);
            trainData(1,73) = theseStats(iTeam2,2);
            trainData(1,74) = theseStats(iTeam2,3);
            trainData(1,75) = theseStats(iTeam2,4);
            trainData(1,76) = theseStats(iTeam2,5);
        case 'FumblesLost'
            trainData(1,77) = theseStats(iTeam1,2);
            trainData(1,78) = theseStats(iTeam2,2);
        case 'FumblesRecovered'
            trainData(1,79) = theseStats(iTeam1,2);
            trainData(1,80) = theseStats(iTeam2,2);
        case 'KickoffReturnDefense'
            trainData(1,81) = theseStats(iTeam1,2);
            trainData(1,82) = theseStats(iTeam1,3);
            trainData(1,83) = theseStats(iTeam1,4);
            trainData(1,84) = theseStats(iTeam1,5);
            trainData(1,85) = theseStats(iTeam2,2);
            trainData(1,86) = theseStats(iTeam2,3);
            trainData(1,87) = theseStats(iTeam2,4);
            trainData(1,88) = theseStats(iTeam2,5);
        case 'KickoffReturns'
            trainData(1,89) = theseStats(iTeam1,2);
            trainData(1,90) = theseStats(iTeam1,3);
            trainData(1,91) = theseStats(iTeam1,4);
            trainData(1,92) = theseStats(iTeam1,5);
            trainData(1,93) = theseStats(iTeam2,2);
            trainData(1,94) = theseStats(iTeam2,3);
            trainData(1,95) = theseStats(iTeam2,4);
            trainData(1,96) = theseStats(iTeam2,5);
        case 'NetPunting'
            trainData(1,97) = theseStats(iTeam1,2);
            trainData(1,98) = theseStats(iTeam1,3);
            trainData(1,99) = theseStats(iTeam1,4);
            trainData(1,100) = theseStats(iTeam1,5);
            trainData(1,101) = theseStats(iTeam1,6);
            trainData(1,102) = theseStats(iTeam2,2);
            trainData(1,103) = theseStats(iTeam2,3);
            trainData(1,104) = theseStats(iTeam2,4);
            trainData(1,105) = theseStats(iTeam2,5);
            trainData(1,106) = theseStats(iTeam2,6);
        case 'PassesHadIntercepted'
            trainData(1,107) = theseStats(iTeam1,2);
            trainData(1,108) = theseStats(iTeam1,3);
            trainData(1,109) = theseStats(iTeam2,2);
            trainData(1,110) = theseStats(iTeam2,3);
        case 'PassesIntercepted'
            trainData(1,111) = theseStats(iTeam1,2);
            trainData(1,112) = theseStats(iTeam1,3);
            trainData(1,113) = theseStats(iTeam1,4);
            trainData(1,114) = theseStats(iTeam1,5);
            trainData(1,115) = theseStats(iTeam2,2);
            trainData(1,116) = theseStats(iTeam2,3);
            trainData(1,117) = theseStats(iTeam2,4);
            trainData(1,118) = theseStats(iTeam2,5);
        case 'PassingOffense'
            trainData(1,119) = theseStats(iTeam1,2);
            trainData(1,120) = theseStats(iTeam1,3);
            trainData(1,121) = theseStats(iTeam1,4);
            trainData(1,122) = theseStats(iTeam1,5);
            trainData(1,123) = theseStats(iTeam1,6);
            trainData(1,124) = theseStats(iTeam1,7);
            trainData(1,125) = theseStats(iTeam1,8);
            trainData(1,126) = theseStats(iTeam1,9);
            trainData(1,127) = theseStats(iTeam2,2);
            trainData(1,128) = theseStats(iTeam2,3);
            trainData(1,129) = theseStats(iTeam2,4);
            trainData(1,130) = theseStats(iTeam2,5);
            trainData(1,131) = theseStats(iTeam2,6);
            trainData(1,132) = theseStats(iTeam2,7);
            trainData(1,133) = theseStats(iTeam2,8);
            trainData(1,134) = theseStats(iTeam2,9);
        case 'PassingYardsAllowed'
            trainData(1,135) = theseStats(iTeam1,2);
            trainData(1,136) = theseStats(iTeam1,3);
            trainData(1,137) = theseStats(iTeam1,4);
            trainData(1,138) = theseStats(iTeam1,5);
            trainData(1,139) = theseStats(iTeam1,6);
            trainData(1,140) = theseStats(iTeam1,7);
            trainData(1,141) = theseStats(iTeam1,8);
            trainData(1,142) = theseStats(iTeam2,2);
            trainData(1,143) = theseStats(iTeam2,3);
            trainData(1,144) = theseStats(iTeam2,4);
            trainData(1,145) = theseStats(iTeam2,5);
            trainData(1,146) = theseStats(iTeam2,6);
            trainData(1,147) = theseStats(iTeam2,7);
            trainData(1,148) = theseStats(iTeam2,8);
        case 'PassingYardsPerCompletion'
            trainData(1,149) = theseStats(iTeam1,2);
            trainData(1,150) = theseStats(iTeam1,3);
            trainData(1,151) = theseStats(iTeam1,4);
            trainData(1,152) = theseStats(iTeam1,5);
            trainData(1,153) = theseStats(iTeam2,2);
            trainData(1,154) = theseStats(iTeam2,3);
            trainData(1,155) = theseStats(iTeam2,4);
            trainData(1,156) = theseStats(iTeam2,5);
        case 'PuntReturnDefense'
            trainData(1,157) = theseStats(iTeam1,2);
            trainData(1,158) = theseStats(iTeam1,3);
            trainData(1,159) = theseStats(iTeam1,4);
            trainData(1,160) = theseStats(iTeam1,5);
            trainData(1,161) = theseStats(iTeam2,2);
            trainData(1,162) = theseStats(iTeam2,3);
            trainData(1,163) = theseStats(iTeam2,4);
            trainData(1,164) = theseStats(iTeam2,5);
        case 'PuntReturns'
            trainData(1,165) = theseStats(iTeam1,2);
            trainData(1,166) = theseStats(iTeam1,3);
            trainData(1,167) = theseStats(iTeam1,4);
            trainData(1,168) = theseStats(iTeam1,5);
            trainData(1,169) = theseStats(iTeam2,2);
            trainData(1,170) = theseStats(iTeam2,3);
            trainData(1,171) = theseStats(iTeam2,4);
            trainData(1,172) = theseStats(iTeam2,5);
        case 'RedZoneDefense'
            trainData(1,173) = theseStats(iTeam1,2);
            trainData(1,174) = theseStats(iTeam1,3);
            trainData(1,175) = theseStats(iTeam1,4);
            trainData(1,176) = theseStats(iTeam1,5);
            trainData(1,177) = theseStats(iTeam1,6);
            trainData(1,178) = theseStats(iTeam1,7);
            trainData(1,179) = theseStats(iTeam2,2);
            trainData(1,180) = theseStats(iTeam2,3);
            trainData(1,181) = theseStats(iTeam2,4);
            trainData(1,182) = theseStats(iTeam2,5);
            trainData(1,183) = theseStats(iTeam2,6);
            trainData(1,184) = theseStats(iTeam2,7);
        case 'RedZoneOffense'
            trainData(1,185) = theseStats(iTeam1,2);
            trainData(1,186) = theseStats(iTeam1,3);
            trainData(1,187) = theseStats(iTeam1,4);
            trainData(1,188) = theseStats(iTeam1,5);
            trainData(1,189) = theseStats(iTeam1,6);
            trainData(1,190) = theseStats(iTeam1,7);
            trainData(1,191) = theseStats(iTeam2,2);
            trainData(1,192) = theseStats(iTeam2,3);
            trainData(1,193) = theseStats(iTeam2,4);
            trainData(1,194) = theseStats(iTeam2,5);
            trainData(1,195) = theseStats(iTeam2,6);
            trainData(1,196) = theseStats(iTeam2,7);
        case 'RushingDefense'
            trainData(1,197) = theseStats(iTeam1,2);
            trainData(1,198) = theseStats(iTeam1,3);
            trainData(1,199) = theseStats(iTeam1,4);
            trainData(1,200) = theseStats(iTeam1,5);
            trainData(1,201) = theseStats(iTeam1,6);
            trainData(1,202) = theseStats(iTeam2,2);
            trainData(1,203) = theseStats(iTeam2,3);
            trainData(1,204) = theseStats(iTeam2,4);
            trainData(1,205) = theseStats(iTeam2,5);
            trainData(1,206) = theseStats(iTeam2,6);
        case 'RushingOffense'
            trainData(1,207) = theseStats(iTeam1,2);
            trainData(1,208) = theseStats(iTeam1,3);
            trainData(1,209) = theseStats(iTeam1,4);
            trainData(1,210) = theseStats(iTeam1,5);
            trainData(1,211) = theseStats(iTeam1,6);
            trainData(1,212) = theseStats(iTeam2,2);
            trainData(1,213) = theseStats(iTeam2,3);
            trainData(1,214) = theseStats(iTeam2,4);
            trainData(1,215) = theseStats(iTeam2,5);
            trainData(1,216) = theseStats(iTeam2,6);
        case 'SacksAllowed'
            trainData(1,217) = theseStats(iTeam1,2);
            trainData(1,218) = theseStats(iTeam1,3);
            trainData(1,219) = theseStats(iTeam1,4);
            trainData(1,220) = theseStats(iTeam2,2);
            trainData(1,221) = theseStats(iTeam2,3);
            trainData(1,222) = theseStats(iTeam2,4);
        case 'ScoringDefense'
            trainData(1,223) = theseStats(iTeam1,2);
            trainData(1,224) = theseStats(iTeam1,3);
            trainData(1,225) = theseStats(iTeam1,4);
            trainData(1,226) = theseStats(iTeam1,5);
            trainData(1,227) = theseStats(iTeam1,6);
            trainData(1,228) = theseStats(iTeam1,7);
            trainData(1,229) = theseStats(iTeam1,8);
            trainData(1,230) = theseStats(iTeam1,9);
            trainData(1,231) = theseStats(iTeam2,2);
            trainData(1,232) = theseStats(iTeam2,3);
            trainData(1,233) = theseStats(iTeam2,4);
            trainData(1,234) = theseStats(iTeam2,5);
            trainData(1,235) = theseStats(iTeam2,6);
            trainData(1,236) = theseStats(iTeam2,7);
            trainData(1,237) = theseStats(iTeam2,8);
            trainData(1,238) = theseStats(iTeam2,9);
        case 'ScoringOffense'
            trainData(1,239) = theseStats(iTeam1,2);
            trainData(1,240) = theseStats(iTeam1,3);
            trainData(1,241) = theseStats(iTeam1,4);
            trainData(1,242) = theseStats(iTeam1,5);
            trainData(1,243) = theseStats(iTeam1,6);
            trainData(1,244) = theseStats(iTeam1,7);
            trainData(1,245) = theseStats(iTeam1,8);
            trainData(1,246) = theseStats(iTeam1,9);
            trainData(1,247) = theseStats(iTeam2,2);
            trainData(1,248) = theseStats(iTeam2,3);
            trainData(1,249) = theseStats(iTeam2,4);
            trainData(1,250) = theseStats(iTeam2,5);
            trainData(1,251) = theseStats(iTeam2,6);
            trainData(1,252) = theseStats(iTeam2,7);
            trainData(1,253) = theseStats(iTeam2,8);
            trainData(1,254) = theseStats(iTeam2,9);
        case 'TacklesForLossAllowed'
            trainData(1,255) = theseStats(iTeam1,2);
            trainData(1,256) = theseStats(iTeam1,3);
            trainData(1,257) = theseStats(iTeam1,4);
            trainData(1,258) = theseStats(iTeam1,5);
            trainData(1,259) = theseStats(iTeam1,6);
            trainData(1,260) = theseStats(iTeam2,2);
            trainData(1,261) = theseStats(iTeam2,3);
            trainData(1,262) = theseStats(iTeam2,4);
            trainData(1,263) = theseStats(iTeam2,5);
            trainData(1,264) = theseStats(iTeam2,6);
        case 'TeamPassingEfficiency'
            trainData(1,265) = theseStats(iTeam1,2);
            trainData(1,266) = theseStats(iTeam1,3);
            trainData(1,267) = theseStats(iTeam1,4);
            trainData(1,268) = theseStats(iTeam1,5);
            trainData(1,269) = theseStats(iTeam1,6);
            trainData(1,270) = theseStats(iTeam1,7);
            trainData(1,271) = theseStats(iTeam2,2);
            trainData(1,272) = theseStats(iTeam2,3);
            trainData(1,273) = theseStats(iTeam2,4);
            trainData(1,274) = theseStats(iTeam2,5);
            trainData(1,275) = theseStats(iTeam2,6);
            trainData(1,276) = theseStats(iTeam2,7);
        case 'TeamPassingEfficiencyDefense'
            trainData(1,277) = theseStats(iTeam1,2);
            trainData(1,278) = theseStats(iTeam1,3);
            trainData(1,279) = theseStats(iTeam1,4);
            trainData(1,280) = theseStats(iTeam1,5);
            trainData(1,281) = theseStats(iTeam1,6);
            trainData(1,282) = theseStats(iTeam1,7);
            trainData(1,283) = theseStats(iTeam2,2);
            trainData(1,284) = theseStats(iTeam2,3);
            trainData(1,285) = theseStats(iTeam2,4);
            trainData(1,286) = theseStats(iTeam2,5);
            trainData(1,287) = theseStats(iTeam2,6);
            trainData(1,288) = theseStats(iTeam2,7);
        case 'TeamSacks'
            trainData(1,289) = theseStats(iTeam1,2);
            trainData(1,290) = theseStats(iTeam1,3);
            trainData(1,291) = theseStats(iTeam1,4);
            trainData(1,292) = theseStats(iTeam2,2);
            trainData(1,293) = theseStats(iTeam2,3);
            trainData(1,294) = theseStats(iTeam2,4);
        case 'TeamTacklesForLoss'
            trainData(1,295) = theseStats(iTeam1,2);
            trainData(1,296) = theseStats(iTeam1,3);
            trainData(1,297) = theseStats(iTeam1,4);
            trainData(1,298) = theseStats(iTeam1,5);
            trainData(1,299) = theseStats(iTeam1,6);
            trainData(1,300) = theseStats(iTeam2,2);
            trainData(1,301) = theseStats(iTeam2,3);
            trainData(1,302) = theseStats(iTeam2,4);
            trainData(1,303) = theseStats(iTeam2,5);
            trainData(1,304) = theseStats(iTeam2,6);
        case 'TimeOfPossession'
            trainData(1,305) = theseStats(iTeam1,2);
            trainData(1,306) = theseStats(iTeam1,3);
            trainData(1,307) = theseStats(iTeam2,2);
            trainData(1,308) = theseStats(iTeam2,3);
        case 'TotalDefense'
            trainData(1,309) = theseStats(iTeam1,2);
            trainData(1,310) = theseStats(iTeam1,3);
            trainData(1,311) = theseStats(iTeam1,4);
            trainData(1,312) = theseStats(iTeam1,5);
            trainData(1,313) = theseStats(iTeam1,6);
            trainData(1,314) = theseStats(iTeam1,7);
            trainData(1,315) = theseStats(iTeam2,2);
            trainData(1,316) = theseStats(iTeam2,3);
            trainData(1,317) = theseStats(iTeam2,4);
            trainData(1,318) = theseStats(iTeam2,5);
            trainData(1,319) = theseStats(iTeam2,6);
            trainData(1,320) = theseStats(iTeam2,7);
        case 'TotalOffense'
            trainData(1,321) = theseStats(iTeam1,2);
            trainData(1,322) = theseStats(iTeam1,3);
            trainData(1,323) = theseStats(iTeam1,4);
            trainData(1,324) = theseStats(iTeam1,5);
            trainData(1,325) = theseStats(iTeam1,6);
            trainData(1,326) = theseStats(iTeam1,7);
            trainData(1,327) = theseStats(iTeam2,2);
            trainData(1,328) = theseStats(iTeam2,3);
            trainData(1,329) = theseStats(iTeam2,4);
            trainData(1,330) = theseStats(iTeam2,5);
            trainData(1,331) = theseStats(iTeam2,6);
            trainData(1,332) = theseStats(iTeam2,7);
        case 'TurnoverMargin'
            trainData(1,333) = theseStats(iTeam1,2);
            trainData(1,334) = theseStats(iTeam1,3);
            trainData(1,335) = theseStats(iTeam1,4);
            trainData(1,336) = theseStats(iTeam1,5);
            trainData(1,337) = theseStats(iTeam1,6);
            trainData(1,338) = theseStats(iTeam1,7);
            trainData(1,339) = theseStats(iTeam1,8);
            trainData(1,340) = theseStats(iTeam1,9);
            trainData(1,341) = theseStats(iTeam2,2);
            trainData(1,342) = theseStats(iTeam2,3);
            trainData(1,343) = theseStats(iTeam2,4);
            trainData(1,344) = theseStats(iTeam2,5);
            trainData(1,345) = theseStats(iTeam2,6);
            trainData(1,346) = theseStats(iTeam2,7);
            trainData(1,347) = theseStats(iTeam1,8);
            trainData(1,348) = theseStats(iTeam1,9);
        case 'TurnoversGained'
            trainData(1,349) = theseStats(iTeam1,2);
            trainData(1,350) = theseStats(iTeam1,3);
            trainData(1,351) = theseStats(iTeam1,4);
            trainData(1,352) = theseStats(iTeam2,2);
            trainData(1,353) = theseStats(iTeam2,3);
            trainData(1,354) = theseStats(iTeam2,4);
        case 'TurnoversLost'
            trainData(1,355) = theseStats(iTeam1,2);
            trainData(1,356) = theseStats(iTeam1,3);
            trainData(1,357) = theseStats(iTeam1,4);
            trainData(1,358) = theseStats(iTeam2,2);
            trainData(1,359) = theseStats(iTeam2,3);
            trainData(1,360) = theseStats(iTeam2,4);
        otherwise
            fprintf('Typo: %s\n', thisStatName);
            return
    end
end

%% === Clean up ===
fclose(teamStatNames);

%%
end
