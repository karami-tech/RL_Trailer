function overall_roundabout_flag = extractVehicleFlag(vehicleName, roundaboutRadius, exitNumber)
    % Define the folder where data is stored
    folderName = '../rbt_data';
    
    % Construct the file name
    fileName = sprintf('%s_%d_%d.mat', vehicleName, roundaboutRadius, exitNumber);
    filePath = fullfile(folderName, fileName);
    
    % Check if the file exists
    if exist(filePath, 'file')
        % Load the data from the file
        data = load(filePath);
        
        % Extract the overall roundabout flag
        if isfield(data, 'cs_data') && isfield(data.cs_data, 'overallFlag')
            overall_roundabout_flag = data.cs_data.overallFlag;
            disp(['Overall Roundabout Flag for ', vehicleName, ' (Radius: ', num2str(roundaboutRadius), ', Exit: ', num2str(exitNumber), '): ', overall_roundabout_flag]);
        else
            error('Flag data not found in the file.');
        end
    else
        error(['File ', fileName, ' does not exist in the directory ', folderName]);
    end
end
