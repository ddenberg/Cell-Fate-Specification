function mean_std_plot(t, means, stds, clr, names)

% means: [T x N]
% stds: [T x N]
% clr: [N x 3]
% t: [T x 1]
t = t(:);

hold on;
for ii = 1:size(means, 2)
    mean_ii = means(:,ii);
    std_ii = stds(:,ii);
    mask = ~isnan(mean_ii);

    fill([t(mask); flip(t(mask))], ...
         [mean_ii(mask) - std_ii(mask); flip(mean_ii(mask) + std_ii(mask))], ...
         clr(ii,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none', 'HandleVisibility', 'off');
    
    plot(t, mean_ii, 'LineWidth', 5, 'Color', clr(ii,:), 'DisplayName', names{ii});
end

end
