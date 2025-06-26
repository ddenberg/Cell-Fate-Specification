function plot_ICM_division_ranges(Tree, Traces)

hold on;

final_node_labels_ICM_TE = onehotencode(categorical(Traces.ICM_flag), 2);

node_labels = backpropagate_labels(Tree.G_based_on_nn, Traces.final_node_names, final_node_labels_ICM_TE);
div_node_labels = node_labels(Tree.div_node_ind,:);
for ii = 1:length(Tree.stages)
    div_node_filter = div_node_labels(:,1) < 1 & Tree.div_node_stage == Tree.stages(ii);
    if any(div_node_filter)
        stem(mean(Tree.div_node_time(div_node_filter)), ...
            pi/2, 'Marker', 'none', 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--', ...
            'HandleVisibility', 'off', 'ShowBaseLine', 'off');
    
        fill([min(Tree.div_node_time(div_node_filter)), ...
              max(Tree.div_node_time(div_node_filter)), ...
              max(Tree.div_node_time(div_node_filter)), ...
              min(Tree.div_node_time(div_node_filter))], ...
              [0, 0, pi/2, pi/2], 0, 'FaceColor', [0, 0, 0], 'EdgeColor', 'none', 'FaceAlpha', 0.15, ...
              'HandleVisibility', 'off');
    end
end


end

