% Calculate mean error (ME) for DBP, MAP, and SBP
ME_dbp = mean(error_dbp);
ME_map = mean(error_map);
ME_sbp = mean(error_sbp);

% Calculate standard deviation of errors (SDE) for DBP, MAP, and SBP
SDE_dbp = std(error_dbp);
SDE_map = std(error_map);
SDE_sbp = std(error_sbp);


% Plot histogram for DBP error
figure
histogram(error_dbp, 'BinWidth', 1)
xlabel('Error')
ylabel('Number of Samples')
title('Histogram of DBP Error')

% Plot histogram for MAP error
figure
histogram(error_map, 'BinWidth', 1)
xlabel('Error')
ylabel('Number of Samples')
title('Histogram of MAP Error')

% Plot histogram for SBP error
figure
histogram(error_sbp, 'BinWidth', 1)
xlabel('Error')
ylabel('Number of Samples')
title('Histogram of SBP Error')
