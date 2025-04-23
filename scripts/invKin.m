function [topCords,b,p,actLengths,t] = invKin(x,y,z,theta,phi,psi,n,N)
%% Initialization

topCords = zeros(6,3,n); % Length of actuator legs
t = [x;y;z]; % Relation between static platform origin and moving platform origin
% t(:,end) = [0;0;100];
R = zeros(3,3,n); % Rotation Matrix
p = zeros(N,3); % Coordinates of actuator connection at moving plate
b = zeros(N,3); % Coordinates of actuator connection at static plate
actLengths = zeros(6,n); % Actuator leg lengths
%% Define coordinates for static plate
% Hexagon mounting positions
rad = 515/2; % radius
iterAngle = 60;
for i = 1:N
    b(i,:) = [rad*cosd(iterAngle),rad*sind(iterAngle),0];
    iterAngle=iterAngle-60;
end

%% Define coordinates for dynamic plate
% Assuming triangle orientation with spaced out actuators at points
edgeLength = 175; % Length from origin to edge intersection
mountLength = edgeLength*.375; % Length from edge intersection to actuator connection parallel line
edgeMountAngle = 30; % Angle associated with point identification
%{
1. (-,+)
2. (-,-)
3. (-,-)
4. (+,-)
5. (+,-)
6. (+,+)
1 - 5
2 - 6
3 - 1
4 - 2
5 - 3
6 - 4
%}
p(1,:) = [mountLength*tand(edgeMountAngle),edgeLength-mountLength,0];
p(2,:) = [edgeLength*cosd(edgeMountAngle)-mountLength*tand(edgeMountAngle),-(edgeLength*sind(edgeMountAngle)-mountLength),0];
p(3,:) = [edgeLength*cosd(edgeMountAngle)-mountLength/cosd(edgeMountAngle),-edgeLength*sind(edgeMountAngle),0];
p(4,:) = [-(edgeLength*cosd(edgeMountAngle)-mountLength/cosd(edgeMountAngle)),-edgeLength*sind(edgeMountAngle),0];
p(5,:) = [-(edgeLength*cosd(edgeMountAngle)-mountLength*tand(edgeMountAngle)),-(edgeLength*sind(edgeMountAngle)-mountLength),0];
p(6,:) = [-mountLength*tand(edgeMountAngle),edgeLength-mountLength,0];

% p(1,:) = [edgeLength*cosd(edgeMountAngle)-mountLength*tand(edgeMountAngle),-(edgeLength*sind(edgeMountAngle)-mountLength),0];
% p(2,:) = [mountLength*tand(edgeMountAngle),edgeLength-mountLength,0];
% p(3,:) = [-mountLength*tand(edgeMountAngle),edgeLength-mountLength,0];
% p(4,:) = [-(edgeLength*cosd(edgeMountAngle)-mountLength*tand(edgeMountAngle)),-(edgeLength*sind(edgeMountAngle)-mountLength),0];
% p(5,:) = [-(edgeLength*cosd(edgeMountAngle)-mountLength/cosd(edgeMountAngle)),-edgeLength*sind(edgeMountAngle),0];
% p(6,:) = [edgeLength*cosd(edgeMountAngle)-mountLength/cosd(edgeMountAngle),-edgeLength*sind(edgeMountAngle),0];
%% Define rotational matrix
for i = 1:n
    % Row 1
    R(1,1,i) = cosd(psi(i))*cosd(theta(i));
    R(1,2,i) = -sind(psi(i))*cosd(phi(i)) + cosd(psi(i))*sind(theta(i))*sind(phi(i));
    R(1,3,i) = sind(psi(i))*sind(phi(i)) + cosd(psi(i))*sind(theta(i))*cosd(phi(i));
    % Row 2
    R(2,1,i) = sind(psi(i))*cosd(theta(i));
    R(2,2,i) = cosd(psi(i))*cosd(phi(i)) + sind(psi(i))*sind(theta(i))*sind(phi(i));
    R(2,3,i) = -cosd(psi(i))*sind(phi(i)) + sind(psi(i))*sind(theta(i))*cosd(phi(i));
    % Row 3
    R(3,1,i) = -sind(theta(i));
    R(3,2,i) = cosd(theta(i))*sind(phi(i));
    R(3,3,i) = cosd(theta(i))*cosd(phi(i));
end

%% Calculate leg coordinates
for i=1:n
    for j=1:N
        p1 = p(j,:)';
        b1 = b(j,:)';
        pRot = R(:,:,i)*p1;
        topCords(j,:,i) = t(:,i)+pRot;
    end
end

%% Calculate leg lengths
for i = 1:n
    for j = 1:N
    actLengths(j,i) = sqrt((topCords(j,1,i)-b(j,1))^2+(topCords(j,2,i)-b(j,2))^2+(topCords(j,3,i)-b(j,3))^2);
    end
    topCords(7,:,i) = topCords(1,:,i);
end
b(7,:) = b(1,:);