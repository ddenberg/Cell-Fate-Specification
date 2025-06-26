clc;
clear;

addpath('./data');
addpath('./utils');
addpath('./plots'); 

% Permutations were generated for each NG- Embryo: 'NG-1 short', 
% 'NG-2 short', 'NG-3', 'NG-4', 'NG-5', 'NG-6', 'NG-7'
[Tree, Traces] = load_dataset('NG-1 short');

t_star = 1.2;
K = 3;
final_node_labels = run_kmeans(Tree, Traces, t_star, K);

num_permutations = 100; % 10000 is actual value used in paper
output = run_permutation_test(Tree, Traces.final_node_names, ...
    final_node_labels, num_permutations, false);

% output can be saved as a .mat file:
% save('/your/path/here/output.mat', 'output');