function final_node_labels_random = randomize_final_labels(final_node_labels)

% Permutes final node labels, preserving ICM and TE classes

final_node_labels_random = zeros(size(final_node_labels));
final_node_labels_random(final_node_labels(:,1) == 1,1) = 1; % Preserve TE class

class_num = sum(final_node_labels, 1);
% class_ind = repelem([2; 3; 4], class_num(2:end));
class_ind = repelem((2:size(final_node_labels, 2)).', class_num(2:end));
class_ind = class_ind(randperm(length(class_ind)));
class_ind_ohe = onehotencode(categorical(class_ind), 2);

final_node_labels_random(final_node_labels(:,1) ~= 1,2:end) = class_ind_ohe;
end

