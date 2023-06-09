function Models = modelRDMs_hbp1(plot)

%  modelRDMs is a user-editable function which specifies the models which
%  brain-region RDMs should be compared to, and which specifies which kinds of
%  analysis should be performed.
%
%  Models should be stored in the "Models" struct as a single field labeled
%  with the model's name (use underscores in stead of spaces).
%
%  Cai Wingfield 11-2009

%% 1. create model RDMS
% #1
Models.PresentedLocExpectedMainFaceIDProbabilitySharp = ...
    [[NaN(3,12), ...
    [[1 0.5 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 0.5 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 0.5 0]]]; ...
    NaN(9,21); ...
    [[[1 0.5 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 0.5 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 0.5 0]]', NaN(9,18)]];
% #2
Models.PresentedLocExpectedMainFaceIDhighSharp = ...
    [[NaN(3,12), ...
    [[1 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 1 0]]]; ...
    NaN(9,21); ...
    [[[1 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 1 0]]', NaN(9,18)]];
% #3
Models.PresentedLocExpectedMainFaceID_ushapeProbSharp = ...
    [[NaN(3,12), ...
    [[0 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 0 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 0 1 0]]]; ...
    NaN(9,21); ...
    [[[0 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 0 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 0 1 0]]', NaN(9,18)]];

% #4
Models.PresentedLocPresentedMainFaceIDProbabilitySharp = ...
    [[NaN(3,3), ...
    [[1 0.5 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 0.5 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 0.5 0]], ...
    NaN(3,9)]; ...
    [[[1 0.5 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 0.5 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 0.5 0]]', NaN(9,18)]; ...
    NaN(9,21)];
% #5
Models.PresentedLocPresentedMainFaceIDhighSharp = ...
    [[NaN(3,3), ...
    [[ 1 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 1 0]], ...
    NaN(3,9)]; ...
    [[[1 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 1 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 1 1 0]]', NaN(9,18)]; ...
    NaN(9,21)];
% #6
Models.PresentedLocPresentedMainFaceID_ushapeSharp = ...
    [[NaN(3,3), ...
    [[0 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 0 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 0 1 0]], ...
    NaN(3,9)]; ...
    [[[0 1 0; NaN(1,3); NaN(1,3)], [NaN(1,3); 0 1 0; NaN(1,3)], [NaN(1,3); NaN(1,3); 0 1 0]]', NaN(9,18)]; ...
    NaN(9,21)];

%% 2. plot RDMs

labels =  {...
    'F1loc','F2loc','F3loc', ...
    'F1presLOWprob','F1presMIDprob','F1presHIGHprob', ...
    'F2presLOWprob','F2presMIDprob','F2presHIGHprob', ...
    'F3presLOWprob','F3presMIDprob','F3presHIGHprob', ...
    'F1expLOWprob','F1expMIDprob','F1expHIGHprob', ...
    'F2expLOWprob','F2expMIDprob','F2expHIGHprob', ...
    'F3expLOWprob','F3expMIDprob','F3expHIGHprob'};

if plot == 1
    %1
    figure; RDMPresentedFaceIDacrossLocalizerMainExp = ...
        imagesc(Models.PresentedFaceIDacrossLocalizerMainExp);
    set(RDMPresentedFaceIDacrossLocalizerMainExp, ...
        'alphadata', ~isnan(Models.PresentedFaceIDacrossLocalizerMainExp))
    c = colorbar; colormap jet;
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented FaceID across Localizer MainExp', 'FontSize', 10);
    
    %2
    figure; RDMPresentedFaceIDwithinMainExp = ...
        imagesc(Models.PresentedFaceIDwithinMainExp);
    set(RDMPresentedFaceIDwithinMainExp, ...
        'alphadata', ~isnan(Models.PresentedFaceIDwithinMainExp))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented FaceID within MainExp', 'FontSize', 10);
    
    %3
    figure; RDMPresentedFaceIDwithinMainExpProbability = ...
        imagesc(Models.PresentedFaceIDwithinMainExpProbability);
    set(RDMPresentedFaceIDwithinMainExpProbability, ...
        'alphadata', ~isnan(Models.PresentedFaceIDwithinMainExpProbability))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented FaceID within MainExp probability', 'FontSize', 10);
    %4
    figure; RDMPresentedLocPresentedMainFaceIDProbabilityPE = ...
        imagesc(Models.PresentedLocPresentedMainFaceIDProbabilityPE);
    set(RDMPresentedLocPresentedMainFaceIDProbabilityPE, ...
        'alphadata', ~isnan(Models.PresentedLocPresentedMainFaceIDProbabilityPE))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented Face Localizer vs Presented Face MainExp Probability PE', 'FontSize', 10);
    %5
    figure; RDMPresentedLocPresentedMainFaceIDProbabilitySharp = ...
        imagesc(Models.PresentedLocPresentedMainFaceIDProbabilitySharp);
    set(RDMPresentedLocPresentedMainFaceIDProbabilitySharp, ...
        'alphadata', ~isnan(Models.PresentedLocPresentedMainFaceIDProbabilitySharp))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented Face Localizer vs Presented Face MainExp Probability sharp', 'FontSize', 10);
    %6
    figure; RDMPresentedLocExpectedMainFaceIDProbability = ...
        imagesc(Models.PresentedLocExpectedMainFaceIDProbability);
    set(RDMPresentedLocExpectedMainFaceIDProbability, ...
        'alphadata', ~isnan(Models.PresentedLocExpectedMainFaceIDProbability))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented Face Localizer vs Expected Face MainExp Probability', 'FontSize', 10);
    %7
    figure; RDMPresentedLocExpectedMainFaceIDhighProb = ...
        imagesc(Models.PresentedLocExpectedMainFaceIDhighProb);
    set(RDMPresentedLocExpectedMainFaceIDhighProb, ...
        'alphadata', ~isnan(Models.PresentedLocExpectedMainFaceIDhighProb))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented Face Localizer vs Expected Face MainExp only high probability', 'FontSize', 10);
    
    %8
    figure; RDMPresentedMainExpectedMainFaceIDProbability = ...
        imagesc(Models.PresentedMainExpectedMainFaceIDProbability);
    set(RDMPresentedMainExpectedMainFaceIDProbability, ...
        'alphadata', ~isnan(Models.PresentedMainExpectedMainFaceIDProbability))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented Face MainExp vs Expected Face MainExp', 'FontSize', 10);
    
    %12
    figure; RDMPresentedMainSurpriseNoID = ...
        imagesc(Models.PresentedMainSurpriseNoID);
    set(RDMPresentedMainSurpriseNoID, ...
        'alphadata', ~isnan(Models.PresentedMainSurpriseNoID))
    c = colorbar; colormap jet;
    ylabel(c, 'dissimilarity');
    set(gca, 'XTick', 1:21, 'YTick', 1:21);
    set(gca, 'XTickLabel',labels, ...
        'YTickLabel',labels);
    xticklabel_rotate([],45)
    ylabel(c, 'dissimilarity');
    title('Presented surprise MainExp', 'FontSize', 10);
end

