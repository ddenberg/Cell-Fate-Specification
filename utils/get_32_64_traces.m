function [traces, trace_label] = get_32_64_traces(G, div_node_ind, div_node_stage, ...
    final_node_names, final_node_labels, node_columns)

[node_labels, ~, ~, G_forward] = backpropagate_labels(G, final_node_names, ...
    final_node_labels);

data_cols = cell(1, length(node_columns));
for ii = 1:length(node_columns)
    data_cols{ii} = G.Nodes.(node_columns{ii});
end

node_32 = div_node_ind(div_node_stage == 32);
node_end = div_node_ind(div_node_stage == 64);

% get path pairs
D = distances(G_forward, node_32, node_end);

traces = cell(length(node_end), length(node_columns));
trace_label = zeros(length(node_end), size(node_labels, 2));
for ii = 1:length(node_end)
    start_ind = find(~isinf(D(:,ii)));
    if ~isempty(start_ind)
        path_ind = shortestpath(G, node_32(start_ind), node_end(ii));
    
        for jj = 1:length(node_columns)
            traces{ii,jj} = data_cols{jj}(path_ind,:);
        end

        trace_label(ii,:) = node_labels(node_end(ii),:);
    end
end

end

