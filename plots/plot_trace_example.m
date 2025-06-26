function plot_trace_example(Tree, Traces, cell_name)

% get index of cell
ind = find(strcmp(Traces.final_node_names, cell_name));

hold on;
stem(Tree.time_range, Traces.div_flag(ind,:), '--k', 'Marker', 'none', 'LineWidth', 2, ...
    'HandleVisibility', 'off');
plot(Tree.time_range, Traces.nanogtraces(ind,:), '-', 'LineWidth', 4, 'Color', [222, 88, 251] / 255, ...
    'DisplayName', 'NANOG-mCherry');
plot(Tree.time_range, Traces.gata6traces(ind,:), '-', 'LineWidth', 4, 'Color', [102, 227, 232] / 255, ...
    'DisplayName', 'GATA6-eGFP');

legend('show', 'Location', 'northwest', 'EdgeColor', 'w');

xlim([min(Tree.time_range), max(Tree.time_range)]);
ylim([0, 1]);

set(gca, 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'LineWidth', 2);

xlabel('Time (hr)');
ylabel('Normalzied TF Intensity');

axis square;
% pbaspect([1.4, 1, 1]);

end

