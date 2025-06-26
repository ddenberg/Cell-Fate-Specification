function [accuracy, frac_DP, true_positive, dp_count, count] = eval_pred_accuracy(Tree, final_node_names, ...
    final_node_labels, early_node_names, early_node_pred)

[~, ~, G_directed_reverse, ~] = backpropagate_labels(Tree.G_based_on_nn, final_node_names, final_node_labels);

dist = distances(G_directed_reverse, final_node_names, early_node_names);

count = 0;
true_positive = 0;
dp_count = 0;
for ii = 1:length(final_node_names)
    start_ind = find(~isinf(dist(ii,:)));
    if ~isempty(start_ind)
        count = count + 1;

        early_node_pred_ind = find(early_node_pred(start_ind,:));
        final_node_label_ind = find(final_node_labels(ii,:));

        if early_node_pred_ind == final_node_label_ind
            true_positive = true_positive + 1;
        elseif early_node_pred_ind == 3
            true_positive = true_positive + 1;
        end

        if early_node_pred_ind == 3
            dp_count = dp_count + 1;
        end
    end
end

accuracy = true_positive / count;
frac_DP = dp_count / count;

end

