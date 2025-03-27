function [x,y,z,phi,theta,psi,n] = simEnv_SmoothData
% Provide data for calculations and plotting
n = 20; % Number of points

x = linspace(-80,80,n); % Translation on x-axis
y = linspace(-80,80,n); % Translation on y-axis
z = linspace(300,450,n); % Translation on z-axis
phi = linspace(-30,30,n); % Rotation about x-axis
theta = linspace(30,-30,n); % Rotation about y-axis
psi = linspace(-30,30,n); % Rotation about z-axis

% % Adjust end values to set platform to Home position
% x(n) = 0;
% y(n) = 0;
% z(n) = 0;
% theta(n) = 0;
% phi(n) = 0;
% psi(n) = 0;