function [slope_32_64, trace_labels_32_64] = compute_32_64_trace_slopes(Tree, ...
    node_name_list, node_labels, num_splits)

[traces_32_64, trace_labels_32_64] = get_32_64_traces(Tree.G_based_on_nn, Tree.div_node_ind, ...
    Tree.div_node_stage, node_name_list, node_labels, ...
    {'Gata6_interp', 'Nanog_interp'});

exclude_traces = any(cellfun(@isempty, traces_32_64), 2);
traces_32_64 = traces_32_64(~exclude_traces,:);
trace_labels_32_64 = trace_labels_32_64(~exclude_traces,:);

slope_32_64 = zeros([size(traces_32_64), num_splits]);
for ii = 1:size(traces_32_64, 1)
    for jj = 1:size(traces_32_64, 2)
        time_32_64 = 1:length(traces_32_64{ii,jj});
        time_32_64 = (time_32_64 - 1) * Tree.frame_to_hour;

        % split into 'num_splits' parts
        trace_32_64_splits = splitVector(traces_32_64{ii,jj}, num_splits);
        time_32_64_splits = splitVector(time_32_64, num_splits);
        for kk = 1:num_splits
            time_split = time_32_64_splits{kk};
            trace_split = trace_32_64_splits{kk};
    
            fit_obj = fit(time_split(:), trace_split(:), 'poly1');
            slope_32_64(ii,jj,kk) = fit_obj.p1;
        end
    end
end

end
