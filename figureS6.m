clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

clr = [0, 0, 0; %TE
       150, 0, 80; % EPI-1
       100, 100, 100] / 255; % ICM
names = {'TE', 'EPI-1', 'ICM'};

[Tree_NG3, Traces_NG3] = load_dataset('NG-3');
[Tree_NG4, Traces_NG4] = load_dataset('NG-4');
[Tree_NG6, Traces_NG6] = load_dataset('NG-6');

t_star = 1.2;
K = 3;
final_node_labels_NG3 = run_kmeans(Tree_NG3, Traces_NG3, t_star, K);
final_node_labels_NG4 = run_kmeans(Tree_NG4, Traces_NG4, t_star, K);
final_node_labels_NG6 = run_kmeans(Tree_NG6, Traces_NG6, t_star, K);

% update labels so that the 2nd column is now EPI-1, and the third column
% are the remaining ICM cells

% NG-3
[~, final_EPI1_ind_NG3] = ismember(Tree_NG3.final_EPI1_names, Traces_NG3.final_node_names);
final_node_labels_EPI1_NG3 = zeros(size(final_node_labels_NG3, 1), 3);
final_node_labels_EPI1_NG3(:,1) = final_node_labels_NG3(:,1);
final_node_labels_EPI1_NG3(:,3) = any(final_node_labels_NG3(:,2:end) == 1, 2);
final_node_labels_EPI1_NG3(final_EPI1_ind_NG3,2) = 1;
final_node_labels_EPI1_NG3(final_EPI1_ind_NG3,3) = 0;

% NG-4
[~, final_EPI1_ind_NG4] = ismember(Tree_NG4.final_EPI1_names, Traces_NG4.final_node_names);
final_node_labels_EPI1_NG4 = zeros(size(final_node_labels_NG4, 1), 3);
final_node_labels_EPI1_NG4(:,1) = final_node_labels_NG4(:,1);
final_node_labels_EPI1_NG4(:,3) = any(final_node_labels_NG4(:,2:end) == 1, 2);
final_node_labels_EPI1_NG4(final_EPI1_ind_NG4,2) = 1;
final_node_labels_EPI1_NG4(final_EPI1_ind_NG4,3) = 0;

% NG-6
[~, final_EPI1_ind_NG6] = ismember(Tree_NG6.final_EPI1_names, Traces_NG6.final_node_names);
final_node_labels_EPI1_NG6 = zeros(size(final_node_labels_NG6, 1), 3);
final_node_labels_EPI1_NG6(:,1) = final_node_labels_NG6(:,1);
final_node_labels_EPI1_NG6(:,3) = any(final_node_labels_NG6(:,2:end) == 1, 2);
final_node_labels_EPI1_NG6(final_EPI1_ind_NG6,2) = 1;
final_node_labels_EPI1_NG6(final_EPI1_ind_NG6,3) = 0;

%% Panel 4A
figure;
plot_average_traces(Tree_NG3, Traces_NG3, final_node_labels_EPI1_NG3, 'Nanog_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'Location', 'northwest');
title('NG-3');

figure;
plot_average_traces(Tree_NG4, Traces_NG4, final_node_labels_EPI1_NG4, 'Nanog_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'Location', 'northwest');
title('NG-4');

figure;
plot_average_traces(Tree_NG6, Traces_NG6, final_node_labels_EPI1_NG6, 'Nanog_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'Location', 'northwest');
title('NG-6');

%% Panel 4B
figure;
plot_average_traces(Tree_NG3, Traces_NG3, final_node_labels_EPI1_NG3, 'Gata6_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'Location', 'northwest');
title('NG-3');

figure;
plot_average_traces(Tree_NG4, Traces_NG4, final_node_labels_EPI1_NG4, 'Gata6_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'Location', 'northwest');
title('NG-4');

figure;
plot_average_traces(Tree_NG6, Traces_NG6, final_node_labels_EPI1_NG6, 'Gata6_norm', clr, names, [2, 3], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'Location', 'northwest');
title('NG-6');