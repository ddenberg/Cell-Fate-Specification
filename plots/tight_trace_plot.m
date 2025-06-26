function tight_trace_plot(Tree, Traces, type, aspect)

% tiledlayout(subplot_m, subplot_n, 'TileSpacing', 'tight', 'Padding', 'compact', 'TileIndexing', 'columnmajor');

line_width = 3;
step = 1;
for jj = 1:size(Traces.angletraces, 1)
    if Traces.ICM_flag(jj)
%         subplot(subplot_m, subplot_n, step);
        nexttile(step);

        hold on;
        if strcmp(type, 'angle')
            plot(Tree.time_range, Traces.angletraces(jj,:), ...
                'Color', 'k', 'LineWidth', line_width);
            ylim([0, pi/2]);
            yticks([0, pi/4, pi/2]);

        elseif strcmp(type, 'nanog')
            plot(Tree.time_range, Traces.nanogtraces(jj,:), ...
                'Color', [222, 88, 251] / 255, 'LineWidth', line_width);
            ylim([0, 1]);
            yticks([0, 0.5, 1.0]);

        elseif strcmp(type, 'gata6')
            plot(Tree.time_range, Traces.gata6traces(jj,:), ...
                'Color', [102, 227, 232] / 255, 'LineWidth', line_width);
            ylim([0, 1]);
            yticks([0, 0.5, 1.0]);

        elseif strcmp(type, 'sox2')
            plot(Tree.time_range, Traces.sox2traces(jj,:), ...
                'Color', 'k', 'LineWidth', line_width);
            ylim([0, 1]);
            yticks([0, 0.5, 1.0]);

        else
            error('type not specified correctly.');
        end
        stem(Tree.time_range, 1e3 * Traces.div_flag(jj,:), ...
            '--k', 'Marker', 'none', 'LineWidth', 2);

        
        xlim([min(Tree.time_range), max(Tree.time_range)]);

        xticklabels([]);
        yticklabels([]);
        % xticks([0:10:100]);
        % xticks([0, 20, 40]);

        pbaspect([aspect, 1, 1]);

        set(gca, 'LineWidth', 2);

        title(Traces.final_node_names{jj}, 'Interpreter', 'none', ...
            'FontSize', 12, 'FontWeight', 'bold');
    
        step = step + 1;
    end
end

end

