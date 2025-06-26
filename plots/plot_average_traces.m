function plot_average_traces(Tree, Traces, final_node_labels, column_name, clr, names, ...
    plot_order, plot_ICM_division_ranges_flag)

hold on;

if plot_ICM_division_ranges_flag
    plot_ICM_division_ranges(Tree, Traces);
end

[means, stds] = tree_statistics(Tree.G_based_on_nn, Traces.final_node_names, ...
    final_node_labels, {column_name});

% plot_order = [2, 3, 4];

means = means(:,plot_order);
stds = stds(:,plot_order);
clr = clr(plot_order,:);
names = names(plot_order);

% Replace NaN and Inf stds with 0 for plotting (occurs if there is a single node 
% in a group at a particular timepoint) 
stds(isnan(stds) | isinf(stds)) = 0;
mean_std_plot(Tree.time_range, means, stds, clr, names);

xlim([min(Tree.time_range), max(Tree.time_range)]);
% ylim([0, pi/2]);
axis square;

xlabel('Time (hr)');
% ylabel('Angle (rad)');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
% set(gca, 'YTick', [0, pi / 4, pi / 2], ...
%          'YTickLabels', {'0', '', ''});

set(gca, 'LineWidth', 2);

end

