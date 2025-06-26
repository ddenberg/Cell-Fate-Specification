clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

clr = [0, 0, 0; %TE
       227, 155, 0; % EPI-2
       180, 42, 201; % DP
       20, 56, 217; % PE
       150, 0, 80] / 255; % EPI-1
names = {'TE', 'EPI-2', 'DP', 'PE', 'EPI-1'};

[Tree_NG3, Traces_NG3] = load_dataset('NG-3');
[Tree_NG4, Traces_NG4] = load_dataset('NG-4');
[Tree_NG5, Traces_NG5] = load_dataset('NG-5');
[Tree_NG6, Traces_NG6] = load_dataset('NG-6');
[Tree_NG7, Traces_NG7] = load_dataset('NG-7');


%% Panel S9A (NG-3)
final_node_labels_NG3 = run_kmeans(Tree_NG3, Traces_NG3, 1.2, 3);

[~, final_EPI1_ind] = ismember(Tree_NG3.final_EPI1_names, Traces_NG3.final_node_names);
final_node_labels_EPI1_EPI2_NG3 = final_node_labels_NG3;
final_node_labels_EPI1_EPI2_NG3(final_EPI1_ind,5) = 1;
final_node_labels_EPI1_EPI2_NG3(final_EPI1_ind,2) = 0;

figure;
tiledlayout(1, 2);
nexttile;
plot_average_traces(Tree_NG3, Traces_NG3, final_node_labels_EPI1_EPI2_NG3, 'Nanog_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'location', 'northwest');
title('NG-3');

nexttile;
plot_average_traces(Tree_NG3, Traces_NG3, final_node_labels_EPI1_EPI2_NG3, 'Gata6_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'location', 'northwest');
title('NG-3');

%% Panel S9B (NG-4)
final_node_labels_NG4 = run_kmeans(Tree_NG4, Traces_NG4, 1.2, 3);

[~, final_EPI1_ind] = ismember(Tree_NG4.final_EPI1_names, Traces_NG4.final_node_names);
final_node_labels_EPI1_EPI2_NG4 = final_node_labels_NG4;
final_node_labels_EPI1_EPI2_NG4(final_EPI1_ind,5) = 1;
final_node_labels_EPI1_EPI2_NG4(final_EPI1_ind,2) = 0;

figure;
tiledlayout(1, 2);
nexttile;
plot_average_traces(Tree_NG4, Traces_NG4, final_node_labels_EPI1_EPI2_NG4, 'Nanog_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'location', 'northwest');
title('NG-4');

nexttile;
plot_average_traces(Tree_NG4, Traces_NG4, final_node_labels_EPI1_EPI2_NG4, 'Gata6_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'location', 'northwest');
title('NG-4');

%% Panel S9C (NG-5)
final_node_labels_NG5 = run_kmeans(Tree_NG5, Traces_NG5, 1.2, 3);

[~, final_EPI1_ind] = ismember(Tree_NG5.final_EPI1_names, Traces_NG5.final_node_names);
final_node_labels_EPI1_EPI2_NG5 = final_node_labels_NG5;
final_node_labels_EPI1_EPI2_NG5(final_EPI1_ind,5) = 1;
final_node_labels_EPI1_EPI2_NG5(final_EPI1_ind,2) = 0;

figure;
tiledlayout(1, 2);
nexttile;
plot_average_traces(Tree_NG5, Traces_NG5, final_node_labels_EPI1_EPI2_NG5, 'Nanog_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'location', 'northwest');
title('NG-5');

nexttile;
plot_average_traces(Tree_NG5, Traces_NG5, final_node_labels_EPI1_EPI2_NG5, 'Gata6_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'location', 'northwest');
title('NG-5');

%% Panel S9D (NG-6)
final_node_labels_NG6 = run_kmeans(Tree_NG6, Traces_NG6, 1.2, 3);

[~, final_EPI1_ind] = ismember(Tree_NG6.final_EPI1_names, Traces_NG6.final_node_names);
final_node_labels_EPI1_EPI2_NG6 = final_node_labels_NG6;
final_node_labels_EPI1_EPI2_NG6(final_EPI1_ind,5) = 1;
final_node_labels_EPI1_EPI2_NG6(final_EPI1_ind,2) = 0;

figure;
tiledlayout(1, 2);
nexttile;
plot_average_traces(Tree_NG6, Traces_NG6, final_node_labels_EPI1_EPI2_NG6, 'Nanog_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'location', 'northwest');
title('NG-6');

nexttile;
plot_average_traces(Tree_NG6, Traces_NG6, final_node_labels_EPI1_EPI2_NG6, 'Gata6_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'location', 'northwest');
title('NG-6');

%% Panel S9E (NG-7)
final_node_labels_NG7 = run_kmeans(Tree_NG7, Traces_NG7, 1.2, 3);

[~, final_EPI1_ind] = ismember(Tree_NG7.final_EPI1_names, Traces_NG7.final_node_names);
final_node_labels_EPI1_EPI2_NG7 = final_node_labels_NG7;
final_node_labels_EPI1_EPI2_NG7(final_EPI1_ind,5) = 1;
final_node_labels_EPI1_EPI2_NG7(final_EPI1_ind,2) = 0;

figure;
tiledlayout(1, 2);
nexttile;
plot_average_traces(Tree_NG7, Traces_NG7, final_node_labels_EPI1_EPI2_NG7, 'Nanog_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
legend('show', 'location', 'northwest');
title('NG-7');

nexttile;
plot_average_traces(Tree_NG7, Traces_NG7, final_node_labels_EPI1_EPI2_NG7, 'Gata6_norm', ...
    clr, names, [2, 3, 4], true);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
legend('show', 'location', 'northwest');
title('NG-7');