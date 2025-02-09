clc; clear; close all;

% Define the number of recursion levels
iterations = 4; % Change this for different detail levels

% True if want to save to a gif
gif_mode = false;
if gif_mode
    saveto = 'koch_snowflake.gif';
end
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

    % Color of lines - k for black
    color = 'k';

    % Draw the three sides of the initial triangle recursively
    % draw_koch(p1, p3, iter);
    % draw_koch(p3, p2, iter);
    % draw_koch(p2, p1, iter);

    % For only one line
    draw_koch(p1, p2, iter, color);

    % To control when to go to next
    waitforbuttonpress();

    if gif_mode
        frame = getframe(gcf);
        im = frame2im(frame);
        [A, map] = rgb2ind(im, 256);
    
        if iter == 1
            imwrite(A, map, saveto, 'gif', 'LoopCount', Inf, 'DelayTime', 1.5)
        else
            imwrite(A, map, saveto, 'gif', 'WriteMode', 'append', 'DelayTime', 1.5)
        end
    end

    pause(1.5)
end


hold off;

% Function to recursively generate the Koch Snowflake
function draw_koch(p1, p2, iter, color)
    if iter == 0
        % Base case: Draw a straight line
        plot([p1(1), p2(1)], [p1(2), p2(2)], color, 'LineWidth', 1.5);
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
        draw_koch(a, b, iter - 1, color);
        draw_koch(b, peak, iter - 1, color);
        draw_koch(peak, c, iter - 1, color);
        draw_koch(c, p2, iter - 1, color);
    end
end
