% correlate model RDMs and neural RDMs
%% select ROI
% ROIname = 'aTL'; 
ROIname  = 'insula'
% ROIname = 'FFA'; 

%% load behavioural weights, 
% i.e. correct performance for the three levels of probabilty
respCorr_3prob = load('../data/behaviourDat.mat');
respCorr_3prob = respCorr_3prob.data(:,2:4);

%% load model and neural RDMs for selected ROI
RDMsingleSubs = load(['../data/multivariate/ROI/' ROIname '/RDMsingleSubs.mat']);

%% vectourize model RDMs for 21 conditions
% initialize vector to store correlations for all subjects
r_allSubs = NaN(length(RDMsingleSubs.RDMsingleSubs),1);
% loop though subjects and correlate model and neural RDM vectors
for sub = 1 : length(RDMsingleSubs.RDMsingleSubs)
    currentSubjRDMvec = vectorizeRDM(squeeze(RDMsingleSubs.RDMsingleSubs(sub).RDM));
    
    % current subject model RDM
    %% during expectation 
    PresLocExpMainFaceID_individ_behaviour = ...
        [[NaN(3,12), ...
        [[1-respCorr_3prob(sub, :); NaN(1,3); NaN(1,3)], [NaN(1,3); 1-respCorr_3prob(sub, :); NaN(1,3)], [NaN(1,3); NaN(1,3); 1-respCorr_3prob(sub, :)]]]; ...
        NaN(9,21); ...
        [[[1-respCorr_3prob(sub, :); NaN(1,3); NaN(1,3)], [NaN(1,3); 1-respCorr_3prob(sub, :); NaN(1,3)], [NaN(1,3); NaN(1,3); 1-respCorr_3prob(sub, :)]]', NaN(9,18)]];
    
    PresLocExpMainFaceID_individ_behaviour = vectorizeRDM(squeeze(PresLocExpMainFaceID_individ_behaviour));
    [rPresLocExpMainFaceIDProb_individ_behaviour,pPresLocExpMainFaceIDProb_individ_behaviour] = ...
        corr(currentSubjRDMvec', PresLocExpMainFaceID_individ_behaviour', ...
        'type', 'Spearman', 'rows', 'pairwise');
    rPresLocExpMainFaceIDProb_individ_behaviour_allSubs(sub,1) = rPresLocExpMainFaceIDProb_individ_behaviour;
    
    %% during presented face surprise
    PresLocPresMainFaceID_individ_behaviour = ...
        [[NaN(3,3), ...
        [[respCorr_3prob(sub, :); NaN(1,3); NaN(1,3)], [NaN(1,3); respCorr_3prob(sub, :); NaN(1,3)], [NaN(1,3); NaN(1,3); respCorr_3prob(sub, :)]], ...
        NaN(3,9)]; ...
        [[[respCorr_3prob(sub, :); NaN(1,3); NaN(1,3)], [NaN(1,3); respCorr_3prob(sub, :); NaN(1,3)], [NaN(1,3); NaN(1,3); respCorr_3prob(sub, :)]]', NaN(9,18)]; ...
        NaN(9,21)];
    
    PresLocPresMainFaceID_individ_behaviour = vectorizeRDM(squeeze(PresLocPresMainFaceID_individ_behaviour));
    [rPresLocPresMainFaceID_individ_behaviour,pPresLocPresMainFaceID_individ_behaviour] = ...
        corr(currentSubjRDMvec', PresLocPresMainFaceID_individ_behaviour', ...
        'type', 'Spearman', 'rows', 'pairwise');
    rPresLocPresMainFaceID_individ_behaviour_allSubs(sub,1) = rPresLocPresMainFaceID_individ_behaviour;
    
end

%% test correaltions
% control model with Face ID across localizer and main EXp
%% correct performance
rPresLocExpMainFaceIDProb_individ_behaviour_mean = mean(rPresLocExpMainFaceIDProb_individ_behaviour_allSubs)
rPresLocExpMainFaceIDProb_individ_behaviour_allSubs_fz = ...
    fisherz(rPresLocExpMainFaceIDProb_individ_behaviour_allSubs);
[~,P,~,STATS] = ttest(rPresLocExpMainFaceIDProb_individ_behaviour_allSubs_fz)

%% expected faces
% jitter for the raindrops
spacing=1;
jit_width = spacing / 8;
raindrop_size = 100;
values2plot = rPresLocExpMainFaceIDProb_individ_behaviour_allSubs_fz;
for i = 1:length(values2plot)
        jit(i) = jit_width + rand(1, length(values2plot(i))) * jit_width;
end
y = values2plot;
N = length(y);
ySEM = std(y)/sqrt(N);                 % Compute Standard Error Of The Mean Of All Experiments At Each Value Of
CI95 = tinv([0.025 0.975], N-1);       % Calculate 95% Probability Intervals Of t-Distribution
yCI95 = bsxfun(@times, ySEM, CI95(:)); % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of 

figure; errorbarbar(mean(values2plot), yCI95(2))
hold on; scatter(0.8 +jit', values2plot)
title('PresentedLoc ExpectedMain FaceID Probability behaviour')

rPresLocPresMainFaceID_individ_behaviour_mean = mean(rPresLocPresMainFaceID_individ_behaviour_allSubs)
rPresLocPresMainFaceID_individ_behaviour_allSubs_fz = ...
    fisherz(rPresLocPresMainFaceID_individ_behaviour_allSubs);
[~,P,~,STATS] = ttest(rPresLocPresMainFaceID_individ_behaviour_allSubs_fz)

%% presented faces
% jitter for the raindrops
spacing=1;
jit_width = spacing / 8;
raindrop_size = 100;
values2plot = rPresLocPresMainFaceID_individ_behaviour_allSubs_fz;
for i = 1:length(values2plot)
        jit(i) = jit_width + rand(1, length(values2plot(i))) * jit_width;
end
y = values2plot;
N = length(y);
ySEM = std(y)/sqrt(N);                 % Compute Standard Error Of The Mean Of All Experiments At Each Value Of
CI95 = tinv([0.025 0.975], N-1);       % Calculate 95% Probability Intervals Of t-Distribution
yCI95 = bsxfun(@times, ySEM, CI95(:)); % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of 

figure; errorbarbar(mean(values2plot), yCI95(2))
hold on; scatter(0.8 +jit', values2plot)
title('PresentedLoc PresentedMain FaceID Probability behaviour')
