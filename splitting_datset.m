% Load the data
data = load('D:\Documents\FH-Dortmund\Mini Project thesis\ippg_to_bp\cwt_fps\cwt_signals.mat');

% Extract the cell arrays
cwt_bp_updated = data.cwt_bp_updated;
cwt_ippg_updated = data.cwt_ippg_updated;

% Calculate the number of rows for each set
training_rows = floor(0.7 * numel(cwt_bp_updated));
validation_rows = floor(0.15 * numel(cwt_bp_updated));
testing_rows = numel(cwt_bp_updated) - training_rows - validation_rows;

% Randomly shuffle the indices for each set
indices = randperm(numel(cwt_bp_updated));
training_indices = indices(1:training_rows);
validation_indices = indices(training_rows+1:training_rows+validation_rows);
testing_indices = indices(training_rows+validation_rows+1:end);

% Extract the data for each set using the shuffled indices
training_data_bp = cwt_bp_updated(training_indices);
training_data_ippg = cwt_ippg_updated(training_indices);

validation_data_bp = cwt_bp_updated(validation_indices);
validation_data_ippg = cwt_ippg_updated(validation_indices);

testing_data_bp = cwt_bp_updated(testing_indices);
testing_data_ippg = cwt_ippg_updated(testing_indices);

% Save the data to separate MAT files
save('D:\Documents\FH-Dortmund\Mini Project thesis\ippg_to_bp\cwt_fps\training_data.mat', 'training_data_bp', 'training_data_ippg');
save('D:\Documents\FH-Dortmund\Mini Project thesis\ippg_to_bp\cwt_fps\validation_data.mat', 'validation_data_bp', 'validation_data_ippg');
save('D:\Documents\FH-Dortmund\Mini Project thesis\ippg_to_bp\cwt_fps\testing_data.mat', 'testing_data_bp', 'testing_data_ippg');
