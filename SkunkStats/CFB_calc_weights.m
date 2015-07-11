function Wjs = CFB_calc_weights(theSVMModel)
%

% Initialize the weight space for the features.
LagrangeAlpha  = theSVMModel.sv_coef;
SupportVectors = full(theSVMModel.SVs);
nFeatures      = size(SupportVectors,2);

% Both Bioinformatics and LIBSVM return really what they call AlphaHat --
% which has group membership multiplied into it.

Wjs = sum(SupportVectors.*repmat(LagrangeAlpha,[1 nFeatures]),1);

Wjs = Wjs(:)';

end
