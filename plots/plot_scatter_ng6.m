function plot_scatter_ng6(Tree, node_names, node_labels, clr)

clr_idx = arrayfun(@(ii) find(node_labels(ii,:)), (1:size(node_labels, 1)).', 'UniformOutput', true);

node_idx = findnode(Tree.G_based_on_nn, node_names);
gata6_val = Tree.G_based_on_nn.Nodes.Gata6_norm(node_idx);
nanog_val = Tree.G_based_on_nn.Nodes.Nanog_norm(node_idx);

hold on;
sz = 140;
scatter(gata6_val, nanog_val, sz, clr(clr_idx,:), 'filled');

xlim([0, 1]);
ylim([0, 1]);

set(gca, 'LineWidth', 2);

axis square;

xlabel('Normalized GATA6-eGFP');
ylabel('Normalized NANOG-mCherry');
set(gca, 'FontSize', 16, 'FontWeight', 'bold');

end

