function [x,y,z,phi,theta,psi,n] = simEnv_SinglePoint
n = 1; % Number of points
x(n) = 0; % Translation on x-axis
y(n) = 0; % Translation on y-axis
z(n) = 293; % Translation on z-axis (411mm is absolute min height)
phi(n) = 0; % Rotation about x-axis
theta(n) = 0; % Rotation about y-axis
psi(n) = 0; % Rotation about z-axis