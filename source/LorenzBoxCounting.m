% Define Lorenz system parameters
sigma = 10;
rho = 28;
beta = 8/3;

% Lorenz system equations
lorenz = @(t, y) [sigma * (y(2) - y(1));
                  rho * y(1) - y(2) - y(1) * y(3);
                  y(1) * y(2) - beta * y(3)];

% Time span and initial conditions - 20 usually enough to see behavior
tspan = [0 20];
options = odeset('RelTol',1e-6,'AbsTol',1e-6);

% Generate 100 random x, y, z values as a single matrix
num_points = 20;
points = rand(num_points, 3) * 2 - 1;

% Loop through and print the values
avg = 0;
for i = 1:num_points
    % Solve the Lorenz system
    y0 = [points(i, 1); points(i, 2); points(i, 3)];
    [~, yout] = ode45(lorenz, tspan, y0, options);
    
    [~, yout] = ode45(lorenz, tspan, yout(end,:), options);
    
    % Extract x, y, z coordinates
    x = yout(:, 1);
    y = yout(:, 2);
    z = yout(:, 3);
    
    % Total number of points
    N = length(x);
    
    % Maximum radius
    max_radius = 2*max(sqrt((x - mean(x)).^2 + (y - mean(y)).^2 + (z - mean(z)).^2));
    
    % Try adding [] and dim=3 and see what happens
    [D, epsilon, c] = correlationDimension([x, y, z],'MinRadius', min(max_radius/N, 1), 'MaxRadius', max_radius, 'NumPoints', 20);
    
    % Display the estimated correlation dimension
    fprintf('Estimated Correlation Dimension: %.4f\n', D);
    
    % Plot results
    figure(1);
    plot(log10(epsilon), log10(c), 'bo-', 'LineWidth', 2);
    xlabel('log10(r)');
    ylabel('log10(C(r))');
    title(['Estimated Correlation Dimension: ', num2str(D)]);
    grid on;
    
    avg = avg+D;

end
avg = avg/num_points



% 
% % Initialize correlation sum
% correlation_sum = zeros(size(radius_values));
% 
% % Calculate correlation sum for each radius
% for i = 1:length(radius_values)
%     r = radius_values(i);
%     count = 0;
% 
%     for j = 1:N
%         for k = j+1:N
%             if norm([x(j), y(j), z(j)] - [x(k), y(k), z(k)]) <= r
%                 count = count + 1;
%             end
%         end
%     end
% 
%     correlation_sum(i) = count;
% end
% 
% % Calculate correlation integral C(r)
% correlation_integral = 2 * correlation_sum / (N * (N - 1));
% 
% % Fit a line to the data using log-log scale
% log_radius = log(radius_values);
% log_correlation_integral = log(correlation_integral);
% 
% % Identify the indices for the middle 3/4 of the data
% start_index = round(1/8 * length(log_radius));
% end_index = round(7/8 * length(log_radius));
% 
% % Perform polyfit using only the middle 3/4 of the data
% p = polyfit(log_radius(start_index:end_index), log_correlation_integral(start_index:end_index), 1);
% 
% % Fractal dimension is the slope of the line
% fractal_dimension = p(1);
% 
% % Plot results
% figure;
% loglog(radius_values, correlation_integral, 'bo-', 'LineWidth', 2);
% xlabel('log(r)');
% ylabel('log(C(r))');
% title(['Fractal Dimension: ', num2str(fractal_dimension)]);
% grid on;
