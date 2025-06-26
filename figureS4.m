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

[Tree_NG1, Traces_NG1] = load_dataset('NG-1 long');
[Tree_NG2, Traces_NG2] = load_dataset('NG-2 long');

%% Figure S4A
% metric used to check for the presence of double negative nuclei (low nanog and
% low gata6)
dist_to_origin_NG1 = sqrt(Traces_NG1.nanogtraces.^2 + Traces_NG1.gata6traces.^2);
dist_to_origin_NG2 = sqrt(Traces_NG2.nanogtraces.^2 + Traces_NG2.gata6traces.^2);

figure;
hold on;
plot_ICM_division_ranges(Tree_NG1, Traces_NG1);
plot(Tree_NG1.time_range, dist_to_origin_NG1(Traces_NG1.ICM_flag,:), 'LineWidth', 2);
ylabel('Distance to Origin');
xlabel('Time (hr)');
axis square;
ylim([0, 1.2]);
xlim([min(Tree_NG1.time_range), max(Tree_NG1.time_range)]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 2);
title('NG-1');

figure;
hold on;
plot_ICM_division_ranges(Tree_NG2, Traces_NG2);
plot(Tree_NG2.time_range, dist_to_origin_NG2(Traces_NG2.ICM_flag,:), 'LineWidth', 2);
ylabel('Distance to Origin');
xlabel('Time (hr)');
axis square;
ylim([0, 1.2]);
xlim([min(Tree_NG2.time_range), max(Tree_NG2.time_range)]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 2);
title('NG-2');

%% Figure S4B
figure;
hold on;
[~, ind] = ismember(Tree_NG1.final_ICM_names, Traces_NG1.final_node_names);
final_node_fates_NG1 = repmat({'TE'}, [length(Traces_NG1.final_node_names), 1]);
final_node_fates_NG1(ind) = replace(Tree_NG1.final_ICM_fates, {'EPI-1', 'EPI-2'}, 'EPI');
final_node_labels_NG1 = onehotencode(categorical(final_node_fates_NG1, names), 2);

plot_average_traces(Tree_NG1, Traces_NG1, final_node_labels_NG1, 'Angle', clr, names, [2, 3, 4], false);
plot_death_times(Tree_NG1);
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
ylabel('Angle (rad)');
legend('show', 'Location', 'northwest');
title('NG-1')

figure;
hold on;
[~, ind] = ismember(Tree_NG2.final_ICM_names, Traces_NG2.final_node_names);
final_node_fates_NG2 = repmat({'TE'}, [length(Traces_NG2.final_node_names), 1]);
final_node_fates_NG2(ind) = replace(Tree_NG2.final_ICM_fates, {'EPI-1', 'EPI-2'}, 'EPI');
final_node_labels_NG2 = onehotencode(categorical(final_node_fates_NG2, names), 2);

plot_average_traces(Tree_NG2, Traces_NG2, final_node_labels_NG2, 'Angle', clr, names, [2, 3, 4], false);
plot_death_times(Tree_NG2);
ylim([0, pi/2]);
yticks([0, pi/4, pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
ylabel('Angle (rad)');
legend('show', 'Location', 'northwest');
title('NG-2')

%% Figure S4C
clip_frame_range_NG1 = 152:192;
[accuracy_NG1_ts1p2, frac_DP_NG1_ts1p2, hours_post_avg_32_64_NG1_ts1p2] = run_kmeans_validation(Tree_NG1, ...
    Traces_NG1, clip_frame_range_NG1, 1.2, 3);
[accuracy_NG1_ts1p0, frac_DP_NG1_ts1p0, hours_post_avg_32_64_NG1_ts1p0] = run_kmeans_validation(Tree_NG1, ...
    Traces_NG1, clip_frame_range_NG1, 1.0, 3);

clip_frame_range_NG2 = 168:196;
[accuracy_NG2_ts1p2, frac_DP_NG2_ts1p2, hours_post_avg_32_64_NG2_ts1p2] = run_kmeans_validation(Tree_NG2, ...
    Traces_NG2, clip_frame_range_NG2, 1.2, 3);
[accuracy_NG2_ts1p0, frac_DP_NG2_ts1p0, hours_post_avg_32_64_NG2_ts1p0] = run_kmeans_validation(Tree_NG2, ...
    Traces_NG2, clip_frame_range_NG2, 1.0, 3);


% NG-1 Long
figure;
tiledlayout(2, 1, 'TileSpacing', 'tight', 'Padding', 'tight');
nexttile;
hold on;
plot(hours_post_avg_32_64_NG1_ts1p0, accuracy_NG1_ts1p0, ':k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.0');
plot(hours_post_avg_32_64_NG1_ts1p2, accuracy_NG1_ts1p2, 'k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.2');
axis square;
ylim([0, 1]);
xlim([5, 12]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'LineWidth', 2);
xticklabels([]);
ylabel('Accuracy');
title('NG-1 long');
legend('show', 'Location', 'southeast');

nexttile;
hold on;
plot(hours_post_avg_32_64_NG1_ts1p0, frac_DP_NG1_ts1p0, ':k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.0');
plot(hours_post_avg_32_64_NG1_ts1p2, frac_DP_NG1_ts1p2, 'k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.2');
axis square;
ylim([0, 1]);
xlim([5, 12]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'LineWidth', 2);
xlabel('Time post average 32/64 (hr)');
ylabel('Double Positive Fraction');
legend('show', 'Location', 'southeast');

% NG-2 Long
figure;
tiledlayout(2, 1, 'TileSpacing', 'tight', 'Padding', 'tight');
nexttile;
hold on;
plot(hours_post_avg_32_64_NG2_ts1p0, accuracy_NG2_ts1p0, ':k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.0');
plot(hours_post_avg_32_64_NG2_ts1p2, accuracy_NG2_ts1p2, 'k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.2');
axis square;
ylim([0, 1]);
xlim([5, 12]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'LineWidth', 2);
xticklabels([]);
ylabel('Accuracy');
title('NG-2 long');
legend('show', 'Location', 'southeast');

nexttile;
hold on;
plot(hours_post_avg_32_64_NG2_ts1p0, frac_DP_NG2_ts1p0, ':k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.0');
plot(hours_post_avg_32_64_NG2_ts1p2, frac_DP_NG2_ts1p2, 'k', 'LineWidth', 3, ...
    'DisplayName', 't* = 1.2');
axis square;
ylim([0, 1]);
xlim([5, 12]);
set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'LineWidth', 2);
xlabel('Time post average 32/64 (hr)');
ylabel('Double Positive Fraction');
legend('show', 'Location', 'southeast');

