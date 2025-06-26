function [signal, div_flag, node_list] = traverse_tree(G, node_start, node_end, node_columns, num_frames)

data_cols = cell(length(node_columns), 1);
for ii = 1:length(node_columns)
    data_cols{ii} = G.Nodes.(node_columns{ii});
end

% get IDs of cells with degree 3 (mother cells right before division)
deg = degree(G);
degree3_ind = find(deg == 3);

% get path pairs
D = distances(G, node_start, node_end);

signal = cellfun(@(c) nan(length(node_end), num_frames, size(c, 2)), data_cols, 'UniformOutput', false);
node_list = cell(length(node_end), 1);

div_flag = false(length(node_end), num_frames);
for ii = 1:length(node_end)
    start_ind = find(~isinf(D(:,ii)));
    if ~isempty(start_ind)
        path_ID = shortestpath(G, node_start{start_ind}, node_end{ii});
        node_list{ii} = path_ID;

        path_ind = findnode(G, path_ID);
    
        for jj = 1:length(signal)
            signal{jj}(ii,:,:) = data_cols{jj}(path_ind,:);
        end
    
        % iterate through path_ID and set div_flag to true if path_ind is in degree3_ind
        % NOTE: div_flag is true on the frame before a division
        div_flag(ii,:) = ismember(path_ind, degree3_ind);
    end
end
end