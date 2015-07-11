function oppStrengths = CFB_find_oppStrengths(year, week)
%
addpath ../Base

%% === Parse overall data for team strengths ===
NTEAMS = 129;
nWeeks = eval(week);
oppStrengths = zeros(NTEAMS, nWeeks);
weekOffset = 1;
for iWeek = 0:nWeeks-1
    % Do we include week 0?
    if iWeek == 0 && eval(week) > 3
        weekOffset = 0;
        continue
    end
    % Open the file
    thisWeek = sprintf('0%d', iWeek);
    if length(thisWeek) == 3
        thisWeek = thisWeek(2:3);
    end
    thisFile = sprintf('OverallData-%s-%s.cfb', year, thisWeek);
    thisData = csvread(thisFile);
    oppStrengths(:,iWeek+weekOffset) = thisData(:,4);
end
oppStrengths(:,nWeeks+weekOffset) = oppStrengths(:,nWeeks-1+weekOffset);

%%
end
