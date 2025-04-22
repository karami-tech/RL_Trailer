function overall_flag = checkFlags_old(distances_out, distances_in)
% The function 'checkFlags' assesses each tire's distance and assigns a
% flag based on predefined thresholds. The overall flag for the scenario is
% determined by the most critical flag among all tires.
flags = cell(size(distances_out));
for i = 1:length(distances_out)
    num_points = length(distances_out{i});
    flags{i} = cell(1, num_points);
    for j = 1:num_points
        flags{i}{j} = getFlag(distances_out{i}(j), distances_in{i}(j));
        % following lines are to print the flags at each point 
        % fprintf('Tire %d, Point %d: Distance Out = %.4f, Distance In = %.4f, Flag = %s\n', ...
        %             i, j, distances_out{i}(j), distances_in{i}(j), flags{i}{j});
    end
end
overall_flag = determineOverallFlag(flags);
end

function flag = getFlag(d_out, d_in)
min_dist = min(d_out, d_in);
if min_dist < 0.01
    flag = 'Red';
elseif min_dist >= 0.01 && min_dist < 0.25
    flag = 'Yellow';
else
    flag = 'Green';
end
end

function overall_flag = determineOverallFlag(flags)
if any(cellfun(@(f) any(strcmp(f, 'Red')), flags))
    overall_flag = 'Red';
elseif any(cellfun(@(f) any(strcmp(f, 'Yellow')), flags))
    overall_flag = 'Yellow';
else
    overall_flag = 'Green';
end
end
