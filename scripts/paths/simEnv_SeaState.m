function [x,y,z,phi,theta,psi,n] = simEnv_SeaState
% Provide data for calculations and plotting
n = 50; % Number of points
x = linspace(-50,100,n); % Translation on x-axis
y = linspace(-50,100,n); % Translation on y-axis
z = zeros(1,n); % Translation on z-axis
phi = zeros(1,n); % Rotation about x-axis
theta = zeros(1,n); % Rotation about y-axis
psi = zeros(1,n); % Rotation about z-axis


% Inputs:
% duration - Total simulation time in seconds
% dt - Time step
% seaState - '2' for Sea State 2, '3' for Sea State 3
duration = n;
seaState = 2;
dt = 1;

% Parameters based on sea state
if seaState == 2
    waveHeight = 300; % Average wave height for sea state 2
    waveFrequency = 0.5; % Approximate wave frequency
elseif seaState == 3
    waveHeight = 900; % Average wave height for sea state 3
    waveFrequency = 0.7; % Approximate wave frequency
else
    error('Invalid sea state. Choose 2 or 3.');
end

time = 0:dt:duration;

% Wave generation (example sine waves with noise)
z = waveHeight * sin(2 * pi * waveFrequency * time) ...
    + 0.1 * waveHeight * randn(size(time)); % Vertical motion
pitch = 0.1 * z .* sin(2 * pi * waveFrequency * time + pi/4); % Pitch motion
roll = 0.1 * z .* sin(2 * pi * waveFrequency * time + pi/2); % Roll motion

% Assume x and y drift are negligible
x = zeros(size(time));
y = zeros(size(time));
yaw = zeros(size(time)); % Can be added if yaw motion is needed

% Combine into pose data
z = z + 292 + abs(min(z));
phi = rad2deg(roll);
theta = rad2deg(pitch);
psi = rad2deg(yaw);
end