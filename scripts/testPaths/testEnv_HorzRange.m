function [x,y,z,phi,theta,psi,n] = testEnv_HorzRange
% Provide data for calculations and plotting
n = 2000; % Number of points
x = linspace(-1000,1000,n); % Translation on x-axis
y = zeros(1,n); % Translation on y-axis
z = zeros(1,n)+293; % Translation on z-axis
phi = zeros(1,n); % Rotation about x-axis
theta = zeros(1,n); % Rotation about y-axis
psi = zeros(1,n); % Rotation about z-axis
