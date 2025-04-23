function [x,y,z,phi,theta,psi,n] = simEnv_Husky
%{
Path Lengths
IMU Test 1 => 350:end
IMU Test 2 => 550:800
IMU Test 3 => 1150:1400
IMU Test 4 => 265:515
%}

% IMUdata = readmatrix("HuskyIMUData_Test1.csv");
% IMUdata = readmatrix("HuskyIMUData_Test2.csv");
% IMUdata = readmatrix("HuskyIMUData_Test3.csv");
IMUdata = readmatrix("HuskyIMUData_Test4.csv");

i = 4; % Path indicator

n = [350,550,1175,265]; % Starting indicies
m = [553,800,1350,515]; % Ending indicies

ax = IMUdata(n(i):m(i),1)';
ay = IMUdata(n(i):m(i),2)';
az = IMUdata(n(i):m(i),3)';

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