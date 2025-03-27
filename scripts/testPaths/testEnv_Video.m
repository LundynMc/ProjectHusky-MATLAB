function [x,y,z,phi,theta,psi,n] = testEnv_Video
% Provide data for calculations and plotting
n = 60; % Number of points
x = zeros(n,1)'; % Translation on x-axis
y = [linspace(0,300,n/3),linspace(300,-300,(2*n)/3)]; % Translation on y-axis
z = [linspace(175,225,n/3),linspace(225,175,n/3)...
    linspace(175,225,n/3)]; % Translation on z-axis
phi = [linspace(0,15,n/3),linspace(15,-15,(2*n)/3)]; % Rotation about x-axis zeros(n,1)';
theta = zeros(n,1)'; % Rotation about y-axis
psi = linspace(-60,45,n); % Rotation about z-axis zeros(n,1)';
