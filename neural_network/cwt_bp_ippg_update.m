% Set file paths
ippg_dir = 'fh-dortmund.sciebo.de\\AbgabeRamesh\\Source_Code\\Ippg_to_bp\\drive-download-20221101T190921Z-001';
bp_dir = 'fh-dortmund.sciebo.de\\AbgabeRamesh\\Source_Code\\Ippg_to_bp\\drive-download-20221101T190921Z-001\Bp_csv';

% Get file names
ippg_files = dir(fullfile(ippg_dir, '*.csv'));
bp_files = dir(fullfile(bp_dir, '*.csv'));

% Initialize lists
cwt_ippg_updated = {};
cwt_bp_updated = {};

% Process ippg signals
for i = 1:length(ippg_files)
    % Load file
    ippg_file = fullfile(ippg_dir, ippg_files(i).name);
    ippg_signal = csvread(ippg_file);

t_orig = 0 : (length(ippg_signal)-1);
t_resampled = 0 : 1/1000 : (length(ippg_signal)-1)/1000;
ippg_resampled = resample(ippg_signal(:,2), 1000, round(1000));

% Compute CWT
cwt_ippg = signal_to_cwt(ippg_resampled, 0, 1, 1, 25);


% Append to list
cwt_ippg_updated{i} = cwt_ippg;
end

% Process bp signals
% Process bp signals
for i = 1:length(bp_files)
    % Load file
    bp_file = fullfile(bp_dir, bp_files(i).name);
    bp_table = readtable(bp_file);
    
    % Extract data from table
    bp_signal = bp_table{:,1};
    
    % Compute CWT
    cwt_bp = signal_to_cwt(bp_signal,0,0,0,1000);
    
    % Append to list
    cwt_bp_updated{i} = cwt_bp;
end



