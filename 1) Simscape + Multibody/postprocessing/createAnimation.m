function createAnimation(p, rx, ry, boundary_outx, boundary_outy, boundary_inx, boundary_iny)
% The function 'createAnimation' is responsible for generating the animation.

% Parameters passed to the function include: 
% p: Structure containing position data of the tractor and trailer. 
% rx, ry: Coordinates for the reference path. 
% boundary_outx, boundary_outy: Coordinates for the outer boundary of the roundabout. 
% boundary_inx, boundary_iny: Coordinates for the inner boundary of the roundabout. 

% This animation aids in visually understanding the vehicle's dynamics and compliance with the roundabout constraints.
figure('Name','Global Position Animation');
xlabel('X coordinate position (m)');
ylabel('Y coordinate position (m)');
title('Tractor and Trailer Envelope Animation');
axis equal;
grid on;
xlim auto;
ylim auto;
hold on;

% Static elements
plot(rx, ry, '--', 'LineWidth', 1);
h_boundary_rbt_outer = plot(boundary_outx, boundary_outy, 'k', 'LineWidth', 1);
h_boundary_rbt_inner = plot(boundary_inx, boundary_iny, 'k', 'LineWidth', 1);

% Initialize envelope patches with dummy data
h_envelope_tractor = patch('XData', NaN, 'YData', NaN, 'FaceColor', [0.9 0.8 0.1], 'EdgeColor', 'r', 'FaceAlpha', 0.5, 'LineWidth', 1);
h_envelope_trailer = patch('XData', NaN, 'YData', NaN, 'FaceColor', [0.1 0.8 0.9], 'EdgeColor', 'c', 'FaceAlpha', 0.5, 'LineWidth', 1);

% Initialize tire boxes with dummy data
num_tractor_tires = 4; % Number of tractor tires (2 axles x 2 tires per axle)
num_trailer_tires = 6; % Number of trailer tires (3 axles x 2 tires per axle)
total_tires = num_tractor_tires + num_trailer_tires;
h_tire_boxes = gobjects(total_tires, 1); % Adjust to match total number of tires


% Decide the skip rate based on your timestep and desired speed
skip_rate = 1; % Example: Skip every 10th data point

% % Initialize VideoWriter
% video = VideoWriter('animation.mp4', 'MPEG-4');
% open(video);

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

    % Define tire box dimensions (assuming a fixed tire size for illustration)
    tire_width = 0.2; % Example tire width, adjust as necessary
    tire_length = 0.2; % Example tire length, adjust as necessary

    % Tractor tire boxes
    tire_positions_tractor = [p.tyre.steeraxle.pos.L(t, :); p.tyre.steeraxle.pos.R(t, :);
        p.tyre.driveaxle.pos.L(t, :); p.tyre.driveaxle.pos.R(t, :)];
    % Trailer tire boxes
    tire_positions_trailer = [p.tyre.semitraileraxle1.pos.L(t, :); p.tyre.semitraileraxle1.pos.R(t, :);
        p.tyre.semitraileraxle2.pos.L(t, :); p.tyre.semitraileraxle2.pos.R(t, :);
        p.tyre.semitraileraxle3.pos.L(t, :); p.tyre.semitraileraxle3.pos.R(t, :)];

    % Update or create tire boxes
    for i = 1:size(tire_positions_tractor, 1)
        if ~isgraphics(h_tire_boxes(i))
            h_tire_boxes(i) = rectangle('Position', [tire_positions_tractor(i,1)-tire_length/2, tire_positions_tractor(i,2)-tire_width/2, tire_length, tire_width], 'EdgeColor', 'b', 'LineWidth', 1);
        else
            set(h_tire_boxes(i), 'Position', [tire_positions_tractor(i,1)-tire_length/2, tire_positions_tractor(i,2)-tire_width/2, tire_length, tire_width]);
        end
    end
    for i = 1:size(tire_positions_trailer, 1)
        idx = size(tire_positions_tractor, 1) + i;
        if ~isgraphics(h_tire_boxes(idx))
            h_tire_boxes(idx) = rectangle('Position', [tire_positions_trailer(i,1)-tire_length/2, tire_positions_trailer(i,2)-tire_width/2, tire_length, tire_width], 'EdgeColor', 'b', 'LineWidth', 1);
        else
            set(h_tire_boxes(idx), 'Position', [tire_positions_trailer(i,1)-tire_length/2, tire_positions_trailer(i,2)-tire_width/2, tire_length, tire_width]);
        end
    end

    drawnow;
    pause(0.001); % Adjust for desired animation speed
end

% % Close the video file
% close(video);
%
% % Save the roundabout information after the animation
% saveRoundaboutInfo(roundaboutInfo);
end

% function saveRoundaboutInfo(info)
%     % Save the roundabout information to a file
%     save('roundaboutInfo.mat', 'info');
% end



