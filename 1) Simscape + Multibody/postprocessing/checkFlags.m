function overall_flag = checkFlags(distances_out, distances_in, distances_center)
% The function 'checkFlags' assesses each tire's distance and assigns a
% flag based on predefined thresholds. It also considers the distance of the
% trailer tires to the center island to determine the overall flag for the scenario.

    % Check if any tire is outside boundaries
    outsideBoundaries = any(cellfun(@(d_out, d_in) any(d_out < 0.01 | d_in < 0.01), distances_out, distances_in));
    
    if outsideBoundaries
        % If any tire is outside the boundary, set flag to 'Red'
        overall_flag = 'Red';
    else
        % Check the minimum distance of the trailer tires to the center island
        minDistanceToCenter = min(cellfun(@(d_center) min(d_center), distances_center));

        % Determine overall flag based on the distance to center island
        if minDistanceToCenter > 0.25 % More than 25 cm
            overall_flag = 'Green';
        else % Less than or equal to 25 cm
            overall_flag = 'Amber';
        end
    end
end


