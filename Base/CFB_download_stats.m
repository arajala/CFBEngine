function CFB_download_stats(year, week, print)
%
NTEAMS = 129;

%% === Total offense ===
toUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category10/sort01.html', year);
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
poUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category02/sort01.html', year);
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
roUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category01/sort01.html', year);
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

%% === Total defense ===
tdUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/defense/split01/category10/sort01.html', year);
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
pdUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/defense/split01/category02/sort01.html', year);
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
rdUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/defense/split01/category01/sort01.html', year);
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

%% === Special teams punting ===
stpUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category06/sort01.html', year);
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

%% === Special teams punt returns ===
stprUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category04/sort01.html', year);
stprStats = zeros(NTEAMS, 1);
try
    str = urlread(stprUrl);
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
        stprStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Special teams kick returns ===
stkrUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category05/sort01.html', year);
stkrStats = zeros(NTEAMS, 1);
try
    str = urlread(stkrUrl);
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
        stkrStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === 3rd down ===
d3Url = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category25/sort01.html', year);
d3Stats = zeros(NTEAMS, 1);
try
    str = urlread(d3Url);
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
        d3Stats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === 4th down ===
d4Url = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category26/sort01.html', year);
d4Stats = zeros(NTEAMS, 1);
try
    str = urlread(d4Url);
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
        d4Stats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Penalties ===
penUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category14/sort01.html', year);
penStats = zeros(NTEAMS, 1);
try
    str = urlread(penUrl);
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
        penStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Opp 1st down ===
oppD1Url = sprintf('http://www.cfbstats.com/%s/leader/national/team/defense/split01/category13/sort01.html', year);
oppD1Stats = zeros(NTEAMS, 1);
try
    str = urlread(oppD1Url);
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
        oppD1Stats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === 1st down ===
d1Url = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category13/sort01.html', year);
d1Stats = zeros(NTEAMS, 1);
try
    str = urlread(d1Url);
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
        d1Stats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Sacks allowed ===
sackUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/defense/split01/category20/sort01.html', year);
sackStats = zeros(NTEAMS, 1);
try
    str = urlread(sackUrl);
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
        sackStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Scoring offense ===
oScoreUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category09/sort01.html', year);
oScoreStats = zeros(NTEAMS, 1);
try
    str = urlread(oScoreUrl);
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
        oScoreStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === TOP ===
timeUrl = sprintf('http://www.cfbstats.com/%s/leader/national/team/offense/split01/category15/sort01.html', year);
timeStats = zeros(NTEAMS, 1);
try
    str = urlread(timeUrl);
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
        timeStats(iTeam,(1:nStats)) = matStats;
    end
catch
    sprintf('Error during special teams returns, skipping\n');
end

%% === Print stats to file ===
CFB_print_stats(year, week, toStats, poStats, roStats, tdStats, pdStats, ...
rdStats, stpStats, stprStats, stkrStats, d3Stats, d4Stats, penStats, oppD1Stats, ...
d1Stats, sackStats, oScoreStats, timeStats);

%%
end
