function [x,y,z,phi,theta,psi,n] = testEnv_XRot
% Provide data for calculations and plotting
n = 5000; % Number of points
x = zeros(1,n); % Translation on x-axis
y = zeros(1,n); % Translation on y-axis
z = zeros(1,n)+300; % Translation on z-axis
phi = linspace(-90,90,n); % Rotation about x-axis
theta = zeros(1,n); % Rotation about y-axis
psi = zeros(1,n); % Rotation about z-axis