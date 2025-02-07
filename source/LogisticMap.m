% Logistic Map Simulation and Period Doubling Diagram

clear; clc;

% Parameters:  r_min and r_max set the range of r that will be scanned
r_min = 1; r_max = 3.99;          % full range
% r_min = 3.4;  r_max = 3.9;        % initial period doubling cascade

           % Maximum value of r
% r_min = 3.565;          % Minimum value of r
% r_max = 3.575;          % Maximum value of r
% r_min = 3.8496;          % Minimum value of r
% r_max = 3.8497;          % Maximum value of r
num_points = 50000;  % Number of points in period doubling diagram
num_iterations = 1000; % Number of iterations to reach steady state
num_plot=500;

% Generate values of r
r_values = linspace(r_min, r_max, num_points);

% Iterate over each value of r
cnt=1;
bifurcation_points = zeros(num_plot*num_points,1);
r_points = bifurcation_points;
for i = 1:num_points
    r=r_values(i);
    
    % Initial condition
    x = 0.5;
    
    % Iterate logistic map to reach steady state
    for j = 1:num_iterations
        x = r * x * (1 - x);
    end
    
    % Iterate further to gather bifurcation points
    for j = 1:num_plot
     
        x = r * x * (1 - x);
        bifurcation_points(cnt) = x;
        r_points(cnt) = r;
        cnt=cnt+1;
    end
end

% Plotting period doubling diagram
figure;
plot(r_points, bifurcation_points, '.', 'MarkerSize', 1);
xlabel('r');
ylabel('x');
title('Period Doubling Diagram - Logistic Map');
xlim([r_min, r_max]);