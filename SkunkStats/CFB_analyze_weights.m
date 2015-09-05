function CFB_analyze_weights(model, lib)

if strcmp(lib, 'libsvm')
  w = CFB_calc_weights(model, 'libsvm');
elseif strcmp(lib, 'liblinear')
  w = model.w;
else 
  disp('lib must be libsvm or liblinear')
end

[sorted_d_w sorted_d_ind] = sort(w, 'descend');
[sorted_a_w sorted_a_ind] = sort(w, 'ascend');

disp('Your top indices are:')
for i = 1:10
  fprintf('%d = %.4f\n', sorted_d_ind(i), sorted_d_w(i));
end

disp('Your bottom indices are:')
for j = 1:10
  fprintf('%d = %.4f\n', sorted_a_ind(j), sorted_a_w(j));
end

end
