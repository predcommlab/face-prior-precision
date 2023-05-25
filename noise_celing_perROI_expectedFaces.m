% Expected faces: This script compute the noise ceiling
% First the RDMs from ROIs for each subjects are loaded
% as a reference RDM
% Second the model RDMs are loaded as candidate RDMs

%% create reference RDMs (one for each subject) from fMRI RSA
load('../data/fMRI_multivariate/HypothesisModels.mat');
%% aTL
load('../data/fMRI_multivariate/aTL/RDMsingleSubs.mat');
%% OFA
%load('../data/fMRI_multivariate/OFA/RDMsingleSubs.mat');
%% aFFA
%load('../data/fMRI_multivariate/aFFA/RDMsingleSubs.mat');
%% pFFA
%load('../data/fMRI_multivariate/pFFA/RDMsingleSubs.mat');

%% load singel subjects RDMs
for sub = 1:length(RDMsingleSubs)
    refRDM(:,:,sub)  = RDMsingleSubs(1,sub).RDM;
end

%% set up candidate RDMs
candRDM{1}.RDM    = Models.PresentedLocExpectedMainFaceIDProbabilitySharp;
candRDM{1}.colour = [0,0,0];
candRDM{1}.name   = 'Expected graded probability';

candRDM{2}.RDM    = Models.PresentedLocExpectedMainFaceIDhighSharp;
candRDM{2}.colour = [0,0,0];
candRDM{2}.name   = 'Expected high probability';

candRDM{3}.RDM    = Models.PresentedLocExpectedMainFaceID_ushapeProbSharp;
candRDM{3}.colour = [0,0,0];
candRDM{3}.name   = 'Expected faces U-shape probability';
    
%% compute noise ceiling with compareRefRDM2candRDMs(refRDM, candRDMs, userOptions)
% In all these cases, one reference RDM is compared to multiple candidates.
userOptions.RDMcorrelationType     = 'Kendall_taua';
userOptions.candRDMdifferencesMultipleTesting = 'FDR';

refRDM_stack = stripNsquareRDMs(refRDM);
[nCond,nCond,nRefRDMinstances]=size(refRDM_stack);
candRDMmask = ~isnan(Models.PresentedLocExpectedMainFaceID_ushapeProbSharp);  
refRDM_stack(repmat(~candRDMmask,1,1,nRefRDMinstances)) = NaN;

% get upper and lower ceiling
[ceilingUpperBound, ceilingLowerBound, bestFitRDM] = ceilingAvgRDMcorr(refRDM_stack,userOptions.RDMcorrelationType,false);

% compare reference and candidate RDMs
[stats_p_r_mod1]   = compareRefRDM2candRDMs(refRDM_stack, candRDM, userOptions)
