% This script analyses behavioural responses from the MRI session.
% There are 3 scences predicting 3 face images at 3 levels of probability.
% Partcipants had to respond on a scale from 1:3 how likely the image was
% given the preceding scene.

%% load in data
% there are 7 columns:
% 1. overall correct,
% 2. correct low prob, 3. correct mid prob, 4. correct high prob,
% 5. RT low prob, 6. RT mid prob, 7. RT high prob
data = open('../data/behaviourDat.mat');
data=data.data;

%% set colours
cb = [0.5 0.8 0.9; 1 1 0.7; 0.7 0.8 0.9; 0.8 0.5 0.4; 0.5 0.7 0.8; 1 0.8 0.5; 0.7 1 0.4; 1 0.7 1; 0.6 0.6 0.6; 0.7 0.5 0.7; 0.8 0.9 0.8; 1 1 0.4];

%% fit function to data "correct/incorrect" over 3 conditions per participant
removeSubjects = [2,5,8,12,26];
data(removeSubjects,:)=[]
for sub = 1:length(data)
        % fit a line
        [fitpoly1{sub},gof_poly1{sub}] = fit([-1:1]',data(sub,2:4)', 'poly1');
        % fit a quadratic curve with minimum at 0 = second value
        [fitpoly2{sub},gof_poly2{sub}] = fit([-1:1]',data(sub,2:4)', @(a,c,x) a*x.^2+c);
end
m1 = cell2mat(gof_poly1);
m2 = cell2mat(gof_poly2);

% better fit per subject
m1sse = vertcat(m1.sse); m2sse = vertcat(m2.sse);
colorLineBetter = double(m1sse < m2sse)';
colorUBetter = double(m1sse > m2sse)';

%% plot two groups
LineGroup = [];
UGroup = [];
LineGroupRT = [];
UGroupRT = [];
for sub = 1:length(data)
        if colorLineBetter(sub) == 1
            LineGroup = [LineGroup; data(sub,2:4)]
            LineGroupRT = [LineGroupRT; data(sub,5:7)]
        elseif colorLineBetter(sub) == 0
            UGroup = [UGroup; data(sub,2:4)]
            UGroupRT = [UGroupRT; data(sub,5:7)]
        end
end

meanLineGroup = mean(LineGroup);
seLineGroup = se(LineGroup);
meanUGroup = mean(UGroup);
seUGroup = se(UGroup);

figure;
subplot(1,3,1); violinplot([LineGroup;UGroup])
subplot(1,3,2); violinplot(LineGroup)
subplot(1,3,3); violinplot(UGroup)
title(['Correct behaviour all + line + U' ]);

figure;
subplot(1,3,1); violinplot([LineGroupRT;UGroupRT])
subplot(1,3,2); violinplot(LineGroupRT)
subplot(1,3,3); violinplot(UGroupRT)
title(['RTs all + line + U' ]);

%% plot RT as rainbow plot
cl3(3, :) = cb(6, :);
figure; h = rm_raincloud({data(:,5), data(:,6), data(:,7)}, cl3);

[cb] = cbrewer('div', 'BrBG', 12, 'pchip');
figure;
h1 = raincloud_plot(data(:,5), 'box_on', 1, 'color', cb(9,:), 'alpha', 0.5,...
    'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .15,...
    'box_col_match', 1);
h2 = raincloud_plot(data(:,6), 'box_on', 1, 'color', cb(10,:), 'alpha', 0.7,...
    'box_dodge', 1, 'box_dodge_amount', .35, 'dot_dodge_amount', .35,...
    'box_col_match', 1);
h3 = raincloud_plot(data(:,7), 'box_on', 1, 'color', cb(11,:), 'alpha', 0.9,...
    'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', .55,...
    'box_col_match', 1);
xlabel('RT in sec'); xlim([0.4 0.85]); ylim([-6 11]);
legend([h1{1} h2{1} h3{1}], 'low prob', 'mid prob', 'high prob');
title([' RT across ' length(data) ' subjects']);

% test RT differences
X1 = [data(:,5); data(:,6); data(:,7)];
X2 = [ones(length(data),1); 2*ones(length(data),1); 3*ones(length(data),1)];
X3 = [1:length(data), 1:length(data), 1:length(data)]';
RMAOV1([X1, X2, X3], 0.5)
RTlowP = mean(data(:,5))
RTmidP = mean(data(:,6))
RThighP = mean(data(:,7))

[H,P,CI, STATS] = ttest(data(:,5), data(:,6))
[H,P,CI, STATS] = ttest(data(:,5), data(:,7))
[H,P,CI, STATS] = ttest(data(:,6), data(:,7))
