%% Multi-Body Dynamics Visualization for Tractor-Semitrailer in a Roundabout
% This script visualizes the positions of a tractor and semitrailer tires
% in relation to a roundabout, calculates the distances of each tire to the
% roundabout boundaries, and assesses the overall safety status based on
% these distances.

% The script includes:
% 1. Plotting steeraxle position & trailer body envelope.
% 2. Plotting tractor & trailer tire envelope.
% 3. Animating the tractor-Semitrailer movement post-simulation.
% 4. Calculating distances of tires to roundabout boundaries.
% 5. Determining the overall safety flag for the roundabout scenario.
% 6. Storing the flag and the simulation outputs (Tire Forces)

%% 1. Plot Position with Roundabout 
% This section creates a plot to visualize the global positions of the
% tractor and trailer in relation to the roundabout. The plot includes the
% tractor's front axle position, the reference path, and the positions of
% both the tractor and trailer tires. 

figure('Name','Global Position Trailer Envelope');  % Create a new figure window

% Defining plot colors and styles for consistency and clarity
colorFrontAxle = [0 0 1]; % Blue
colorRefPath = [0.2 0.5 0]; % Dark green
colorBoundary = [0 0 0]; % Black
colorTrailerBoundary = [0.2 0.5 0.75]; % Cyan
lineWidth = 1.5; % thicker lines 

% Plotting 
hold on; 

% Front axle position of tractor
h_front_axle = plot(p.steeraxle.pos(:, 1), p.steeraxle.pos(:, 2), 'Color', colorFrontAxle, 'LineWidth', lineWidth);

% Reference path for navigation
h_ref_path = plot(rx, ry, '--', 'Color', colorRefPath, 'LineWidth', lineWidth);


% Plotting the roundabout boundaries for reference
h_boundary_rbt = plot(boundary_outx, boundary_outy, 'Color', colorBoundary, 'LineWidth', lineWidth);
plot(boundary_inx, boundary_iny, 'Color', colorBoundary, 'LineWidth', lineWidth);

% Plotting additional trailer boundary points 
h_boundary_trailer = plot(p.semitrailer.center.R(:,1), p.semitrailer.center.R(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);
plot(p.semitrailer.center.L(:,1), p.semitrailer.center.L(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);
plot(p.semitrailer.rear.R(:,1), p.semitrailer.rear.R(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);
plot(p.semitrailer.rear.L(:,1), p.semitrailer.rear.L(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);
plot(p.semitrailer.front.R(:,1), p.semitrailer.front.R(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);
plot(p.semitrailer.front.L(:,1), p.semitrailer.front.L(:,2), 'Color', colorTrailerBoundary, 'LineWidth', lineWidth);

% Plot Settings
xlabel('X coordinate position (m)');
ylabel('Y coordinate position (m)');
title('Global Position');
axis equal; 
grid on;
grid minor;
xlim auto;
ylim auto; 

% Legend
legend([h_front_axle, h_ref_path, h_boundary_rbt, h_boundary_trailer], ...
    'Front Axle Position', 'Reference Path', 'Roundabout Boundary', 'Trailer Boundary Points', ...
    'Location', 'best');
hold off; 

%% 2. Plot Position of Tires with Roundabout 
% This section provides a detailed view of the tractor and trailer tires'
% positions in relation to the roundabout. It creates subplots for both the
% tractor and the trailer, displaying their respective tire positions and
% the roundabout boundaries.

figure('Name','Global Position Tires and envelope'); % Creating a new figure for tire positions and roundabout envelope

% Tractor tires subplot
subplot(2,1,1); % Dividing the figure into 2 subplots and selecting the first.

% Plotting roundabout boundaries for reference in tractor subplot
plot(boundary_outx, boundary_outy, 'k', 'LineWidth', 1,'DisplayName', 'Roundabout Boundary'); % Outer boundary
hold on;
plot(boundary_inx, boundary_iny, 'k', 'LineWidth', 1,'DisplayName', 'Roundabout Boundary'); % Inner boundary
plot(rx, ry, ':', 'LineWidth', 1, 'DisplayName', 'Reference Path'); % Reference path for navigation
plot(p.steeraxle.pos(:, 1), p.steeraxle.pos(:, 2), 'm', 'LineWidth', 1, 'DisplayName', 'Middle Axle Position'); % Middle axle position of the tractor

% Plotting tractor tire positions
plot(p.tyre.steeraxle.pos.L(:,1), p.tyre.steeraxle.pos.L(:,2), 'r', 'LineWidth', 1, 'DisplayName', 'Front Left Tire'); % Front left tire
plot(p.tyre.steeraxle.pos.R(:,1), p.tyre.steeraxle.pos.R(:,2), 'b', 'LineWidth', 1, 'DisplayName', 'Front Right Tire'); % Front right tire
plot(p.tyre.driveaxle.pos.L(:,1), p.tyre.driveaxle.pos.L(:,2), '--r', 'LineWidth', 1, 'DisplayName', 'Rear Left Tire'); % Rear left tire
plot(p.tyre.driveaxle.pos.R(:,1), p.tyre.driveaxle.pos.R(:,2), '--b', 'LineWidth', 1, 'DisplayName', 'Rear Right Tire'); % Rear right tire

% Setting plot
axis equal;
grid on; grid minor;
xlim auto;
ylim auto;
title('Tractor Tires');
legend('show','location','best');

% Trailer tires subplot
subplot(2,1,2); % Selecting the second subplot for trailer tires

% Repeating boundary plots for the trailer subplot
plot(boundary_outx, boundary_outy, 'k', 'LineWidth', 1, 'DisplayName', 'Roundabout Boundary'); % Outer boundary
hold on;
plot(boundary_inx, boundary_iny, 'k', 'LineWidth', 1, 'DisplayName', 'Roundabout Boundary'); % Inner boundary
h_ref_path = plot(rx, ry, ':', 'LineWidth', 1, 'DisplayName', 'Reference Path'); % Reference path for navigation

% Plotting trailer tire positions
h_tire_semitrailer1_L = plot(p.tyre.semitraileraxle1.pos.L(:,1), p.tyre.semitraileraxle1.pos.L(:,2), 'r', 'LineWidth', 1, 'DisplayName', 'Axle 1 Left Tire'); % Axle 1 left tire
h_tire_semitrailer1_R = plot(p.tyre.semitraileraxle1.pos.R(:,1), p.tyre.semitraileraxle1.pos.R(:,2), 'b', 'LineWidth', 1, 'DisplayName', 'Axle 1 Right Tire'); % Axle 1 right tire
h_tire_semitrailer2_L = plot(p.tyre.semitraileraxle2.pos.L(:,1), p.tyre.semitraileraxle2.pos.L(:,2), '--r', 'LineWidth', 1, 'DisplayName', 'Axle 2 Left Tire'); % Axle 2 left tire
h_tire_semitrailer2_R = plot(p.tyre.semitraileraxle2.pos.R(:,1), p.tyre.semitraileraxle2.pos.R(:,2), '--b', 'LineWidth', 1, 'DisplayName', 'Axle 2 Right Tire'); % Axle 2 right tire
h_tire_semitrailer3_L = plot(p.tyre.semitraileraxle3.pos.L(:,1), p.tyre.semitraileraxle3.pos.L(:,2), '-.r', 'LineWidth', 1, 'DisplayName', 'Axle 3 Left Tire'); % Axle 3 left tire
h_tire_semitrailer3_R = plot(p.tyre.semitraileraxle3.pos.R(:,1), p.tyre.semitraileraxle3.pos.R(:,2), '-.b', 'LineWidth', 1, 'DisplayName', 'Axle 3 Right Tire'); % Axle 3 right tire

% Setting plot aesthetics
title('Trailer Tires');
axis equal;
grid on; grid minor;
xlim auto;
ylim auto;
legend('show','location','best'); 
%% 3. To create the animation after the simulation
% This section calls a function to create an animation of the tractor and
% semitrailer's movement through the roundabout. The animation is based on
% the post-simulation data and includes visualization of the vehicle's
% trajectory, boundary positions, and navigation path.
%*Uncomment below to view*
createAnimation(p, rx, ry, boundary_outx, boundary_outy, boundary_inx, boundary_iny);
%% 4. Calculate distance to boundaries
% This section calculates the distance of each tire (both tractor and
% trailer) to the roundabout boundaries. It uses the distance2curve
% function to find the shortest distance from the tire positions to the
% roundabout boundaries.
tic
fprintf('Calculating Distance to Roundabout Boundaries...');

% Coordinates of the inner & outer boundary
mapxy_out = [boundary_outx', boundary_outy']; % Outer boundary
mapxy_in = [boundary_inx', boundary_iny']; %  Inner boundary

% Coordinates of the center island
mapxy_center = [centerx', centery'];

% Preparing a list of tire positions for the distance calculation
tire_positions = {
    p.tyre.steeraxle.pos.L; % Front left tire of tractor
    p.tyre.steeraxle.pos.R; % Front right tire of tractor
    p.tyre.driveaxle.pos.L; % Rear left tire of tractor
    p.tyre.driveaxle.pos.R; % Rear right tire of tractor
    p.tyre.semitraileraxle1.pos.L; % Axle 1 left tire of trailer
    p.tyre.semitraileraxle1.pos.R; % Axle 1 right tire of trailer
    p.tyre.semitraileraxle2.pos.L; % Axle 2 left tire of trailer
    p.tyre.semitraileraxle2.pos.R; % Axle 2 right tire of trailer
    p.tyre.semitraileraxle3.pos.L; % Axle 3 left tire of trailer
    p.tyre.semitraileraxle3.pos.R; % Axle 3 right tire of trailer
};

% Initializing arrays to store distances
distances_out = cell(size(tire_positions));
distances_in = cell(size(tire_positions));
distances_center = cell(6, 1); % There are 6 semitrailer tire positions
numTires = length(tire_positions);
progressBarWidth = 30; % Width of the progress bar

% Calculating distances for each tire to both inner and outer boundaries
for i = 1:numTires
    progressPercent = i / numTires * 100; % Calculate progress percentage
    numDots = floor(i / numTires * progressBarWidth); % Number of dots to display
    fprintf('\r[%-30s] %d%% Completed', repmat('~', 1, numDots), progressPercent); % Update progress bar with percentage
    curvexy = [tire_positions{i}(:,1), tire_positions{i}(:,2)]; % Current tire positions
    [~, distances_out{i}] = distance2curve(curvexy, mapxy_out); % Distance to outer boundary
    [~, distances_in{i}] = distance2curve(curvexy, mapxy_in); % Distance to inner boundary
end

% Calculating distances to the center island inner boundary for semitrailer tires only
semitrailerTires = {
    p.tyre.semitraileraxle1.pos.L; % Axle 1 left tire of trailer
    p.tyre.semitraileraxle1.pos.R; % Axle 1 right tire of trailer
    p.tyre.semitraileraxle2.pos.L; % Axle 2 left tire of trailer
    p.tyre.semitraileraxle2.pos.R; % Axle 2 right tire of trailer
    p.tyre.semitraileraxle3.pos.L; % Axle 3 left tire of trailer
    p.tyre.semitraileraxle3.pos.R; % Axle 3 right tire of trailer
};

for i = 1:length(semitrailerTires)
    curvexy2 = [semitrailerTires{i}(:,1), semitrailerTires{i}(:,2)];
    [~, distances_center{i}] = distance2curve(curvexy2, mapxy_center);
end

% Plotting Distances to Boundaries
% This section creates plots to visualize the distances of each tire to
% both the outer and inner boundaries of the roundabout.

% Plotting Distances to Outer Boundary
figure('Name', 'Distances to Outer Boundary - All tires'); 
hold on;
for i = 1:length(tire_positions)
    plot(distances_out{i}, 'LineWidth', 1);
end
title('Distances to Outer Boundary -  All tires');
xlabel('Sample Point');
ylabel('Distance (m)');
grid on; grid minor;
hold off;

% Plotting Distances to Inner Boundary
figure('Name', 'Distances to Inner Boundary - All tires'); 
hold on;
for i = 1:length(tire_positions)
    plot(distances_in{i}, 'LineWidth', 1);
end
title('Distances to Inner Boundary -  All tires');
xlabel('Sample Point');
ylabel('Distance (m)');
grid on; grid minor;
hold off;

% Plotting Distances to Center Island for Semitrailer Tires
figure('Name', 'Distances to Center Island for Semitrailer Tires'); 
hold on;
for i = 1:length(distances_center)
        plot(distances_center{i}, 'LineWidth', 1);
end
title('Distances to Center Island for Semitrailer Tires');
xlabel('Sample Point');
ylabel('Distance (m)');
grid on; grid minor;
hold off;

% Saving the distance to inner and outer boundairs in an array 

p.roundabout.distances.in = distances_in;
p.roundabout.distances.out = distances_out;
p.roundabout.distances.center = distances_center;

fprintf('\nCompleted Distance Calculation.\n');
toc

%% 5. Overall flag of the scenario 
% This section determines the overall safety flag for the vehicle in the
% roundabout. The flag is based on the closest distances of the tires to
% the roundabout boundaries. It categorizes the safety status as red,
% yellow, or green.

overall_roundabout_flag= checkFlags(distances_out, distances_in,distances_center); % Determining the overall flag
disp(['Overall Roundabout Flag: ', overall_roundabout_flag]); % Displaying the overall flag
%% 6 Save file with roundabout details & Flag
% Saving the relevant data in a structure and then to a .mat file.

% Creating a structure with the required data
structName = sprintf('%s_%d_%d', p.modelname, p.roundabout.OCD, p.roundabout.exit);
eval([structName ' = struct();']);
eval([structName '.time = p.time;']);
eval([structName '.Modelname = p.modelname;']);
eval([structName '.tyre = p.tyre;']);
eval([structName '.Vx = p.Vx;']);
eval([structName '.inputs = p.inputs;']);
eval([structName '.inputs.deltas = [p.steeraxle.del1, p.steeraxle.del2];']);
eval([structName '.overallFlag = overall_roundabout_flag;']);
eval([structName '.roundabout = p.roundabout;']);

% Define the folder name
folderName = '../rbt_data'; % For ZEFES Roundabout Data

% Ensure the folder exists, if not, create it
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

% Creating the file name based on the Modelname, OCD, and exit
% Include the folder in the file path
fileName = fullfile(folderName, sprintf('%s_%d_%d.mat', p.modelname, p.roundabout.OCD, p.roundabout.exit));

% Saving the structure to a .mat file in the specified folder
eval(['save(fileName, ''' structName ''');']);

% Display success message
disp('Data saved successfully!');
disp(['In file: ', fileName]);
