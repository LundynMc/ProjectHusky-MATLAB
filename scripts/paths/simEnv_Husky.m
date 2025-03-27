function [x,y,z,phi,theta,psi,n] = simEnv_Husky
IMUdata = readmatrix("HuskyIMUData_Test1.csv");
ax = IMUdata(1:end,1)';
ay = IMUdata(1:end,2)';
az = IMUdata(1:end,3)';

n = length(ax);
x = zeros(1,n);
y = zeros(1,n);
z = zeros(1,n)+300;
psi = zeros(1,n);
theta = real(asind(ax/9.81));
phi = atan2d(ay,az);

% Tested using the psi, theta, and phi values directly from model:
% psi = IMUdata(1:end,4)';
% theta = IMUdata(1:end,5)';
% phi = IMUdata(1:end,6)';