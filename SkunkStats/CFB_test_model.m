function accuracies = CFB_test_model(model, lib, testYears, testWeeks)
%
addpath ../Base
addpath C:\libsvm-3.18\matlab
addpath C:\liblinear-1.94\matlab

%% === Read in scores and stats ===
if length(testYears) ~= length(testWeeks)
	fprintf('testYears and testWeeks are not the same length');
	return
end
nTests = length(testYears);
accuracies = zeros(nTests, 1);
for iTest = 1:nTests
	thisYear = testYears{iTest,1};
	thisWeek = testWeeks{iTest,1};
  lastWeek = sprintf('%02d', eval(thisWeek) - 1);
  if eval(lastWeek) == 0
    lastWeek = '01';
  end
	fileName = sprintf('../Scores/Scores-%s-%s.cfb', thisYear, thisWeek);
	fid = fopen(fileName, 'r');
	moreScores = true;
	mov = zeros(0,1);
	testData = zeros(0,0);
	testLabels = zeros(0,1);
	iGame = 1;
	while moreScores
		thisScore = fgetl(fid);
		if thisScore == -1
			moreScores = false;
			continue;
		end
		% Lookup team index
		commas = find(thisScore == ',');
		team1 = thisScore(1:commas(1)-1);
		team2 = thisScore(commas(1)+1:commas(2)-1);
		iTeam1 = CFB_lookup(team1, thisYear);
		iTeam2 = CFB_lookup(team2, thisYear);
		% Get data  features
    if eval(thisWeek) == 1
      lastYear = sprintf('%d', eval(thisYear)-1);
      testData(iGame,:) = CFB_find_features(iTeam1, iTeam2, lastYear, '16');
    elseif eval(thisWeek) < 4
        lastYear = sprintf('%d', eval(year)-1);
        preFraction = 1 / eval(week);
        testData(iGame,:) = preFraction * CFB_find_features(iTeam1, iTeam2, lastYear, '16') + ...
            (1-preFraction) * CFB_find_features(iTeam1, iTeam2, thisYear, lastWeek);
    else
        testData(iGame,:) = CFB_find_features(iTeam1, iTeam2, thisYear, lastWeek);
    end
		% Get labels
		score1 = thisScore(commas(2)+1:commas(3)-1);
		score2 = thisScore(commas(3)+1:end);
		score1 = eval(score1);
		score2 = eval(score2);
		if score2 > score1
			testLabels(iGame,1) = 1;
		else
			testLabels(iGame,1) = -1;
		end
		% Record margin of victory for evaluation
		mov(iGame,1) = score2 - score1;
		iGame = iGame + 1;
	end
	% Test model
	if strcmp(lib, 'libsvm')
		[p a pe] = svmpredict(testLabels, testData, model, '-b 0');
	elseif strcmp(lib, 'liblin')
		[p a pe] = linpredict(testLabels, sparse(testData), model, '-b 1');
	end
  accuracies(iTest) = a(1);
	fclose(fid);
end

%%
end
