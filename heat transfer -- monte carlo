clc; clf; clear all;
n = 11;          % grid size
dt = 0.01;       % time step
iters = 100;     % steps until steady-state solution
num_sims = 1000; % number of MC simulations
temp = 1;        % mean temp for SBC

% tracking variables
avg_temp = zeros(num_sims, 1); % average temp across grid
cp_temp = zeros(num_sims, 1);  % center point temperatures
SBC = zeros(num_sims, iters);  % to track values at SBC

% simulation
for run = 1:num_sims
    % Reset initial conditions for each run
    phi = zeros(n, n);
    phi(:, 1) = temp;  % Left boundary
    phi(1, :) = 1;     % Bottom boundary
    phi(:, end) = 0;   % Right boundary
    phi(end, :) = 0;   % Top boundary
    for step = 1:iters
        phi_prev = phi;
        BC = stocasticBoundaryCondition("Brownian", temp, iters, dt);
        for i = 2:n-1
            for j = 2:n-1
                phi(i, j) = (phi(i+1, j) + phi(i-1, j) + phi(i, j+1) + phi(i, j-1)) / 4;
                phi(:, 1) = BC(step);
                SBC(run, step) = BC(step);
            end
        end
    end
    avg_temp(run) = mean(phi(:)); 
    cp_temp(run) = phi(ceil(n/2), ceil(n/2));
end

% frequency domain information
Fs = 1;           % sampling frequency
T = 1/Fs;         % sampling period
L = num_sims;     % length of the signal
t = (0:L-1)*T;    % time vector
f = Fs/L*(0:L-1); % frequency domain

% detrending the data to better inspect FFT peaks
avg_temp_dt = zeros(num_sims, 1);
cp_temp_dt = zeros(num_sims, 1);
for k = 1:length(avg_temp)
    avg_temp_dt(k) = avg_temp(k) - mean(avg_temp);
    cp_temp_dt(k) = cp_temp(k) - mean(cp_temp);
end

% plotting results
figure(1);
plot(1:num_sims, avg_temp_dt);
xlabel("Run");
ylabel("Average Temperature (Detrended)");
title("Average Temperature across MC Runs (Detrended)");

figure(2);
avg_temp_fft_dt = fft(avg_temp_dt);
plot(f, abs(avg_temp_fft_dt));
xlabel("Temperatures");
ylabel("Magnitude");
title("Frequency Domain Plot");

figure(3);
histogram(avg_temp)
title("Average Temperature Distribution")

figure(4);
plot(1:num_sims, cp_temp);
xlabel("Run");
ylabel("Temperature at Center Point");
title("Center Point Temperatures across MC Runs");

figure(5);
cp_temp_fft_dt = fft(cp_temp_dt);
plot(f, abs(cp_temp_fft_dt));
xlabel("Temperatures");
ylabel("Magnitude");
title("Frequency Domain Plot");

figure(6);
histogram(cp_temp);
title("Center Point Temperature Distributions");

figure(7);
histogram(SBC);
title("SBC Values");
