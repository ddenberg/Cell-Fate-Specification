function plot_tree_finallabel_earlylabel(Tree, Traces, final_node_labels, ...
    early_node_names, early_node_labels, plot_text, plot_fates, clr_final)

node_list = (1:numnodes(Tree.G_based_on_nn)).';
[node_labels_final_backprop, edge_labels_final_backprop] = backpropagate_labels(Tree.G_based_on_nn, ...
    Traces.final_node_names, final_node_labels);

[node_labels_early_backprop, edge_labels_early_backprop] = backpropagate_labels(Tree.G_based_on_nn, ...
    early_node_names, early_node_labels);
[~, edge_labels_early_fowardprop] = forwardpropagate_labels(Tree.G_based_on_nn, early_node_names, ...
    early_node_labels);

edge_color = 0.6 * ones(numedges(Tree.G_based_on_nn), 3);
edge_color(edge_labels_final_backprop(:,1) < 1,:) = 0;
edge_color(edge_labels_early_backprop(:,1) < 1,:) = 0;
edge_color(edge_labels_early_fowardprop(:,1) < 1,:) = 0;

group_clr_early = [220, 20, 20; % EPI
                   180, 42, 201; % DP
                   20, 56, 217] / 255; % PE

edge_width = ones(numedges(Tree.G_based_on_nn), 1);
edge_width(edge_labels_final_backprop(:,1) == 1) = 1.3; % 1.3 previous value
edge_width(edge_labels_final_backprop(:,1) < 1) = 3; % 2.5 previous value
edge_width(edge_labels_early_backprop(:,1) < 1) = 3;
edge_width(edge_labels_early_fowardprop(:,1) < 1) = 3;

final_node_index = findnode(Tree.G_based_on_nn, Traces.final_node_names);
final_filters = node_labels_final_backprop == 1 & ismember(node_list, final_node_index);

early_node_index = findnode(Tree.G_based_on_nn, early_node_names);
early_EPI_filter = node_labels_early_backprop(:,2) == 1 & ismember(node_list, early_node_index);
early_DP_filter = node_labels_early_backprop(:,3) == 1 & ismember(node_list, early_node_index);
early_PE_filter = node_labels_early_backprop(:,4) == 1 & ismember(node_list, early_node_index);

hold on;
h = plot(Tree.G_based_on_nn, 'layout', 'layered', 'Direction', 'right', ...
    'Marker', 'none', 'EdgeColor', edge_color, 'LineWidth', edge_width, 'EdgeAlpha', 1);
axis off;
if plot_text
    set(gca, 'Position', [-0.03, 0, 0.98, 1]);
else
    set(gca, 'Position', [0, 0, 1, 1]);
end

sz = 160;
if plot_fates
    for ii = 2:size(final_node_labels, 2)
        scatter(h.XData(final_filters(:,ii)), h.YData(final_filters(:,ii)), 'filled', 'SizeData', sz, ...
            'MarkerFaceColor', clr_final(ii,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
    end

    scatter(h.XData(early_EPI_filter), h.YData(early_EPI_filter), 'filled', 'SizeData', sz, ...
        'MarkerFaceColor', group_clr_early(1,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
    scatter(h.XData(early_DP_filter), h.YData(early_DP_filter), 'filled', 'SizeData', sz, ...
        'MarkerFaceColor', group_clr_early(2,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
    scatter(h.XData(early_PE_filter), h.YData(early_PE_filter), 'filled', 'SizeData', sz, ...
        'MarkerFaceColor', group_clr_early(3,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
end

margin_x = 10;
margin_y = 5;
xlim([min(h.XData) - margin_x, max(h.XData) + margin_x]); 
ylim([min(h.YData) - margin_y, max(h.YData) + margin_y]);

text_offset = 3;

final_ICM_names = Traces.final_node_names(Traces.ICM_flag);
final_ind = findnode(Tree.G_based_on_nn, Traces.final_node_names);
final_ICM_ind = findnode(Tree.G_based_on_nn, final_ICM_names);
final_TE_ind = setdiff(final_ind, final_ICM_ind);
final_TE_names = setdiff(Traces.final_node_names, final_ICM_names);
if plot_text
    h_icm = text(h.XData(final_ICM_ind) + text_offset, h.YData(final_ICM_ind), final_ICM_names, ...
        'Interpreter', 'none', 'FontSize', 9, 'FontWeight', 'bold');
    % h_te = text(h.XData(final_TE_ind) + text_offset, h.YData(final_TE_ind), final_TE_names, ...
    %     'Interpreter', 'none', 'FontSize', 9);
end

end

