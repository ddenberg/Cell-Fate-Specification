clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

[Tree_NG2, Traces_NG2] = load_dataset('NG-2 short');
[Tree_NG5, Traces_NG5] = load_dataset('NG-5');
[Tree_NG7, Traces_NG7] = load_dataset('NG-7');

[Tree_MEKi2, Traces_MEKi2] = load_dataset('MEKi-2');
[Tree_MEKi3, Traces_MEKi3] = load_dataset('MEKi-3');

%% Panel S8A (NG-2)
figure;
tiledlayout(1, 2);
nexttile;
plot_overlaid_ICM_traces(Tree_NG2, Traces_NG2, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('WT (NG-2)');

nexttile
plot_overlaid_ICM_traces(Tree_NG2, Traces_NG2, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('WT (NG-2)');

%% Panel S8B (NG-5)
figure;
tiledlayout(1, 2);
nexttile;
plot_overlaid_ICM_traces(Tree_NG5, Traces_NG5, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('WT (NG-5)');

nexttile
plot_overlaid_ICM_traces(Tree_NG5, Traces_NG5, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('WT (NG-5)');

%% Panel S8C (NG-7)
figure;
tiledlayout(1, 2);
nexttile;
plot_overlaid_ICM_traces(Tree_NG7, Traces_NG7, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('WT (NG-7)');

nexttile
plot_overlaid_ICM_traces(Tree_NG7, Traces_NG7, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('WT (NG-7)');

%% Panel S8D (MEKi-2)
figure;
tiledlayout(1, 2);
nexttile;
plot_overlaid_ICM_traces(Tree_MEKi2, Traces_MEKi2, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('MEKi (MEKi-2)');

nexttile
plot_overlaid_ICM_traces(Tree_MEKi2, Traces_MEKi2, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('MEKi (MEKi-2)');

%% Panel S8E (MEKi-3)
figure;
tiledlayout(1, 2);
nexttile;
plot_overlaid_ICM_traces(Tree_MEKi3, Traces_MEKi3, 'Nanog_norm', [222, 88, 251] / 255);
ylim([0, 1]);
ylabel('Normalized NANOG-mCherry');
title('MEKi (MEKi-3)');

nexttile
plot_overlaid_ICM_traces(Tree_MEKi3, Traces_MEKi3, 'Gata6_norm', [102, 227, 232] / 255);
ylim([0, 1]);
ylabel('Normalized GATA6-eGFP');
title('MEKi (MEKi-3)');