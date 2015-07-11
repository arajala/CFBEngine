function CFB_download_scores(file, url, print)
% file - .cfb file to save results
%
% url - web address to weekly scores
%
% print - toggle printing results to command window
%

%% === Ensure URL starts with http://, not www. ===
if ~strncmp(url, 'http://', 7)
    url = sprintf('%s%s', 'http://', url);
end

%% === Read the URL ===
try
    str = urlread(url);
catch
    fprintf('Error reading URL %s, exiting\n', url);
end

%% === Read in all game results ===
moreGames = true;
nGames = 1;
allScores = '';
while moreGames
    [trimmedStr str] = CFB_trim_scores(str);
    if strcmp(trimmedStr, '')
        moreGames = false;
        continue
    end
    thisScore = CFB_html2csv_scores(trimmedStr);
    if ~strcmp(thisScore, '')
        %fprintf('Read game %d\n', nGames);
        allScores = sprintf('%s%s\n', allScores, thisScore);
        nGames = nGames + 1;
    end
end

%% === Ensure filename has .cfb extension ===
if isempty(strfind(file, '.cfb'))
    file = sprintf('%s%s', file, '.cfb');
end

%% === Ensure filename has ../Scores/ directory ===
if isempty(strfind(file, '/Scores/'))
    file = sprintf('%s%s', '../Scores/', file);
end

%% === Open, write, and close file ===
fid = fopen(file, 'w');
fprintf(fid, '%s', allScores);
fclose(fid);

%% === Print results ===
if print
    fprintf('%s', allScores);
end

%%
end
