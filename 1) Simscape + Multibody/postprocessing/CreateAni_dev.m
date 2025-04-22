function createAnimation2(p, rx, ry, boundary_outx, boundary_outy, boundary_inx, boundary_iny)
    figure('Name','Global Position Animation');
    xlabel('X coordinate position (m)');
    ylabel('Y coordinate position (m)');
    title('Tractor and Trailer Envelope Animation');
    axis equal;
    grid on;
    xlim([min(boundary_outx) max(boundary_outx)])
    ylim([min(boundary_outy) max(boundary_outy)])
    hold on;

    % Static elements
    plot(rx, ry, '--', 'LineWidth', 1);
    h_boundary_rbt_outer = plot(boundary_outx, boundary_outy, 'k', 'LineWidth', 1);
    h_boundary_rbt_inner = plot(boundary_inx, boundary_iny, 'k', 'LineWidth', 1);
   

    % Initialize envelope patches with dummy data
    h_envelope_tractor = patch('XData', NaN, 'YData', NaN, 'FaceColor', [0.9 0.8 0.1], 'EdgeColor', 'r', 'FaceAlpha', 0.5, 'LineWidth', 1);
    h_envelope_trailer = patch('XData', NaN, 'YData', NaN, 'FaceColor', [0.1 0.8 0.9], 'EdgeColor', 'c', 'FaceAlpha', 0.5, 'LineWidth', 1);

    % Initialize text object for flag status
    flag_status_text = text(0.01, 0.99, 'Flag: Green', 'FontSize', 16, 'Color', 'black', 'Units', 'normalized', 'VerticalAlignment', 'top', 'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 5);
    
    % Decide the skip rate based on your timestep and desired speed
    skip_rate = 10; % Example: Skip every 10th data point

    % Animation loop
    for t = 1:skip_rate:length(p.semitrailer.center.L(:, 1))
        % Define the vertices of the tractor & trailer box (envelope) for time t
        envelopeX_tractor = [p.chassis.rear.L(t, 1), p.chassis.front.L(t, 1), p.chassis.front.R(t, 1), p.chassis.rear.R(t, 1)];
        envelopeY_tractor = [p.chassis.rear.L(t, 2), p.chassis.front.L(t, 2), p.chassis.front.R(t, 2), p.chassis.rear.R(t, 2)];
        envelopeX_trailer = [p.semitrailer.rear.L(t, 1), p.semitrailer.front.L(t, 1), p.semitrailer.front.R(t, 1), p.semitrailer.rear.R(t, 1)];
        envelopeY_trailer = [p.semitrailer.rear.L(t, 2), p.semitrailer.front.L(t, 2), p.semitrailer.front.R(t, 2), p.semitrailer.rear.R(t, 2)];

        % Update the envelope patch data for both tractor and trailer
        set(h_envelope_tractor, 'XData', envelopeX_tractor, 'YData', envelopeY_tractor);
        set(h_envelope_trailer, 'XData', envelopeX_trailer, 'YData', envelopeY_trailer);

        % Determine the flag based on the tractor and trailer's position
        flag = getFlagForPosition(p, t, boundary_outx, boundary_outy, boundary_inx, boundary_iny);
        
        % Determine the flag based on the tractor and trailer's position
        flag = getFlagForPosition(p, t, boundary_outx, boundary_outy, boundary_inx, boundary_iny);

        % Update the flag status text
        set(flag_status_text, 'String', ['Flag: ' flag], 'Color', getColorForFlag(flag), 'BackgroundColor', getBackgroundColorForFlag(flag));

       % % Optional: Change roundabout boundary color based on flag
       % set(h_boundary_rbt_outer, 'Color', getColorForFlag(flag));
       % set(h_boundary_rbt_inner, 'Color', getColorForFlag(flag));

        % Store the roundabout information with the flag
        roundaboutInfo(t) = struct('boundary_outx', boundary_outx, 'boundary_outy', boundary_outy, 'flag', flag);

        drawnow;
        pause(0.001); % Adjust for desired animation speed
    end

    % Save the roundabout information after the animation
    saveRoundaboutInfo(roundaboutInfo);
end

% Funtion to get the Flag (Green, Yellow , Red) according to the envelop of the vehicle

function flag = getFlagForPosition(p, t, boundary_outx, boundary_outy, boundary_inx, boundary_iny)
    % Define the amber zone threshold
    amber_threshold = 0.5; % meters

    % Initialize flag as not entered
    flag = 'Not Entered';

    % Define the roundabout entry and exit points
    entry_x = boundary_outx(1);
    entry_y = boundary_outy(1);
    exit_x = boundary_outx(end);
    exit_y = boundary_outy(end);

    % Get the vehicle's rear, front, and center positions
    vehicle_rear_x = min([p.chassis.rear.L(t, 1), p.semitrailer.rear.L(t, 1)]);
    vehicle_front_x = max([p.chassis.front.R(t, 1), p.semitrailer.front.R(t, 1)]);
    vehicle_center_x = [p.chassis.center.L(t, 1), p.chassis.center.R(t, 1), p.semitrailer.center.L(t, 1), p.semitrailer.center.R(t, 1)];
    vehicle_center_y = [p.chassis.center.L(t, 2), p.chassis.center.R(t, 2), p.semitrailer.center.L(t, 2), p.semitrailer.center.R(t, 2)];

    % Check if the vehicle has entered the roundabout completely
    if vehicle_rear_x < entry_x
        return; % Vehicle has not entered the roundabout yet
    end

    % Check if the vehicle has exited the roundabout
    if vehicle_front_x > exit_x
        flag = 'Exited'; % Vehicle has exited the roundabout
        return;
    end

    % Check if any part of the vehicle's center is out of the roundabout bounds
    if any(vehicle_center_x > max(boundary_outx)) || any(vehicle_center_x < min(boundary_inx)) || ...
       any(vehicle_center_y > max(boundary_outy)) || any(vehicle_center_y < min(boundary_iny))
        flag = 'Red';
        return;
    end
    
    % Check for amber flag (close to boundary)
    % (This assumes boundary_outx and boundary_outy are the outermost points)
    closest_distance_to_boundary = min([...
        abs(vehicle_center_x - max(boundary_outx)), ...
        abs(vehicle_center_x - min(boundary_inx)), ...
        abs(vehicle_center_y - max(boundary_outy)), ...
        abs(vehicle_center_y - min(boundary_iny)) ...
    ]);

    if closest_distance_to_boundary <= amber_threshold
        flag = 'Yellow';
        return;
    end

    % If none of the above, the vehicle is within bounds and the flag is green
    flag = 'Green';
end

function color = getColorForFlag(flag)
    % Return the color corresponding to the flag
    switch flag
        case 'Green'
            color = 'g';
        case 'Yellow'
            color = 'y';
        case 'Red'
            color = 'r';
        otherwise
            color = 'k'; % Default color
    end
end

function bgColor = getBackgroundColorForFlag(flag)
    % Return the background color corresponding to the flag
    switch flag
        case 'Green'
            bgColor = [0.8 1 0.8]; % Light green
        case 'Yellow'
            bgColor = [1 1 0.6]; % Light yellow
        case 'Red'
            bgColor = [1 0.7 0.7]; % Light red
        otherwise
            bgColor = [1 1 1]; % Default white
    end
end


function saveRoundaboutInfo(info)
    % Implement logic to save the information to a file or variable
    % This could be as simple as saving to a .mat file or writing to a text file
    save('roundaboutInfo.mat', 'info');
end
