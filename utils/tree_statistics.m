function [means, stds] = tree_statistics(G, final_node_names, final_node_labels, columns)

[node_labels, ~] = backpropagate_labels(G, final_node_names, final_node_labels);

node_frame = split(G.Nodes.Name, '_');
node_frame = str2double(squeeze(node_frame(:,1)));

filter_nan = any(isnan(node_labels), 2);

frame_range = unique(node_frame);

means = nan(length(frame_range), size(node_labels, 2), length(columns));
stds = nan(length(frame_range), size(node_labels, 2), length(columns));

% clr = [1, 0, 0;
%        0.75, 0.07, 0.87;
%        0, 0, 1];

for ii = 1:length(columns)
    node_values = G.Nodes.(columns{ii});

    for t = 1:length(frame_range)
        node_filter_t = node_frame == frame_range(t) & ~filter_nan;
    
        vals = node_values(node_filter_t);
        weights = node_labels(node_filter_t,:);
        weights = weights ./ sum(weights, 2);

        mean_t = vals.' * weights ./ sum(weights, 1);
        var_t = sum(weights .* (vals - mean_t).^2, 1) ./ sum(weights, 1);

        % reliability weights correction
        V1 = sum(weights, 1);
        V2 = sum(weights.^2, 1);
        var_t = var_t ./ (1 - V2 ./ V1.^2);

        std_t = sqrt(var_t);

        means(t,:,ii) = mean_t;
        stds(t,:,ii) = std_t;
    end

%     subplot(1, length(columns), ii)
%     hold on;
%     for jj = 2:size(node_labels, 2)
%         fill([frame_range; flip(frame_range)], ...
%              [squeeze(means(:,jj,ii)) - squeeze(stds(:,jj,ii)); flip(squeeze(means(:,jj,ii)) + squeeze(stds(:,jj,ii)))], ...
%              clr(jj-1,:), 'FaceAlpha', 0.25, 'EdgeColor', 'none');
%         
%         plot(frame_range, squeeze(means(:,jj,ii)), 'LineWidth', 2, 'Color', clr(jj-1,:));
%     end
%     xlim([min(frame_range), max(frame_range)]);
%     ylim([0, 1]);
end



end

