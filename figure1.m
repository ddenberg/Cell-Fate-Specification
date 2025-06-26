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

[Tree, Traces] = load_dataset('NG-1 short');

%% Panel 1D
figure;
plot_text = false;
plot_fates = false;
final_node_labels_ICM_TE = onehotencode(categorical(Traces.ICM_flag), 2);
plot_tree_finallabelonly(Tree, Traces, final_node_labels_ICM_TE, plot_text, plot_fates, clr);

%% Panel 1E
figure;
plot_trace_example(Tree, Traces, '180_024');

figure;
plot_trace_example(Tree, Traces, '180_023');