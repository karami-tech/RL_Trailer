% Folder containing the .mat files
folderName = '../rbt_data';
 
% Get a list of all .mat files in the folder
matFiles = dir(fullfile(folderName, '*.mat'));
 
% Initialize a table to store the results
resultsTable = table();
 
% Loop through each file and extract the necessary data
for i = 1:length(matFiles)
    % Construct the full file path
    filePath = fullfile(matFiles(i).folder, matFiles(i).name);
 
    % Load the .mat file
    loadedData = load(filePath);
    % The structure name is dynamic and matches the file name without extension
    structName = erase(matFiles(i).name, '.mat');
    % Extract the necessary information
    if isfield(loadedData, structName)
        roundaboutData = loadedData.(structName);
        laneWidth = 3.5; % Assuming lane width is constant
        diameter = roundaboutData.roundabout.OCD;
        exitNumber = roundaboutData.roundabout.exit;
        flag = roundaboutData.overallFlag;
        % Append to the results table
        resultsTable = [resultsTable; table(laneWidth, diameter, exitNumber, {flag})];
    end
end
 
% Define column names
resultsTable.Properties.VariableNames = {'LaneWidth', 'RoundaboutDiameter', 'ExitNumber', 'Flag'};
 
% Export the table to an Excel file
filename = 'TractorSemitrailerRoundaboutResultsv3.xlsx';
writetable(resultsTable, filename);
 
disp(['Data exported successfully to ' filename]);