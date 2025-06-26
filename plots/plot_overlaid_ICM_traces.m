function plot_overlaid_ICM_traces(Tree, Traces, column_name, clr)

node_frame = Tree.G_based_on_nn.Nodes.Name;
node_frame = split(node_frame, '_');
node_frame = str2double(node_frame(:,1));

node_start = Tree.G_based_on_nn.Nodes.Name(node_frame == Tree.first_frame);
node_end = Tree.G_based_on_nn.Nodes.Name(node_frame == Tree.final_frame);
signal = traverse_tree(Tree.G_based_on_nn, node_start, node_end, {column_name}, length(Tree.frame_range));

hold on;
plot(Tree.time_range, signal{1}(Traces.ICM_flag,:), 'Color', clr, ...
    'LineWidth', 2);

xlim([min(Tree.time_range), max(Tree.time_range)]);
% ylim([0, 1]);

xlabel('Time (hr)');

set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis square;

box off;
set(gca, 'LineWidth', 2);

hold on;

plot_ICM_division_ranges(Tree, Traces);

end

