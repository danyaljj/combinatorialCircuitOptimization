figure(1);
axis([0 100 0 1]);
xlabel('Generation')
ylabel('Fittness Value')
title('Accending fittness valus of digital gates in each generation.');
hold on;

% plot(best_fit_log, '--r', 'LineWidth', 2)
% plot(mean_fit_log, '--b', 'LineWidth', 2)
% % plot(worst_fit_log, '--g', 'LineWidth', 2)

plot(1-Fit(2,i), '--b', 'LineWidth', 2)
plot(1-Fit(1,i)/200, '--g', 'LineWidth', 2)
plot(1-Fit(3,i), '--r', 'LineWidth', 2)

% legend('Best Fittness','Mean Fittness','Worst Fittness','Location', 'SouthEast');
legend('Best Fittness','Mean Fittness', 'Worst Fitness','Location', 'SouthEast');


