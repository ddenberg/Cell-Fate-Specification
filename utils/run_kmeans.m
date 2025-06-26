function [final_node_labels, hours_post_avg_32_64] = run_kmeans(Tree, Traces, t_star, K)

% print out number of hours post avg 32/64 (using long tree)
hours_post_avg_32_64 = Tree.frame_to_hour * (Tree.final_frame - Tree.stage_frame_avg(Tree.stages == 64));
fprintf('Hours post avg 32/64 = %f\n', hours_post_avg_32_64);

begin_stage_frame = Tree.stage_frame_avg(Tree.stages == 32);
end_stage_frame = Tree.stage_frame_avg(Tree.stages == 64);
cluster_start = t_star * end_stage_frame + (1 - t_star) * begin_stage_frame;
cluster_start = round(cluster_start);

traces_filter = Tree.frame_range >= cluster_start;

X = Traces.angletraces(Traces.ICM_flag,:);
X = X(:,traces_filter);

[idx_ICM, centers_ICM] = kmeans(X, K, 'Replicates', 1000, 'Distance', 'sqeuclidean');
idx = zeros(size(Traces.angletraces, 1), 1);
idx(Traces.ICM_flag) = idx_ICM;

%% reorder
mean_centers_ICM = mean(centers_ICM(:,end-5:end), 2);
% mean_centers_ICM = mean(centers_ICM(:,end-10:end), 2);
[~, order] = sort(mean_centers_ICM, 'descend');
idx_old = idx;
centers_ICM_old = centers_ICM;
for jj = 1:K
    idx(idx_old == order(jj)) = jj;
    centers_ICM(jj,:) = centers_ICM_old(order(jj),:);
end

final_node_labels = onehotencode(categorical(idx), 2);

end

