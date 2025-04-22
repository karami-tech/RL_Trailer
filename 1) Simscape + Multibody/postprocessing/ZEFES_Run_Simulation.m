%% For loop for running simulations

%% Define the range of outer diameters and exits
outerDiameters = 26:1:42; % From 26m to 42m with an interval of 1m
exits = 1:4; % From 1 to 4

% Simulink model name
modelName = 'Tractor_Semitrailer';

%% Open the Simulink model
open_system(modelName);

%% Loop over all outer diameters
for diameter = outerDiameters
    % Loop over all exits
    for exit = exits
        % Display current simulation settings
        fprintf('Starting Simulation: Diameter = %d m, Exit = %d\n', diameter, exit);

        % Set the parameters for the current simulation
        p_roundabout_OCD = diameter;
        p_roundabout_exit = exit;
        p_roundabout_lanewidth= 3.5; % entry lane width (default set to 3.5)

        % Run Roundabout generator 
        [rx, ry, boundary_inx, boundary_iny, boundary_outx, boundary_outy,centerx,centery] = make_roundabout_lines_optimize_v4(p_roundabout_OCD, p_roundabout_lanewidth, p_roundabout_exit);
        
        % Define path
        steer_path=[rx,ry]; 
        
        % To end simulation at the final point
        final_x=rx(end); 
        final_y=ry(end);

        % Run the Simulink model
        simOut = sim(modelName);

        % After simulation, run the "ZEFES_Plot_Flag.m" script
        ZEFES_Plot_Flagv2;

        % Display a message upon completion
        fprintf('Simulation completed: Diameter = %d m, Exit = %d\n', diameter, exit);
    end
end

 