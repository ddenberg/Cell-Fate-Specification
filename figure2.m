clc
clear

addpath('./data');
addpath('./utils');
addpath('./plots');

clr = [0, 0, 0; % TE
       220, 20, 20; % EPI
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI', 'DP', 'PE'};

[Tree, Traces] = load_dataset('NG-2 short');

%% Figure 2A
figure;
final_node_labels_ICM_TE = onehotencode(categorical(Traces.ICM_flag), 2);
plot_scatter_ng6(Tree, Traces.final_node_names(Traces.ICM_flag), ...
    ones(nnz(Traces.ICM_flag), 1), [0, 0, 0]);
xlim([0, 0.8]);
ylim([0, 0.6]);

%% Figure 2B
figure;
plot_overlaid_ICM_traces(Tree, Traces, 'Angle', [0, 0, 0]);
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
ylabel('Angle (rad)');

%% Figure 2C
figure;
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);
plot_average_traces(Tree, Traces, final_node_labels, 'Angle', clr, names, [2, 3, 4], true);
ylim([0, pi / 2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
legend('show');
ylabel('Angle (rad)');

%% Figure 2D
figure;
plot_trace_example(Tree, Traces, '184_352');
title('EPI Example');

figure;
plot_trace_example(Tree, Traces, '184_326');
title('DP Example');

figure;
plot_trace_example(Tree, Traces, '184_331');
title('PE Example');

%% Figure 2E

[Tree_long_NG1, Traces_long_NG1] = load_dataset('NG-1 long');
[Tree_long_NG2, Traces_long_NG2] = load_dataset('NG-2 long');

t_star = 1.2;
K = 3;

clip_frame_range_NG1 = 152:192;
[accuracy_NG1, ~, hours_post_avg_32_64_NG1] = run_kmeans_validation(Tree_long_NG1, ...
    Traces_long_NG1, clip_frame_range_NG1, t_star, K);

clip_frame_range_NG2 = 168:196;
[accuracy_NG2, ~, hours_post_avg_32_64_NG2] = run_kmeans_validation(Tree_long_NG2, ...
    Traces_long_NG2, clip_frame_range_NG2, t_star, K);

hours_post_avg_32_64_interp = linspace(5, 12, 50);
accuracy_NG1_interp = interp1(hours_post_avg_32_64_NG1, accuracy_NG1, ...
    hours_post_avg_32_64_interp, 'linear');
accuracy_NG2_interp = interp1(hours_post_avg_32_64_NG2, accuracy_NG2, ...
    hours_post_avg_32_64_interp, 'linear');
accuracy_avg_interp = (accuracy_NG1_interp + accuracy_NG2_interp) / 2;

figure;
hold on;
plot(hours_post_avg_32_64_interp, accuracy_avg_interp, 'k', 'LineWidth', 3);
axis square;
ylim([0.75, 1]);
xlim([5, 12]);
xlabel('Hours post avg 32/64 cell division');
ylabel('Accuracy');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 2);

%% Figure 2F
figure;
t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);
plot_tree_finallabelonly(Tree, Traces, final_node_labels, false, true, clr);