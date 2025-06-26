clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

%% Panels 4A & 4B
[Tree_NG1, Traces_NG1] = load_dataset('NG-1 short');
[Tree_NG2, Traces_NG2] = load_dataset('NG-2 short');

t_star = 1.2;
K = 3;
final_node_labels_NG1 = run_kmeans(Tree_NG1, Traces_NG1, t_star, K);
final_node_labels_NG2 = run_kmeans(Tree_NG2, Traces_NG2, t_star, K);

% update labels so that the 2nd column is now EPI-1, and the third column
% are the remaining ICM cells
[~, final_EPI1_ind_NG1] = ismember(Tree_NG1.final_EPI1_names, Traces_NG1.final_node_names);
final_node_labels_EPI1_NG1 = zeros(size(final_node_labels_NG1, 1), 3);
final_node_labels_EPI1_NG1(:,1) = final_node_labels_NG1(:,1);
final_node_labels_EPI1_NG1(:,3) = any(final_node_labels_NG1(:,2:end) == 1, 2);
final_node_labels_EPI1_NG1(final_EPI1_ind_NG1,2) = 1;
final_node_labels_EPI1_NG1(final_EPI1_ind_NG1,3) = 0;

[~, final_EPI1_ind_NG2] = ismember(Tree_NG2.final_EPI1_names, Traces_NG2.final_node_names);
final_node_labels_EPI1_NG2 = zeros(size(final_node_labels_NG2, 1), 3);
final_node_labels_EPI1_NG2(:,1) = final_node_labels_NG2(:,1);
final_node_labels_EPI1_NG2(:,3) = any(final_node_labels_NG2(:,2:end) == 1, 2);
final_node_labels_EPI1_NG2(final_EPI1_ind_NG2,2) = 1;
final_node_labels_EPI1_NG2(final_EPI1_ind_NG2,3) = 0;

clr = [0, 0, 0; %TE
       150, 0, 80; % EPI-1
       100, 100, 100] / 255; % ICM
names = {'TE', 'EPI-1', 'ICM'};

figure;
plot_average_traces(Tree_NG1, Traces_NG1, final_node_labels_EPI1_NG1, 'Nanog_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show');
title('NG-1');

figure;
plot_average_traces(Tree_NG2, Traces_NG2, final_node_labels_EPI1_NG2, 'Nanog_norm', clr, names, [2, 3], true);
ylim([0, 1]);
xlim([10, 45.75]);
xticks([10, 20, 30, 40]);
xticklabels([0, 10, 20, 30]);
ylabel('Normalized NANOG-mCherry');
legend('show');
title('NG-2');

figure;
plot_average_traces(Tree_NG1, Traces_NG1, final_node_labels_EPI1_NG1, 'Gata6_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show');
title('NG-1');

figure;
plot_average_traces(Tree_NG2, Traces_NG2, final_node_labels_EPI1_NG2, 'Gata6_norm', clr, names, [2, 3], true);
ylim([0, 1]);
xlim([10, 45.75]);
xticks([10, 20, 30, 40]);
xticklabels([0, 10, 20, 30]);
ylabel('Normalized GATA6-eGFP');
legend('show');
title('NG-2');

%% Panel 4D
[Tree_NGS1, Traces_NGS1] = load_dataset('NGS-1');

t_star = 1.2;
K = 3;
final_node_labels_NGS1 = run_kmeans(Tree_NGS1, Traces_NGS1, t_star, K);

figure;
plot_tree_sox2(Tree_NGS1, Traces_NGS1, final_node_labels_NGS1, false);
colorbar('Location', 'south');