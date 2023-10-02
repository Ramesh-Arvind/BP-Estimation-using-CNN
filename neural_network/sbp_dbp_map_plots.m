% Calculate mean and difference between ground truth and predicted values for each BP metric
mean_bp = (signal_GT_concat + signal_pred_concat) / 2;
error_dbp = signal_GT_concat - signal_pred_concat;
error_map = (2 * signal_GT_concat + signal_pred_concat) / 3 - signal_GT_concat;
error_sbp = signal_GT_concat - (2 * signal_GT_concat + signal_pred_concat) / 3;

% Define indices for the desired data points
indices = 20:5000;

% Plot Bland-Altman plots for DBP, MAP, and SBP
figure()
plot(mean_bp(indices), error_dbp(indices), '.')
hold on
plot(mean_bp(indices), zeros(size(indices)), 'k-.')
plot(mean_bp(indices), 1.96*std(error_dbp(indices))*ones(size(indices)), 'r--')
plot(mean_bp(indices), -1.96*std(error_dbp(indices))*ones(size(indices)), 'r--')
hold off
set(gca, 'YLim', [-50 50])
ylabel('DBP prediction error (mmHg)')
title('Bland-Altman Plot for DBP')
xlabel('Mean BP (mmHg)')

figure()
plot(mean_bp(indices), error_map(indices), '.')
hold on
plot(mean_bp(indices), zeros(size(indices)), 'k-.')
plot(mean_bp(indices), 1.96*std(error_map(indices))*ones(size(indices)), 'r--')
plot(mean_bp(indices), -1.96*std(error_map(indices))*ones(size(indices)), 'r--')
hold off
set(gca, 'YLim', [-50 50])
ylabel('MAP prediction error (mmHg)')
title('Bland-Altman Plot for MAP')
xlabel('Mean BP (mmHg)')

figure()
plot(mean_bp(indices), error_sbp(indices), '.')
hold on
plot(mean_bp(indices), zeros(size(indices)), 'k-.')
plot(mean_bp(indices), 1.96*std(error_sbp(indices))*ones(size(indices)), 'r--')
plot(mean_bp(indices), -1.96*std(error_sbp(indices))*ones(size(indices)), 'r--')
hold off
set(gca, 'YLim', [-50 50])
ylabel('SBP prediction error (mmHg)')
title('Bland-Altman Plot for SBP')
xlabel('Mean BP (mmHg)')
