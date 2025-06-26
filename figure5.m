clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

%% Panel 5B
[Tree_NG1, Traces_NG1] = load_dataset('NG-1 short');

figure;
plot_overlaid_ICM_traces(Tree_NG1, Traces_NG1, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('WT (NG-1)');

figure;
plot_overlaid_ICM_traces(Tree_NG1, Traces_NG1, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('WT (NG-1)');

%% Panel 5C
[Tree_MEKi1, Traces_MEKi1] = load_dataset('MEKi-1');

figure;
plot_overlaid_ICM_traces(Tree_MEKi1, Traces_MEKi1, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('MEKi (MEKi-1)');

figure;
plot_overlaid_ICM_traces(Tree_MEKi1, Traces_MEKi1, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('MEKi (MEKi-1)');

%% Panel 5D
[Tree_NG1, Traces_NG1] = load_dataset('NG-1 short');
[Tree_NG2, Traces_NG2] = load_dataset('NG-2 short');
[Tree_NG5, Traces_NG5] = load_dataset('NG-5');
[Tree_NG7, Traces_NG7] = load_dataset('NG-7');

[Tree_MEKi1, Traces_MEKi1] = load_dataset('MEKi-1');
[Tree_MEKi2, Traces_MEKi2] = load_dataset('MEKi-2');
[Tree_MEKi3, Traces_MEKi3] = load_dataset('MEKi-3');

final_node_labels_ICM_TE_NG1 = onehotencode(categorical(Traces_NG1.ICM_flag), 2);
final_node_labels_ICM_TE_NG2 = onehotencode(categorical(Traces_NG2.ICM_flag), 2);
final_node_labels_ICM_TE_NG5 = onehotencode(categorical(Traces_NG5.ICM_flag), 2);
final_node_labels_ICM_TE_NG7 = onehotencode(categorical(Traces_NG7.ICM_flag), 2);

final_node_labels_ICM_TE_MEKi1 = onehotencode(categorical(Traces_MEKi1.ICM_flag), 2);
final_node_labels_ICM_TE_MEKi2 = onehotencode(categorical(Traces_MEKi2.ICM_flag), 2);
final_node_labels_ICM_TE_MEKi3 = onehotencode(categorical(Traces_MEKi3.ICM_flag), 2);

[slopes_32_64_NG1, trace_labels_32_64_NG1] = compute_32_64_trace_slopes(Tree_NG1, ...
    Traces_NG1.final_node_names, final_node_labels_ICM_TE_NG1, 1);
[slopes_32_64_NG2, trace_labels_32_64_NG2] = compute_32_64_trace_slopes(Tree_NG2, ...
    Traces_NG2.final_node_names, final_node_labels_ICM_TE_NG2, 1);
[slopes_32_64_NG5, trace_labels_32_64_NG5] = compute_32_64_trace_slopes(Tree_NG5, ...
    Traces_NG5.final_node_names, final_node_labels_ICM_TE_NG5, 1);
[slopes_32_64_NG7, trace_labels_32_64_NG7] = compute_32_64_trace_slopes(Tree_NG7, ...
    Traces_NG7.final_node_names, final_node_labels_ICM_TE_NG7, 1);

[slopes_32_64_MEKi1, trace_labels_32_64_MEKi1] = compute_32_64_trace_slopes(Tree_MEKi1, ...
    Traces_MEKi1.final_node_names, final_node_labels_ICM_TE_MEKi1, 1);
[slopes_32_64_MEKi2, trace_labels_32_64_MEKi2] = compute_32_64_trace_slopes(Tree_MEKi2, ...
    Traces_MEKi2.final_node_names, final_node_labels_ICM_TE_MEKi2, 1);
[slopes_32_64_MEKi3, trace_labels_32_64_MEKi3] = compute_32_64_trace_slopes(Tree_MEKi3, ...
    Traces_MEKi3.final_node_names, final_node_labels_ICM_TE_MEKi3, 1);

gata6_slopes = [slopes_32_64_NG1(trace_labels_32_64_NG1(:,1) < 1, 1, 1); ...
                slopes_32_64_NG2(trace_labels_32_64_NG2(:,1) < 1, 1, 1); ...
                slopes_32_64_NG5(trace_labels_32_64_NG5(:,1) < 1, 1, 1); ...
                slopes_32_64_NG7(trace_labels_32_64_NG7(:,1) < 1, 1, 1); ...
                slopes_32_64_MEKi1(trace_labels_32_64_MEKi1(:,1) < 1, 1, 1); ...
                slopes_32_64_MEKi2(trace_labels_32_64_MEKi2(:,1) < 1, 1, 1); ...
                slopes_32_64_MEKi3(trace_labels_32_64_MEKi3(:,1) < 1, 1, 1)];
nanog_slopes = [slopes_32_64_NG1(trace_labels_32_64_NG1(:,1) < 1, 2, 1); ...
                slopes_32_64_NG2(trace_labels_32_64_NG2(:,1) < 1, 2, 1); ...
                slopes_32_64_NG5(trace_labels_32_64_NG5(:,1) < 1, 2, 1); ...
                slopes_32_64_NG7(trace_labels_32_64_NG7(:,1) < 1, 2, 1); ...
                slopes_32_64_MEKi1(trace_labels_32_64_MEKi1(:,1) < 1, 2, 1); ...
                slopes_32_64_MEKi2(trace_labels_32_64_MEKi2(:,1) < 1, 2, 1); ...
                slopes_32_64_MEKi3(trace_labels_32_64_MEKi3(:,1) < 1, 2, 1)];
groupdata = [repelem({'WT'}, nnz(trace_labels_32_64_NG1(:,1) < 1), 1); ...
             repelem({'WT'}, nnz(trace_labels_32_64_NG2(:,1) < 1), 1); ...
             repelem({'WT'}, nnz(trace_labels_32_64_NG5(:,1) < 1), 1); ...
             repelem({'WT'}, nnz(trace_labels_32_64_NG7(:,1) < 1), 1); ...
             repelem({'MEKi'}, nnz(trace_labels_32_64_MEKi1(:,1) < 1), 1); ...
             repelem({'MEKi'}, nnz(trace_labels_32_64_MEKi2(:,1) < 1), 1); ...
             repelem({'MEKi'}, nnz(trace_labels_32_64_MEKi3(:,1) < 1), 1)];

% compute signs of slopes
sign_gata6_slopes = sign(gata6_slopes);
sign_nanog_slopes = sign(nanog_slopes);

% do two sample binomial test for both gata6 and nanog
n1 = sum(contains(string(groupdata), 'WT'));
n2 = sum(contains(string(groupdata), 'MEK'));

prop1_gata6 = sum(sign_gata6_slopes(contains(string(groupdata), 'WT')') > 0) / n1;
prop2_gata6 = sum(sign_gata6_slopes(contains(string(groupdata), 'MEK')) > 0) / n2;
prop1_nanog = sum(sign_nanog_slopes(contains(string(groupdata), 'WT')') > 0) / n1;
prop2_nanog = sum(sign_nanog_slopes(contains(string(groupdata), 'MEK')) > 0) / n2;

phat_gata6 = (n1 * prop1_gata6 + n2 * prop2_gata6) / (n1 + n2);
phat_nanog = (n1 * prop1_nanog + n2 * prop2_nanog) / (n1 + n2);

zscore_gata6 = (prop1_gata6 - prop2_gata6) / sqrt(phat_gata6 * (1 - phat_gata6) * (1 / n1 + 1 / n2));
zscore_nanog = (prop1_nanog - prop2_nanog) / sqrt(phat_nanog * (1 - phat_nanog) * (1 / n1 + 1 / n2));
p_val_gata6 = 2 * (1 - normcdf(zscore_gata6));
p_val_nanog = 2 * (1 - normcdf(zscore_nanog));

fprintf('GATA6 p-value = %e\n', p_val_gata6);
fprintf('NANOG p-value = %e\n', p_val_nanog);

figure;
b = bar([1, 2], [prop1_gata6, 1 - prop1_gata6; prop2_gata6, 1 - prop2_gata6], 'stacked', ...
    'FaceColor', 'flat', 'LineWidth', 2, 'ShowBaseLine', 'off');
b(1).CData(1,:) = [0.5, 0.5, 0.5];
b(1).CData(2,:) = [0.5, 0.5, 0.5];
b(2).CData(1,:) = [0.9, 0.9, 0.9];
b(2).CData(2,:) = [0.9, 0.9, 0.9];
xlim([0, 3]);
ylim([0, 1]);
xticklabels({'WT', 'MEKi'});
ylabel('GATA6-eGFP Slope Sign Fraction');
yticks([0, 0.2, 0.4, 0.6, 0.8, 1.0]);
box off;
set(gca, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
pbaspect([1, 1.4, 1]);

figure;
b = bar([1, 2], [prop1_nanog, 1 - prop1_nanog; prop2_nanog, 1 - prop2_nanog], 'stacked', ...
    'FaceColor', 'flat', 'LineWidth', 2, 'ShowBaseLine', 'off');
b(1).CData(1,:) = [0.5, 0.5, 0.5];
b(1).CData(2,:) = [0.5, 0.5, 0.5];
b(2).CData(1,:) = [0.9, 0.9, 0.9];
b(2).CData(2,:) = [0.9, 0.9, 0.9];
xlim([0, 3]);
ylim([0, 1]);
xticklabels({'WT', 'MEKi'});
ylabel('NANOG_mCherry Slope Sign Fraction');
yticks([0, 0.2, 0.4, 0.6, 0.8, 1.0]);
box off;
set(gca, 'LineWidth', 2);
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
pbaspect([1, 1.4, 1]);
