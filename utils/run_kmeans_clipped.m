function [clip_node_labels, clip_node_names, hours_post_avg_32_64] = run_kmeans_clipped(Tree, ...
    clip_final_frame, end_lineage_names, end_lineage_labels, t_star, K)

node_labels_backprop = backpropagate_labels(Tree.G_based_on_nn, ...
    end_lineage_names, end_lineage_labels);

node_frames = split(Tree.G_based_on_nn.Nodes.Name, '_');
node_frames = str2double(node_frames(:,1));

if isempty(clip_final_frame)
    clip_final_frame = Tree.final_frame;
end

% print out number of hours post avg 32/64 (using long tree)
hours_post_avg_32_64 = Tree.frame_to_hour * (clip_final_frame - Tree.stage_frame_avg(Tree.stages == 64));
fprintf('Hours post avg 32/64 = %f\n', hours_post_avg_32_64);

clip_node_names = Tree.G_based_on_nn.Nodes.Name(node_frames == clip_final_frame);
clip_ICM_names = Tree.G_based_on_nn.Nodes.Name(node_frames == clip_final_frame & ...
    node_labels_backprop(:,1) < 1);

remove_node_inds = find(node_frames < Tree.first_frame | node_frames > clip_final_frame);
G_clip = rmnode(Tree.G_based_on_nn, remove_node_inds);
Tree_clip = Tree;
Tree_clip.G_based_on_nn = G_clip;
Tree_clip.final_frame = clip_final_frame;
Tree_clip.frame_range = Tree.first_frame:clip_final_frame;
% remove nodes in Tree_clip.div_node_names that are no longer in the tree
TF = ismember(Tree_clip.div_node_names, Tree_clip.G_based_on_nn.Nodes.Name);
Tree_clip.div_node_names = Tree.div_node_names(TF);
Tree_clip.div_node_stage = Tree.div_node_stage(TF);
Tree_clip.div_node_frame = Tree.div_node_frame(TF);
Tree_clip.div_node_stage_ind = Tree.div_node_stage_ind(TF);
Tree_clip.div_node_time = Tree.div_node_time(TF);
Tree_clip.div_node_ind = findnode(Tree_clip.G_based_on_nn, Tree_clip.div_node_names);
[Tree_clip.stages, ~, Tree_clip.div_node_stage_ind] = unique(Tree_clip.div_node_stage);
Tree_clip.stage_frame_avg = accumarray(Tree_clip.div_node_stage_ind, Tree_clip.div_node_frame, ...
    size(Tree_clip.stages), @mean);
Tree_clip.stage_time_avg = (Tree_clip.stage_frame_avg - min(Tree_clip.frame_range)) * Tree.frame_to_hour;

% renormalize Gata6 and Nanog
Tree_clip.G_based_on_nn.Nodes.Gata6_norm = rescale(Tree_clip.G_based_on_nn.Nodes.Gata6_interp, 0, 1);
Tree_clip.G_based_on_nn.Nodes.Nanog_norm = rescale(Tree_clip.G_based_on_nn.Nodes.Nanog_interp, 0, 1);

Traces_clip = compute_Traces(Tree_clip, clip_node_names, clip_ICM_names, false);

begin_stage_frame = Tree.stage_frame_avg(Tree.stages == 32);
end_stage_frame = Tree.stage_frame_avg(Tree.stages == 64);
cluster_start = t_star * end_stage_frame + (1 - t_star) * begin_stage_frame;
cluster_start = round(cluster_start);

traces_filter = Tree_clip.frame_range >= cluster_start;

X = Traces_clip.angletraces(Traces_clip.ICM_flag,:);
X = X(:,traces_filter);

[idx_ICM, centers_ICM] = kmeans(X, K, 'Replicates', 1000, 'Distance', 'sqeuclidean');
idx = zeros(size(Traces_clip.angletraces, 1), 1);
idx(Traces_clip.ICM_flag) = idx_ICM;

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

clip_node_labels = onehotencode(categorical(idx), 2);

end

