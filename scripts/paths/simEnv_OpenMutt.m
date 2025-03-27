function [x,y,z,phi,theta,psi,n] = simEnv_OpenMutt
%{
NOTE: 
This data is from an unknown source, it is most likely from the
exoskeleton. The data from OpenMutt should be joint torques for 12 motors
%}

IMUdata = readmatrix("OpenMuttIMUData.csv");
ax = IMUdata(1300:2000,1)';
ay = IMUdata(1300:2000,2)';
az = IMUdata(1300:2000,3)';



n = length(ax);
x = zeros(1,n);
y = zeros(1,n);
z = zeros(1,n)+300;
psi = zeros(1,n);
theta = real(asind(ax/9.81));
phi = atan2d(ay,az);