%% Testing Controller to determine optimal actuator length
clc
clear
close all

%% Intialization
N = 6; % Number of Actuators

%% Testing Environments
% [x,y,z,phi,theta,psi,n] = testEnv_VertRange;
% [x,y,z,phi,theta,psi,n] = testEnv_HorzRange;
% [x,y,z,phi,theta,psi,n] = testEnv_XRot;
% [x,y,z,phi,theta,psi,n] = testEnv_Video;
% [x,y,z,phi,theta,psi,n] = simEnv_SeaState;
% [x,y,z,phi,theta,psi,n] = testEnv_SineWave;
[x,y,z,phi,theta,psi,n] = testEnv_6DOFInitialization;

% currData = [x;y;z;phi;theta;psi]; % Collect current data

%% Spline
% [x_spline,y_spline,z_spline,theta_spline,phi_spline,psi_spline,n]=splineCalc(x,y,z,theta,phi,psi,n);
% [x_spline,y_spline,z_spline,phi_spline,theta_spline,psi_spline] = reg2spline(x,y,z,phi,theta,psi);

%% Inverse Kinematics
% Calculate leg lengths and moving platform coordinates
% [topCords,b,p,actLengths,t] = invKin(x_spline,y_spline,z_spline,theta_spline,phi_spline,psi_spline,n,N);
[topCords,b,p,actLengths,t] = invKin(x,y,z,theta,phi,psi,n,N);

%% Path Correction
[topCords,actLengths,violIndices,maxVel,diff_actLengths] = pathCorrection(topCords,actLengths,n);

%% Path simplification
[actLengths,topCords] = pathSimplification(actLengths,topCords);

%% Path correction validation
max_diff = max(abs(diff(actLengths, 1, 2)));
max_diff_index = find(max_diff>26); % Find all pose jumps that are greater than 26mm/s
% vIndexMin = find(all(actLengths<297));
% vIndexMax = find(all(actLengths>439));

%% Translation from change of length to voltages
[actVoltages,deltaLength] = length2Voltage(actLengths);

%% Plot system
% plot3D(b,p,topCords,x,y,z,N,n) % Raw data
% plot3D(b,p,topCords,x_spline,y_spline,z_spline,N,n) % Spline data

%% Range Finding
% When using this function "path correction" section needs to be commented out
% currData = [x;y;z;phi;theta;psi]; % Collect current data
% rangeFinding(actLengths,currData)

%% Create path csv file
createCSV(actLengths,actVoltages)