function results = CFB_sort_results(unsorted, col)

intermediateVector = cell2mat(unsorted(:,col));
[~, idx] = sort(intermediateVector);
results = unsorted(idx,:);

end
