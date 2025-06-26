clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

%% Panel S7B
[Tree_NGS2, Traces_NGS2] = load_dataset('NGS-2');
final_node_labels_NGS2 = run_kmeans(Tree_NGS2, Traces_NGS2, 1.2, 3);
figure;
plot_tree_sox2(Tree_NGS2, Traces_NGS2, final_node_labels_NGS2, false);

%% Panel S7C
[Tree_NGS3, Traces_NGS3] = load_dataset('NGS-3');
final_node_labels_NGS3 = run_kmeans(Tree_NGS3, Traces_NGS3, 1.2, 3);
figure;
plot_tree_sox2(Tree_NGS3, Traces_NGS3, final_node_labels_NGS3, false);

%% Panel S7D
[Tree_NGS4, Traces_NGS4] = load_dataset('NGS-4');
final_node_labels_NGS4 = run_kmeans(Tree_NGS4, Traces_NGS4, 1.2, 3);
figure;
plot_tree_sox2(Tree_NGS4, Traces_NGS4, final_node_labels_NGS4, false);

%% Panel S7E
[Tree_NGS5, Traces_NGS5] = load_dataset('NGS-5');
final_node_labels_NGS5 = run_kmeans(Tree_NGS5, Traces_NGS5, 1.2, 3);
figure;
plot_tree_sox2(Tree_NGS5, Traces_NGS5, final_node_labels_NGS5, false);