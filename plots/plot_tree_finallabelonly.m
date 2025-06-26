function plot_tree_finallabelonly(Tree, Traces, final_node_labels, plot_text, plot_fates, group_clr)

node_list = (1:numnodes(Tree.G_based_on_nn)).';
[node_labels, edge_labels, ~] = backpropagate_labels(Tree.G_based_on_nn, Traces.final_node_names, ...
    final_node_labels);

edge_color = 0.6 * ones(numedges(Tree.G_based_on_nn), 3);
edge_color(edge_labels(:,1) < 1,:) = 0;

edge_width = ones(numedges(Tree.G_based_on_nn), 1);
edge_width(edge_labels(:,1) == 1) = 1.3;
edge_width(edge_labels(:,1) < 1) = 3;

hold on;
h = plot(Tree.G_based_on_nn, 'layout', 'layered', 'Direction', 'right', ...
    'Marker', 'none', 'EdgeColor', edge_color, 'LineWidth', edge_width, 'EdgeAlpha', 1);
axis off;
if plot_text
    set(gca, 'Position', [-0.04, 0, 1, 1]);
else
    set(gca, 'Position', [0, 0, 1, 1]);
end

% sz = 60;
sz = 160;
% sz = 200;
if plot_fates
    final_node_index = findnode(Tree.G_based_on_nn, Traces.final_node_names);
    for ii = 2:size(node_labels, 2)
        final_filter_ii = node_labels(:,ii) == 1 & ismember(node_list, final_node_index);

        scatter(h.XData(final_filter_ii), h.YData(final_filter_ii), 'filled', 'SizeData', sz, ...
            'MarkerFaceColor', group_clr(ii,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
    end
end

margin_x = 10;
margin_y = 5;
xlim([min(h.XData) - margin_x, max(h.XData) + margin_x]); 
ylim([min(h.YData) - margin_y, max(h.YData) + margin_y]);

text_offset = 2;

final_ICM_filter = final_node_labels(:,1) == 0;
final_ICM_names = Traces.final_node_names(final_ICM_filter);

final_ind = findnode(Tree.G_based_on_nn, Traces.final_node_names);
final_ICM_ind = findnode(Tree.G_based_on_nn, final_ICM_names);
final_TE_ind = setdiff(final_ind, final_ICM_ind);
final_TE_names = setdiff(Traces.final_node_names, final_ICM_names);
if plot_text
    h_icm = text(h.XData(final_ICM_ind) + text_offset, h.YData(final_ICM_ind), final_ICM_names, ...
        'Interpreter', 'none', 'FontSize', 8, 'FontWeight', 'bold');
    h_te = text(h.XData(final_TE_ind) + text_offset, h.YData(final_TE_ind), final_TE_names, ...
        'Interpreter', 'none', 'FontSize', 8);
end
% set(h_icm, 'Rotation', -90);
% set(h_te, 'Rotation', -90);

end

