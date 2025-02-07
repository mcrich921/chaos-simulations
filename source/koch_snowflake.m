clc; clear; close all;

% Define the number of recursion levels
iterations = 4; % Change this for different detail levels

saveto = 'koch_snowflake.gif';

% Define the initial equilateral triangle
p1 = [0, 0];
p2 = [1, 0];
p3 = [0.5, sqrt(3)/2];

% Create figure
figure; hold on; axis equal;
title(['Koch Snowflake - Iterations: ', num2str(iterations)]);

for iter = 1:iterations
    cla;
    title(['Koch Snowflake - Iterations: ', num2str(iter)]);

    % Draw the three sides of the initial triangle recursively
    draw_koch(p1, p3, iter);
    draw_koch(p3, p2, iter);
    draw_koch(p2, p1, iter);

    frame = getframe(gcf);
    im = frame2im(frame);
    [A, map] = rgb2ind(im, 256);

    if iter == 1
        imwrite(A, map, saveto, 'gif', 'LoopCount', Inf, 'DelayTime', 1.5)
    else
        imwrite(A, map, saveto, 'gif', 'WriteMode', 'append', 'DelayTime', 1.5)
    end

    pause(1.5)
end


hold off;

% Function to recursively generate the Koch Snowflake
function draw_koch(p1, p2, iter)
    if iter == 0
        % Base case: Draw a straight line
        plot([p1(1), p2(1)], [p1(2), p2(2)], 'k', 'LineWidth', 1.5);
    else
        % Compute new points
        a = p1;
        b = (2*p1 + p2) / 3;
        c = (p1 + 2*p2) / 3;
        
        % Compute the peak of the "spike"
        theta = pi/3; % 60 degrees
        rotation_matrix = [cos(theta), -sin(theta); sin(theta), cos(theta)];
        peak = (c - b) * rotation_matrix' + b;
        
        % Recursively draw the four segments
        draw_koch(a, b, iter - 1);
        draw_koch(b, peak, iter - 1);
        draw_koch(peak, c, iter - 1);
        draw_koch(c, p2, iter - 1);
    end
end
