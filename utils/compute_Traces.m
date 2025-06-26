function Traces = compute_Traces(Tree, final_node_names, final_ICM_names, read_sox2)

% get the frame ID for each node in the tree
node_frames = split(Tree.G_based_on_nn.Nodes.Name, '_');
node_frames = str2double(node_frames(:,1));

if isempty(final_node_names)
    final_node_names = Tree.G_based_on_nn.Nodes.Name(node_frames == Tree.final_frame);
end
initial_node_names = Tree.G_based_on_nn.Nodes.Name(node_frames == Tree.first_frame);

if ~read_sox2
    column_names = {'Gata6_norm', 'Nanog_norm', 'Histone_norm'};
else
    column_names = {'Gata6_norm', 'Nanog_norm', 'Histone_norm', 'Sox2_norm'};
end

% traverse the tree and get the requested TFs in each lineage.
[signal, div_flag, lineage_trace] = traverse_tree(Tree.G_based_on_nn, initial_node_names, final_node_names, ...
    column_names, length(Tree.frame_range));

angletraces = atan(signal{2} ./ (signal{1} + 1e-2));

Traces.final_node_names = final_node_names;
Traces.div_flag = div_flag;
Traces.lineage_trace = lineage_trace;
Traces.ICM_flag = ismember(final_node_names, final_ICM_names);
Traces.angletraces = angletraces;
Traces.gata6traces = signal{1};
Traces.nanogtraces = signal{2};

if read_sox2
    Traces.sox2traces = signal{4};
end


end

