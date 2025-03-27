function [x,y,z,phi,theta,psi,n] = simEnv_RobotX
%% Bag Selection
% bag = rosbag('2023-10-13-16-36-47_IMU.bag');
% bag = rosbag('2024-10-26-14-49-41_IMU.bag');
bag = rosbag('Sept_22_2024_IMU.bag');
% rosbag info 2023-10-13-16-36-47_IMU.bag

%% Data Indexing
topic = select(bag,'Topic','/minion/sensors/pinpoint/odom');
msgStructs = readMessages(topic,'DataFormat','struct');
Points = cellfun(@(m) (m.Pose),msgStructs);

%% Initialization
x = zeros(numel(Points),1);
y = zeros(numel(Points),1);
z = zeros(numel(Points),1);
psi = zeros(numel(Points),1);
theta = zeros(numel(Points),1);
phi = zeros(numel(Points),1);
t = linspace(0,length(x),length(x));
%% Data Retrival
for i = 1:numel(Points)
    Pose(i) = Points(i).Pose;
    Position(i) = Pose(i).Position;
    x(i) = Position(i).X;
    y(i) = Position(i).Y;
    z(i) = Position(i).Z+440;
    Orientation(i) = Pose(i).Orientation;
    XQ(i) = Orientation(i).X;
    YQ(i) = Orientation(i).Y;
    ZQ(i) = Orientation(i).Z;
    WQ(i) = Orientation(i).W;
end
q = [XQ;YQ;ZQ;WQ]';
% Quaternions to Euler Angles
EulAngles = quat2eul(q);
psi = EulAngles(:,1);
theta = EulAngles(:,2);
phi = EulAngles(:,3);


% % Scaling down for testing
% x = x(500:1500);
% y = y(500:1500);
% z = z(500:1500);
% psi = psi(500:1500);
% theta = theta(500:1500);
% phi = phi(500:1500);
n = length(x);