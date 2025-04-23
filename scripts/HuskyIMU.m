clc
clear
close all

%% Test 1
test1 = load(['C:\Users\lundy\OneDrive\Documents\24-25\' ...
    'SRDSGN\GitClone\ERAU_ProjectHusky\MATLAB_Local\' ...
    'Husky_IMU_Data\HuskyIMU_Test1.mat']);
%% Test 2
test2 = load(['C:\Users\lundy\OneDrive\Documents\24-25\' ...
    'SRDSGN\GitClone\ERAU_ProjectHusky\MATLAB_Local\' ...
    'Husky_IMU_Data\HuskyIMU_Test2.mat']);

%% Test 3
test3 = load(['C:\Users\lundy\OneDrive\Documents\24-25\' ...
    'SRDSGN\GitClone\ERAU_ProjectHusky\MATLAB_Local\' ...
    'Husky_IMU_Data\HuskyIMU_Test3.mat']);

%% Test 4
test4 = load(['C:\Users\lundy\OneDrive\Documents\24-25\' ...
    'SRDSGN\GitClone\ERAU_ProjectHusky\MATLAB_Local\' ...
    'Husky_IMU_Data\HuskyIMU_Test4.mat']);

%% Parsing
testData = {test1,test2,test3,test4};
parsedData_Test1 = zeros(length(test1.Orientation.X),6);
parsedData_Test2 = zeros(length(test2.Orientation.X),6);
parsedData_Test3 = zeros(length(test3.Orientation.X),6);
parsedData_Test4 = zeros(length(test4.Orientation.X),6);

for i = 1:length(testData)
    X = testData{i}.Acceleration.X;
    Y = testData{i}.Acceleration.Y;
    Z = testData{i}.Acceleration.Z;
    Phi = testData{i}.Orientation.X;
    Theta = testData{i}.Orientation.Y;
    Psi = testData{i}.Orientation.Z;
    if i == 1
        parsedData_Test1 = [X(1:length(Phi)),Y(1:length(Phi)),...
            Z(1:length(Phi)),Phi,Theta,Psi];
    elseif i == 2
        parsedData_Test2 = [X(1:length(Phi)),Y(1:length(Phi)),...
            Z(1:length(Phi)),Phi,Theta,Psi];
    elseif i == 3
        parsedData_Test3 = [X(1:length(Phi)),Y(1:length(Phi)),...
            Z(1:length(Phi)),Phi,Theta,Psi];
    elseif i == 4
        parsedData_Test4 = [X(1:length(Phi)),Y(1:length(Phi)),...
            Z(1:length(Phi)),Phi,Theta,Psi];
    end
end

%% Send to CSV
% Format: X,Y,Z,Phi(Roll),Theta(Pitch),Psi(Yaw)
% writematrix(parsedData_Test1,"HuskyIMUData_Test1.csv")
writematrix(parsedData_Test2,"HuskyIMUData_Test2.csv")
writematrix(parsedData_Test3,"HuskyIMUData_Test3.csv")
writematrix(parsedData_Test4,"HuskyIMUData_Test4.csv")



