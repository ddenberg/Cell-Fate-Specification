clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217; % PE
       100, 100, 100] / 255; % ICM
names = {'TE', 'EPI', 'DP', 'PE', 'ICM'};

[Tree_NG1, Traces_NG1] = load_dataset('NG-1 long');
[Tree_NG2, Traces_NG2] = load_dataset('NG-2 long');

%% Panel S5A
figure;
[~, ind] = ismember(Tree_NG1.final_ICM_names, Traces_NG1.final_node_names);
final_node_fates_NG1 = repmat({'TE'}, [length(Traces_NG1.final_node_names), 1]);
final_node_fates_NG1(ind) = replace(Tree_NG1.final_ICM_fates, {'EPI-1', 'EPI-2'}, 'EPI');
final_node_labels_NG1 = onehotencode(categorical(final_node_fates_NG1, names), 2);

dead_node_labels_NG1 = onehotencode(categorical(Tree_NG1.dead_node_fates(:), names), 2);

[early_node_labels_NG1, early_node_names_NG1] = run_kmeans_clipped(Tree_NG1, 180, ...
    [Traces_NG1.final_node_names; Tree_NG1.dead_node_names(:)], ...
    [final_node_labels_NG1; dead_node_labels_NG1], 1.2, 3);

plot_tree_finallabel_earlylabel(Tree_NG1, Traces_NG1, final_node_labels_NG1, ...
    early_node_names_NG1, early_node_labels_NG1, true, true, clr)

%% Panel S5B
figure;
tiledlayout(4, 7, 'TileSpacing', 'tight', 'Padding', 'compact', 'TileIndexing', 'columnmajor');
tight_trace_plot(Tree_NG1, Traces_NG1, 'nanog', 1);
tight_trace_plot(Tree_NG1, Traces_NG1, 'gata6', 1);

%% Panel S5C
figure;
plot_scatter_ng6(Tree_NG1, early_node_names_NG1(early_node_labels_NG1(:,1) < 1), ...
    early_node_labels_NG1(early_node_labels_NG1(:,1) < 1,:), clr);

%% Panel S5D
figure;
plot_scatter_ng6(Tree_NG1, Traces_NG1.final_node_names(Traces_NG1.ICM_flag), ...
    final_node_labels_NG1(Traces_NG1.ICM_flag,:), clr);

%% Panel S5E
figure;
[~, ind] = ismember(Tree_NG2.final_ICM_names, Traces_NG2.final_node_names);
final_node_fates_NG2 = repmat({'TE'}, [length(Traces_NG2.final_node_names), 1]);
final_node_fates_NG2(ind) = replace(Tree_NG2.final_ICM_fates, {'EPI-1', 'EPI-2'}, 'EPI');
final_node_labels_NG2 = onehotencode(categorical(final_node_fates_NG2, names), 2);

dead_node_labels_NG2 = onehotencode(categorical(Tree_NG2.dead_node_fates(:), names), 2);

[early_node_labels_NG2, early_node_names_NG2] = run_kmeans_clipped(Tree_NG2, 184, ...
    [Traces_NG2.final_node_names; Tree_NG2.dead_node_names(:)], ...
    [final_node_labels_NG2; dead_node_labels_NG2], 1.2, 3);

plot_tree_finallabel_earlylabel(Tree_NG2, Traces_NG2, final_node_labels_NG2, ...
    early_node_names_NG2, early_node_labels_NG2, true, true, clr);

%% Panel S5F
figure;
tiledlayout(4, 5, 'TileSpacing', 'tight', 'Padding', 'compact', 'TileIndexing', 'columnmajor');
tight_trace_plot(Tree_NG2, Traces_NG2, 'nanog', 1);
tight_trace_plot(Tree_NG2, Traces_NG2, 'gata6', 1);

%% Panel S5G
figure;
plot_scatter_ng6(Tree_NG2, early_node_names_NG2(early_node_labels_NG2(:,1) < 1), ...
    early_node_labels_NG2(early_node_labels_NG2(:,1) < 1,:), clr);

%% Panel S5H
figure;
plot_scatter_ng6(Tree_NG2, Traces_NG2.final_node_names(Traces_NG2.ICM_flag), ...
    final_node_labels_NG2(Traces_NG2.ICM_flag,:), clr);