function plot_death_times(Tree)

dead_node_names = Tree.dead_node_names(:);
dead_node_fates = Tree.dead_node_fates(:);
dead_node_labels = onehotencode(categorical(dead_node_fates, {'TE', 'ICM'}), 2);

rng(1);

dead_node_frames = split(dead_node_names, '_');
dead_node_frames = str2double(dead_node_frames(:,1));
dead_ICM_node_frames = dead_node_frames(dead_node_labels(:,1) < 1);
[~, ia] = unique(dead_ICM_node_frames);
dup_ind = setdiff(1:length(dead_ICM_node_frames), ia);

% jitter frame number so that plotted lines aren't on top of each other for
% the same death time
dead_ICM_node_frames(dup_ind) = dead_ICM_node_frames(dup_ind) + 2 * (rand(length(dup_ind), 1) - 0.5);

dead_ICM_node_times = (dead_ICM_node_frames - Tree.first_frame) * Tree.frame_to_hour;

hold on;
for ii = 1:length(dead_ICM_node_frames)
    stem(dead_ICM_node_times(ii), pi/2, 'Marker', 'none', 'LineWidth', 1, 'Color', [76, 76, 76] / 255, ...
        'LineStyle', '--', 'HandleVisibility', 'off', 'ShowBaseLine', 'off');
end

end

