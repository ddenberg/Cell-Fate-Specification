function output = run_permutation_test(Tree, final_node_names, final_node_labels, ...
    num_perms, debug_plot_cutpoints)

output.cutpoints = [16, 32, 64];
cut_node_names_div = Tree.div_node_names;
cut_node_stages_div = Tree.div_node_stage / 2; % 16 / 2 = 8 Cell stage, 32 / 2 = 16 cell stage, etc...

% add additional cut nodes at the final frame of tree
cut_node_names_end = final_node_names;
cut_node_stages_end = nan(length(cut_node_names_end), 1);
dist = distances(Tree.G_based_on_nn, cut_node_names_end, Tree.div_node_names);
for ii = 1:length(cut_node_names_end)
    if ~all(isinf(dist(ii,:)))
        [~, ind] = min(dist(ii,:));

        cut_node_stages_end(ii) = Tree.div_node_stage(ind);
    end
end

cut_node_names = [cut_node_names_div; cut_node_names_end];
cut_node_stages = [cut_node_stages_div; cut_node_stages_end];

% filter out cut nodes if they in the future do not divide into 64 or
% previously divided into 64
[~, ~, G_directed_reverse, G_directed_forward] = backpropagate_labels(Tree.G_based_on_nn, ...
    final_node_names, final_node_labels);
forward_dist_div64 = distances(G_directed_forward, cut_node_names, ...
    Tree.div_node_names(Tree.div_node_stage == 64));
reverse_dist_div64 = distances(G_directed_reverse, cut_node_names, ...
    Tree.div_node_names(Tree.div_node_stage == 64));
dist_div64 = min(forward_dist_div64, reverse_dist_div64);
exclude_cut_nodes = all(isinf(dist_div64), 2);
cut_node_names = cut_node_names(~exclude_cut_nodes);
cut_node_stages = cut_node_stages(~exclude_cut_nodes);
cut_node_inds = findnode(Tree.G_based_on_nn, cut_node_names);

if debug_plot_cutpoints
    figure;
    h = plot(Tree.G_based_on_nn, 'Layout', 'layered');
    hold on;
    scatter(h.XData(Tree.div_node_ind(Tree.div_node_stage == 16)), ...
            h.YData(Tree.div_node_ind(Tree.div_node_stage == 16)), 'filled');
    scatter(h.XData(Tree.div_node_ind(Tree.div_node_stage == 32)), ...
            h.YData(Tree.div_node_ind(Tree.div_node_stage == 32)), 'filled');
    scatter(h.XData(Tree.div_node_ind(Tree.div_node_stage == 64)), ...
            h.YData(Tree.div_node_ind(Tree.div_node_stage == 64)), 'filled');
    scatter(h.XData(Tree.div_node_ind(Tree.div_node_stage == 128)), ...
            h.YData(Tree.div_node_ind(Tree.div_node_stage == 128)), 'filled');
    scatter(h.XData(Tree.div_node_ind(Tree.div_node_stage == 256)), ...
            h.YData(Tree.div_node_ind(Tree.div_node_stage == 256)), 'filled');
    
    scatter(h.XData(cut_node_inds(cut_node_stages == 16)), ...
            h.YData(cut_node_inds(cut_node_stages == 16)), 100, 'r');
    scatter(h.XData(cut_node_inds(cut_node_stages == 32)), ...
            h.YData(cut_node_inds(cut_node_stages == 32)), 100, 'g');
    scatter(h.XData(cut_node_inds(cut_node_stages == 64)), ...
            h.YData(cut_node_inds(cut_node_stages == 64)), 100, 'b');
    drawnow;
end

output.thresholds = [0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];

% Get dead node_names
dead_node_names = get_dead_nodes(Tree);
backprop_node_names = [final_node_names; dead_node_names];
backprop_node_labels = zeros(length(backprop_node_names), size(final_node_labels, 2) + 1);
backprop_node_labels(1:length(final_node_names),1:end-1) = final_node_labels;
backprop_node_labels(length(final_node_names)+1:end,end) = 1;

% empirical statistic
node_labels = backpropagate_labels(Tree.G_based_on_nn, ...
    backprop_node_names, backprop_node_labels);

output.max_fraction_cutpoint = zeros(length(output.cutpoints), size(backprop_node_labels, 2));
output.num_over_threshold_cutpoint = zeros(length(output.cutpoints), ...
    length(output.thresholds), size(backprop_node_labels, 2));
output.num_ICM_cutpoint = zeros(length(output.cutpoints), 1);
for ii = 1:length(output.cutpoints)
    node_labels_cutpoint = node_labels(cut_node_inds(cut_node_stages == output.cutpoints(ii)),:);
    num_ICM_cutpoint = sum(sum(node_labels_cutpoint(:,2:end-1), 2) > 0);

    output.num_ICM_cutpoint(ii) = num_ICM_cutpoint;

    output.max_fraction_cutpoint(ii,:) = max(node_labels_cutpoint, [], 1);
    for jj = 1:length(output.thresholds)
        output.num_over_threshold_cutpoint(ii,jj,:) = ...
            sum(fp_ge(node_labels_cutpoint, output.thresholds(jj), 1e-6), 1);
    end
end

% permutations

% outputs
output.max_fraction_cutpoint_perms = zeros(num_perms, length(output.cutpoints), size(backprop_node_labels, 2));
output.num_over_threshold_cutpoint_perms = zeros(num_perms, length(output.cutpoints), ...
    length(output.thresholds), size(backprop_node_labels, 2));
output.num_ICM_cutpoint_perms = zeros(num_perms, length(output.cutpoints));

for ii = 1:num_perms
    final_node_labels_random = randomize_final_labels(final_node_labels);
    backprop_node_labels_random = backprop_node_labels;
    backprop_node_labels_random(1:length(final_node_names),1:end-1) = final_node_labels_random;

    node_labels = backpropagate_labels(Tree.G_based_on_nn, ...
        backprop_node_names, backprop_node_labels_random);

    for jj = 1:length(output.cutpoints)
        node_labels_cutpoint = node_labels(cut_node_inds(cut_node_stages == output.cutpoints(jj)),:);
        num_ICM_cutpoint = sum(sum(node_labels_cutpoint(:,2:end-1), 2) > 0);

        output.num_ICM_cutpoint_perms(ii,jj) = num_ICM_cutpoint;

        output.max_fraction_cutpoint_perms(ii,jj,:) = max(node_labels_cutpoint, [], 1);
        for kk = 1:length(output.thresholds)
            output.num_over_threshold_cutpoint_perms(ii,jj,kk,:) = ...
                sum(fp_ge(node_labels_cutpoint, output.thresholds(kk), 1e-6), 1);
        end
    end

    fprintf('%d/%d\n', ii, num_perms);
end

end

function TF = fp_ge(X, Y, tol)
TF = abs(X - Y) < tol | X > Y;
end

