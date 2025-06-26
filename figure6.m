clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

clr = [0, 0, 0; % TE
       150, 0, 80; % EPI-1
       227, 155, 0; % EPI-2
       180, 42, 201; % DP
       20, 56, 217] / 255; % PE
names = {'TE', 'EPI-1', 'EPI-2', 'DP', 'PE'};

[Tree_NG1, Traces_NG1] = load_dataset('NG-1 long');
[Tree_NG2, Traces_NG2] = load_dataset('NG-2 long');

%% Panel 6A
figure;

[~, ind] = ismember(Tree_NG1.final_ICM_names, Traces_NG1.final_node_names);
final_node_fates_NG1 = repmat({'TE'}, [length(Traces_NG1.final_node_names), 1]);
final_node_fates_NG1(ind) = Tree_NG1.final_ICM_fates;
final_node_labels_NG1 = onehotencode(categorical(final_node_fates_NG1, names), 2);

plot_average_traces(Tree_NG1, Traces_NG1, final_node_labels_NG1, 'Gata6_norm', clr, names, [3, 5], true);
ylim([0, 1]);
legend('show');
ylabel('Normalized GATA6-eGFP');
title('NG-1 long');

figure;

[~, ind] = ismember(Tree_NG2.final_ICM_names, Traces_NG2.final_node_names);
final_node_fates_NG2 = repmat({'TE'}, [length(Traces_NG2.final_node_names), 1]);
final_node_fates_NG2(ind) = Tree_NG2.final_ICM_fates;
final_node_labels_NG2 = onehotencode(categorical(final_node_fates_NG2, names), 2);

plot_average_traces(Tree_NG2, Traces_NG2, final_node_labels_NG2, 'Gata6_norm', clr, names, [3, 5], true);
ylim([0, 1]);
legend('show');
ylabel('Normalized GATA6-eGFP');
title('NG-2 long');

%% Panel 6C
figure;

[~, ind] = ismember(Tree_NG1.final_ICM_names, Traces_NG1.final_node_names);
final_node_fates_NG1 = repmat({'TE'}, [length(Traces_NG1.final_node_names), 1]);
final_node_fates_NG1(ind) = Tree_NG1.final_ICM_fates;
final_node_labels_NG1 = onehotencode(categorical(final_node_fates_NG1, names), 2);

plot_average_traces(Tree_NG1, Traces_NG1, final_node_labels_NG1, 'Nanog_norm', clr, names, [3, 5], true);
ylim([0, 1]);
legend('show');
ylabel('Normalized NANOG-mCherry');
title('NG-1 long');

figure;

[~, ind] = ismember(Tree_NG2.final_ICM_names, Traces_NG2.final_node_names);
final_node_fates_NG2 = repmat({'TE'}, [length(Traces_NG2.final_node_names), 1]);
final_node_fates_NG2(ind) = Tree_NG2.final_ICM_fates;
final_node_labels_NG2 = onehotencode(categorical(final_node_fates_NG2, names), 2);

plot_average_traces(Tree_NG2, Traces_NG2, final_node_labels_NG2, 'Nanog_norm', clr, names, [3, 5], true);
ylim([0, 1]);
legend('show');
ylabel('Normalized NANOG-mCherry');
title('NG-2 long');