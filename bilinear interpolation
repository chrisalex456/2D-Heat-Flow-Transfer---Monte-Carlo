clc; clear all;
n = 11;           % grid size
dt = 0.01;        % time step
num_steps = 100;  % number of iterations

% initial conditions
phi = zeros(n, n); % Temperature matrix
phi(:, 1) = 10;     % Left boundary
phi(1, :) = 3;     % Bottom boundary
phi(:, end) = 0;   % Right boundary
phi(end, :) = 7;   % Top boundary

% simulation
error_margin = zeros(num_steps, 1);
for step = 1:num_steps
    for i = 2:n-1
        for j = 2:n-1
            phi_prev = phi;
            phi(i, j) = (phi(i+1, j) + phi(i-1, j) + phi(i, j+1) + phi(i, j-1))/4;
            phi(:, 1) = 10;    % Left boundary
            phi(1, :) = 3;     % Boundary boundary
            phi(:, end) = 0;   % Right boundary
            phi(end, :) = 7;   % Top boundary
            error_margin(step) = max(abs(phi(:) - phi_prev(:)));
            
            % visualization
            contourf(phi, 'EdgeColor','none');
            colorbar();
            title(['Time Step: ' num2str(step) ', Error Margin: ', num2str(error_margin(step))]);
            drawnow;
        end
    end
end

% verification
figure(2);
plot(1:num_steps, error_margin);
xlabel('Time Step');
ylabel('Error Margin');
title('Error Margin Over Time')
