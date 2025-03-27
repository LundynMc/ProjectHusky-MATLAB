function [x,y,z,phi,theta,psi,n] = testEnv_VertRange
% Provide data for calculations and plotting
n = 100; % Number of points
x = zeros(1,n); % Translation on x-axis
y = zeros(1,n); % Translation on y-axis
z = linspace(0,1000,n); % Translation on z-axis
phi = zeros(1,n); % Rotation about x-axis
theta = zeros(1,n); % Rotation about y-axis
psi = zeros(1,n); % Rotation about z-axis
