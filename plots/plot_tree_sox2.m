function plot_tree_sox2(Tree, Traces, final_node_labels, plot_text)

node_list = (1:numnodes(Tree.G_based_on_nn)).';
[node_labels, edge_labels, ~] = backpropagate_labels(Tree.G_based_on_nn, ...
    Traces.final_node_names, final_node_labels);

edge_node_ind = [findnode(Tree.G_based_on_nn, Tree.G_based_on_nn.Edges.EndNodes(:,1)), ...
                 findnode(Tree.G_based_on_nn, Tree.G_based_on_nn.Edges.EndNodes(:,2))];
edge_cdata = mean(Tree.G_based_on_nn.Nodes.Sox2_norm(edge_node_ind), 2);

group_clr = [220, 20, 20; % EPI
             180, 42, 201; % DP
             20, 56, 217] / 255; % PE

edge_width = ones(numedges(Tree.G_based_on_nn), 1);
edge_width(edge_labels(:,1) == 1) = 3;
edge_width(edge_labels(:,1) < 1) = 7;

final_node_index = findnode(Tree.G_based_on_nn, Traces.final_node_names);
final_EPI_filter = node_labels(:,2) == 1 & ismember(node_list, final_node_index);
final_DP_filter = node_labels(:,3) == 1 & ismember(node_list, final_node_index);
final_PE_filter = node_labels(:,4) == 1 & ismember(node_list, final_node_index);

hold on;
h = plot(Tree.G_based_on_nn, 'layout', 'layered', 'Direction', 'right', ...
    'Marker', 'none', 'EdgeCData', edge_cdata, 'LineWidth', edge_width, 'EdgeAlpha', 1);

load('Sox2Colormap.mat', 'Sox2Colormap');
colormap(Sox2Colormap);

clim([0, 1]);

axis off;
if plot_text
    set(gca, 'Position', [-0.04, 0, 1, 1]);
else
    set(gca, 'Position', [0, 0, 1, 1]);
end

% sz = 120;
sz = 160;
scatter(h.XData(final_EPI_filter), h.YData(final_EPI_filter), 'filled', 'SizeData', sz, ...
    'MarkerFaceColor', group_clr(1,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
scatter(h.XData(final_DP_filter), h.YData(final_DP_filter), 'filled', 'SizeData', sz, ...
    'MarkerFaceColor', group_clr(2,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');
scatter(h.XData(final_PE_filter), h.YData(final_PE_filter), 'filled', 'SizeData', sz, ...
    'MarkerFaceColor', group_clr(3,:), 'MarkerEdgeColor', 'none', 'Marker', 'o');

margin_x = 10;
margin_y = 5;
xlim([min(h.XData) - margin_x, max(h.XData) + margin_x]); 
ylim([min(h.YData) - margin_y, max(h.YData) + margin_y]);

% text_offset = 1;
text_offset = 2;

final_ind = findnode(Tree.G_based_on_nn, Traces.final_node_names);
final_ICM_ind = findnode(Tree.G_based_on_nn, Tree.final_ICM_names);
final_TE_ind = setdiff(final_ind, final_ICM_ind);
final_TE_names = setdiff(Traces.final_node_names, Tree.final_ICM_names);
if plot_text
    h_icm = text(h.XData(final_ICM_ind) + text_offset, h.YData(final_ICM_ind), final_ICM_names, ...
        'Interpreter', 'none', 'FontSize', 8, 'FontWeight', 'bold');
    h_te = text(h.XData(final_TE_ind) + text_offset, h.YData(final_TE_ind), final_TE_names, ...
        'Interpreter', 'none', 'FontSize', 8);
    % set(h_icm, 'Rotation', -90);
    % set(h_te, 'Rotation', -90);
end

end

