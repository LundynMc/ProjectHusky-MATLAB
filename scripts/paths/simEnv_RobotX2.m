function [x,y,z,phi,theta,psi,n] = simEnv_RobotX2


% CHATGPT CODE DON'T USE



%Specify the path to ROS bag file
% bag = rosbag('2023-10-13-16-36-47_IMU.bag');
bag = rosbag('2024-10-26-14-49-41_IMU.bag');
% bag = rosbag('Sept_22_2024_IMU.bag');

%Display information about the bag
% disp(bag)

%List all topics in the bag
topics=bag.AvailableTopics;
% disp(topics)

%Select a specific topic
selectedTopic=select(bag,'Topic','/minion/sensors/pinpoint/odom');

%Read messages
msgs=readMessages(selectedTopic);

%Number of messages
numMessages=length(msgs);

% Preallocate arrays
timeStamps=zeros(numMessages, 1);
quaternionData=zeros(numMessages, 4); %[X,Y,Z,W]
posData=zeros(numMessages, 3);

for i=1:numMessages
    timeStamps(i)=selectedTopic.MessageList.Time(i); %Extract timestamp
    
    %Extract Quaternion from Odometry Message
    quaternionData(i,:)=[
        msgs{i}.Pose.Pose.Orientation.X, 
        msgs{i}.Pose.Pose.Orientation.Y, 
        msgs{i}.Pose.Pose.Orientation.Z, 
        msgs{i}.Pose.Pose.Orientation.W
    ];

    % Extract Position from Odom message
    posData(i,:) = [ 
        msgs{i}.Pose.Pose.Position.X,
        msgs{i}.Pose.Pose.Position.Y,
        msgs{i}.Pose.Pose.Position.Z
        ];
end

%Normalize timestamps to start from 0
timeStamps=timeStamps-timeStamps(1);

%Convert Quaternion to Euler Angles
eulerAngles=quat2eul(quaternionData,'ZYX'); %Yaw,Pitch,Roll

%Extract roll,pitch,yaw
yaw=eulerAngles(:,1);
pitch=eulerAngles(:,2);
roll=eulerAngles(:,3);

% Convert to deg
psi = rad2deg(yaw)-180; % Z
theta = rad2deg(pitch)*10; % Y
phi = rad2deg(roll)+123; % X

% Extract x, y, z
x = posData(:,1)-92;
y = posData(:,2)-213.943;
z = posData(:,3)+280;

n = length(x);
