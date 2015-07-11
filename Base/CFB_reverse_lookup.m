function teamStr = CFB_reverse_lookup(iTeam)
%

%% === Open team master list ===
fid = fopen('..\teams.cfb', 'r');

%% === Loop through teams i times, return line ===
for i = 1:iTeam
    teamStr = fgetl(fid);
    if teamStr == -1
        fprintf('Not enough teams in teams.cfb for iTeam = %d, must be FCS\n', iTeam);
    end
end

%% === Clean up ===
fclose(fid);

%%
end
