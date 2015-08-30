function CFB_download_stats(year, week, print)
%
NTEAMS = 129;

%% === Total offense ===
toUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=offense&conference=I-A_all&year=%s', year);
toStats = zeros(NTEAMS, 1);
try
    str = urlread(toUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        toStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during total offense, skipping\n');
end
%% === Passing offense ===
poUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=offense&cat2=Passing&conference=I-A_all&year=%s', year);
poStats = zeros(NTEAMS, 1);
try
    str = urlread(poUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        poStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during passing offense, skipping\n');
end

%% === Rushing offense ===
roUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=offense&cat2=Rushing&conference=I-A_all&year=%s', year);
roStats = zeros(NTEAMS, 1);
try
    str = urlread(roUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        roStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during rushing offense, skipping\n');
end

%% === Receiving offense ===
rcoUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=offense&cat2=Receiving&conference=I-A_all&year=%s', year);
rcoStats = zeros(NTEAMS, 1);
try
    str = urlread(rcoUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        rcoStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during receiving offense, skipping\n');
end

%% === Total defense ===
tdUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=defense&conference=I-A_all&year=%s', year);
tdStats = zeros(NTEAMS, 1);
try
    str = urlread(tdUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        tdStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during total defense, skipping\n');
end

%% === Passing defense ===
pdUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=defense&cat2=Passing&conference=I-A_all&year=%s', year);
pdStats = zeros(NTEAMS, 1);
try
    str = urlread(pdUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        pdStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during passing defense, skipping\n');
end

%% === Rushing defense ===
rdUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=defense&cat2=Rushing&conference=I-A_all&year=%s', year);
rdStats = zeros(NTEAMS, 1);
try
    str = urlread(rdUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        rdStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during rushing defense, skipping\n');
end

%% === Receiving defense ===
rcdUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=defense&cat2=Receiving&conference=I-A_all&year=%s', year);
rcdStats = zeros(NTEAMS, 1);
try
    str = urlread(rcdUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        rcdStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during receiving defense, skipping\n');
end

%% === Special teams punting ===
stpUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=special&conference=I-A_all&year=%s', year);
stpStats = zeros(NTEAMS, 1);
try
    str = urlread(stpUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        stpStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams punting, skipping\n');
end

%% === Special teams returns ===
strUrl = sprintf('http://sports.yahoo.com/ncaa/football/stats/byteam?cat1=special&cat2=Returns&conference=I-A_all&year=%s', year);
strStats = zeros(NTEAMS, 1);
try
    str = urlread(strUrl);
    moreStats = true;
    while moreStats
        [trimmedStr str] = CFB_trim_stats(str);
        if strcmp(trimmedStr, '')
            moreStats = false;
            continue
        end
        [school stats] = CFB_html2csv_stats(trimmedStr);
        nStats = numel(find(stats == ',')) + 1;
        iTeam = CFB_lookup(school, year);
        matStats = str2num(stats);
        matStats(matStats > 1e6) = 0;
        strStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Print stats to file ===
CFB_print_stats(year, week, toStats, poStats, roStats, rcoStats, tdStats, pdStats, rdStats, rcdStats, stpStats, strStats);

%%
end
