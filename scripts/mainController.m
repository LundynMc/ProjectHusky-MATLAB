clc
clear
close all

%% Intialization
N = 6; % Number of Actuators

%% Simulated Environments
% [x,y,z,phi,theta,psi,n] = simEnv_SmoothData;
% [x,y,z,phi,theta,psi,n] = simEnv_SinglePoint;
% [x,y,z,phi,theta,psi,n] = simEnv_GoAero;
% [x,y,z,phi,theta,psi,n] = simEnv_OpenMutt;
% [x,y,z,phi,theta,psi,n] = simEnv_RobotX;
% [x,y,z,phi,theta,psi,n] = simEnv_RobotX2;
% [x,y,z,phi,theta,psi,n] = simEnv_SeaState;
% [x,y,z,phi,theta,psi,n] = simEnv_Husky;
[x,y,z,phi,theta,psi,n] = testEnv_6DOFInitialization;

currData = [x,y,z,phi,theta,psi]; % Collect current data

%% Spline
% [x_spline,y_spline,z_spline,theta_spline,phi_spline,psi_spline,n]=splineCalc(x,y,z,theta,phi,psi,n);

%% Inverse Kinematics
% Calculate leg lengths and moving platform coordinates
[topCords,b,p,actLengths,t] = invKin(x,y,z,theta,phi,psi,n,N);
% [topCords,b,p,actLengths,t] = invKin(x_spline,y_spline,z_spline,theta_spline,phi_spline,psi_spline,n,N);
%% Path Correction
[topCords,actLengths,violIndices,maxVel,diff_actLengths] = pathCorrection(topCords,actLengths,n);

%% Path simplification
[actLengths,topCords] = pathSimplification(actLengths,topCords);

%% Path correction validation
max_diff = max(abs(diff(actLengths, 1, 2)));
max_diff_index = find(max_diff>2.6); % Find all pose jumps that are greater than 26mm/s
% vIndexMin = find(all(actLengths<297));
% vIndexMax = find(all(actLengths>439));

%% Translation from change of length to voltages
% [actVoltages,deltaLength] = length2Voltage(actLengths);

%% Plot system
% plot3D(b,p,topCords,x,y,z,N,n) % Raw data
% plot3D(b,p,topCords,x_spline,y_spline,z_spline,N,n) % Spline data

%% Create path csv file
% createCSV(actLengths,actVoltages)

%% Total actuator travel distance
[totalActTravel,avgActChange] = actTravel(actLengths);
