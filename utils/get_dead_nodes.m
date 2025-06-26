function dead_node_names = get_dead_nodes(Tree)

node_frames = split(Tree.G_based_on_nn.Nodes.Name, '_');
node_frames = str2double(node_frames(:,1));

dead_node_filter = degree(Tree.G_based_on_nn) == 1 & ...
    node_frames ~= Tree.first_frame & node_frames ~= Tree.final_frame;

dead_node_names = Tree.G_based_on_nn.Nodes.Name(dead_node_filter);

end

