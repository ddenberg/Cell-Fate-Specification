clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 


%% Panel S3A (NG-1 short)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-1 short');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-1');

%% Panel S3B (NG-3)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-3');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-3');

%% Panel S3C (NG-4)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-4');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-4');

%% Panel S3C (NG-5)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-5');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-5');

%% Panel S3C (NG-6)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-6');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-6');

%% Panel S3C (NG-7)
clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-7');
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

figure;
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);

figure;
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
legend('show');
ylabel('Angle (rad)');
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
title('NG-7');
