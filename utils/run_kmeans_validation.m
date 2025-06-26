function [accuracy, frac_DP, hours_post_avg_32_64] = run_kmeans_validation(Tree, Traces, clip_frame_range, t_star, K)

fate_classes = {'TE', 'EPI', 'DP', 'PE', 'ICM'};

[~, ind] = ismember(Tree.final_ICM_names, Traces.final_node_names);
final_node_fates = repmat({'TE'}, [length(Traces.final_node_names), 1]);
final_node_fates(ind) = replace(Tree.final_ICM_fates, {'EPI-1', 'EPI-2'}, 'EPI');
final_node_labels = onehotencode(categorical(final_node_fates, fate_classes), 2);

dead_node_names = Tree.dead_node_names(:);
dead_node_fates = Tree.dead_node_fates(:);
dead_node_labels = onehotencode(categorical(dead_node_fates, fate_classes), 2);

accuracy = zeros(length(clip_frame_range), 1);
frac_DP = zeros(length(clip_frame_range), 1);
hours_post_avg_32_64 = zeros(length(clip_frame_range), 1);
for ii = 1:length(clip_frame_range)
    [clip_node_labels, clip_node_names, hours_post_avg_32_64_] = run_kmeans_clipped(Tree, clip_frame_range(ii), ...
        [Traces.final_node_names; dead_node_names], ...
        [final_node_labels; dead_node_labels], t_star, K);
    
    [accuracy_, frac_DP_] = eval_pred_accuracy(Tree, Traces.final_node_names, final_node_labels, ...
        clip_node_names(clip_node_labels(:,1) ~= 1), ...
        clip_node_labels(clip_node_labels(:,1) ~= 1,:));
    accuracy(ii) = accuracy_;
    frac_DP(ii) = frac_DP_;
    hours_post_avg_32_64(ii) = hours_post_avg_32_64_;
end

end

