% Define the empirical thresholds (in mmHg)
thresholds = [5, 10, 15];

% Initialize arrays to store the percentage of predictions below each threshold
percentage_below_thresholds_dbp = zeros(1, numel(thresholds));
percentage_below_thresholds_map = zeros(1, numel(thresholds));
percentage_below_thresholds_sbp = zeros(1, numel(thresholds));

% Iterate over each threshold
for i = 1:numel(thresholds)
    % Calculate the percentage of predictions below the current threshold for DBP
    percentage_below_thresholds_dbp(i) = sum(abs(signal_GT_concat - signal_pred_concat) < thresholds(i)) / numel(signal_GT_concat) * 100;

    % Calculate the percentage of predictions below the current threshold for MAP
    percentage_below_thresholds_map(i) = sum(abs((2 * signal_GT_concat + signal_pred_concat) / 3 - signal_GT_concat) < thresholds(i)) / numel(signal_GT_concat) * 100;

    % Calculate the percentage of predictions below the current threshold for SBP
    percentage_below_thresholds_sbp(i) = sum(abs(signal_GT_concat - (2 * signal_GT_concat + signal_pred_concat) / 3) < thresholds(i)) / numel(signal_GT_concat) * 100;
end

% Display the BHS standard percentage for each BP metric and threshold
fprintf('BHS Standard Percentage:\n');
for i = 1:numel(thresholds)
    fprintf('Threshold: %d mmHg\n', thresholds(i));
    fprintf('DBP: %.2f%%\n', percentage_below_thresholds_dbp(i));
    fprintf('MAP: %.2f%%\n', percentage_below_thresholds_map(i));
    fprintf('SBP: %.2f%%\n', percentage_below_thresholds_sbp(i));
    fprintf('\n');
end

% Define bin edges for histogram
bin_edges = 0:2:50; % Adjust the range and bin width as needed

% Calculate absolute error in DBP, MAP, and SBP predictions
error_dbp = abs(signal_GT_concat - signal_pred_concat);
error_map = abs((2 * signal_GT_concat + signal_pred_concat) / 3 - signal_GT_concat);
error_sbp = abs(signal_GT_concat - (2 * signal_GT_concat + signal_pred_concat) / 3);

% Plot histogram for DBP predictions
figure()
histogram(error_dbp, bin_edges, 'FaceColor', 'blue')
hold on
for i = 1:length(thresholds)
    plot([thresholds(i), thresholds(i)], [0, max(histcounts(error_dbp, bin_edges))], 'r--', 'LineWidth', 1.5)
end
hold off
xlabel('Absolute Error (mmHg)')
ylabel('Frequency')
title('Histogram of DBP Prediction Errors')
legend('DBP Errors', 'Thresholds')
grid on

% Plot histogram for MAP predictions
figure()
histogram(error_map, bin_edges, 'FaceColor', 'green')
hold on
for i = 1:length(thresholds)
    plot([thresholds(i), thresholds(i)], [0, max(histcounts(error_map, bin_edges))], 'r--', 'LineWidth', 1.5)
end
hold off
xlabel('Absolute Error (mmHg)')
ylabel('Frequency')
title('Histogram of MAP Prediction Errors')
legend('MAP Errors', 'Thresholds')
grid on

% Plot histogram for SBP predictions
figure()
histogram(error_sbp, bin_edges, 'FaceColor', 'magenta')
hold on
for i = 1:length(thresholds)
    plot([thresholds(i), thresholds(i)], [0, max(histcounts(error_sbp, bin_edges))], 'r--', 'LineWidth', 1.5)
end
hold off
xlabel('Absolute Error (mmHg)')
ylabel('Frequency')
title('Histogram of SBP Prediction Errors')
legend('SBP Errors', 'Thresholds')
grid on