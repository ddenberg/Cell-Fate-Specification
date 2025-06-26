function [node_labels, edge_labels, G_directed_reverse, G_directed_forward, node_counts] = ...
    backpropagate_labels(G, list_node_names, list_node_labels)

%% Make digraph
edge_frame = split(G.Edges.EndNodes, '_');
edge_frame = str2double(squeeze(edge_frame(:,:,1)));
flip_edges = edge_frame(:,2) < edge_frame(:,1);
edges_directed = G.Edges.EndNodes;
edges_directed(flip_edges,:) = edges_directed(flip_edges,[2,1]);

edge_table_forward = table([edges_directed(:,1), edges_directed(:,2)], 'VariableNames', {'EndNodes'});
edge_table_reverse = table([edges_directed(:,2), edges_directed(:,1)], 'VariableNames', {'EndNodes'});
node_table = table(G.Nodes.Name, 'VariableNames', {'Name'});
G_directed_forward = digraph(edge_table_forward, node_table);
G_directed_reverse = digraph(edge_table_reverse, node_table);

node_labels_reverse = cell(numnodes(G_directed_reverse), 1);
edge_labels_reverse = cell(numedges(G_directed_reverse), 1);

for ii = 1:length(node_labels_reverse)
    node_labels_reverse{ii} = nan(1, size(list_node_labels, 2));
end

for ii = 1:length(edge_labels_reverse)
    edge_labels_reverse{ii} = nan(1, size(list_node_labels, 2));
end

for ii = 1:length(list_node_names)
    label = list_node_labels(ii,:);

    node_ids = dfsearch(G_directed_reverse, list_node_names{ii}, 'discovernode');
    [~, edge_inds] = dfsearch(G_directed_reverse, list_node_names{ii}, 'edgetonew');
    node_inds = findnode(G_directed_reverse, node_ids);

    for jj = 1:length(node_inds)
        node_labels_reverse{node_inds(jj)} = [node_labels_reverse{node_inds(jj)}; label];
    end

    for jj = 1:length(edge_inds)
        edge_labels_reverse{edge_inds(jj)} = [edge_labels_reverse{edge_inds(jj)}; label];
    end

end

node_counts_reverse = cellfun(@(A) sum(~isnan(A(:,1))), node_labels_reverse);
node_labels_reverse = cellfun(@(A) mean(A, 1, 'omitnan'), node_labels_reverse, 'UniformOutput', false);
edge_labels_reverse = cellfun(@(A) mean(A, 1, 'omitnan'), edge_labels_reverse, 'UniformOutput', false);

node_labels_reverse = cell2mat(node_labels_reverse);
edge_labels_reverse = cell2mat(edge_labels_reverse);

node_map = findnode(G_directed_reverse, G.Nodes.Name);
node_labels = node_labels_reverse(node_map,:);
node_counts = node_counts_reverse(node_map);

edge_map = findedge(G, G_directed_reverse.Edges.EndNodes(:,1), G_directed_reverse.Edges.EndNodes(:,2));
[~, edge_map] = ismember((1:numedges(G)).', edge_map);
edge_labels = edge_labels_reverse(edge_map,:);

end