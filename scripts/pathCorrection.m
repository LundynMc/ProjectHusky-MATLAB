function [topCords,actLengths,violIndices,maxVel,diff_actLengths] = pathCorrection(topCords,actLengths,n)
% Determine out of bounds top plate positions
violIndexMin = find(any(actLengths<297));
violIndexMax = find(any(actLengths>439));
violIndices = [violIndexMin,violIndexMax];

% Initialize home position
topCordsHome = [...
                113.6658,-21.8750,293;
                37.8886,109.3750,293;
                -37.8886,109.3750,293;
                -113.6658,-21.8750,293;
                -75.7772,-87.5000,293;
                75.7772,-87.5000,293;
                113.6658,-21.8750,293];
actLengthsHome =  [327.1327;327.1327;327.1327;...
                327.1327;327.1327;327.1327];

%% Condition 1: Path starts in a OoB (Out of Bounds) position
if ~(isempty(violIndices))
    for i = 1:length(violIndices)
        if violIndices(i) ~= 1
            topCords(:,:,violIndices(i)) = topCords(:,:,violIndices(i)-1);
            actLengths(:,violIndices(i)) = actLengths(:,violIndices(i)-1);
        elseif violIndices(i) == 1
            topCords(:,:,violIndices(i)) = topCordsHome;
            actLengths(:,violIndices(i)) = actLengthsHome;
        end
    end
end

%% Condition 2: Path does not start and end in home position 
% Start position
if any(all(topCords(:,:,1) ~= topCordsHome(:,:))) && all(actLengths(:,1) ~= actLengthsHome(:,1))
    topCords = cat(3,topCordsHome,topCords);
    actLengths = cat(2,actLengthsHome,actLengths);
end
% End position
% if any(all(topCords(:,:,end) ~= topCordsHome(:,:))) && all(actLengths(:,end) ~= actLengthsHome(:,1))
%     topCords = cat(3,topCordsHome,topCords);
%     actLengths = cat(2,actLengthsHome,actLengths);
% end
%% Conditions 3 and 4:
%{

THIS SECTION IS OVERCOMPLICATED. JUST MAKE IT A DIFFERENCING ROUTINE TO
ENSURE THAT IT DOES NOT GO PAST A CERTAIN DISTANCE IN A SET TIME

%}
% 3: Path goes from a safe position to an OoB position and later returns to a safe position
% 4: Path goes from a safe position to an OoB position and does not return to a safe position

% Determine plate accelerations > 1.1"/s or 27.94mm/s
actLengthChange = zeros(6,length(actLengths));
actVel = zeros(6,length(actLengths));
timeStep = 1;

% determine actuator velocity between poses
for i = 2:size(actLengths,2)
    for j = 1:6
        actLengthChange(j,i) = abs(actLengths(j,i)-actLengths(j,i-1));
        actVel(j,i) = actLengthChange(j,i)/timeStep;
    end
end

maxVel = max(actVel); % index all max velocities of actuators
% interpolate between poses if max velocity is greater than 26mm/s
actSpacing = 26; % Maximum actuator travel per 0.1 seconds

for i = 1:length(actLengthChange)
    if maxVel(i) > actSpacing
        [topCords,actLengths,n,diff_actLengths]=splineCalcEStop(topCords,actLengths,n);
    else
        diff_actLengths = 0;
    end
end
% Run while loop to ensure that new poses did not create velocity spikes
maxMaxVel = max(maxVel);
while maxMaxVel > actSpacing
    for i = 2:length(actLengths)
        for j = 1:6
            actLengthChange(j,i) = abs(actLengths(j,i)-actLengths(j,i-1));
            actVel(j,i) = actLengthChange(j,i)/timeStep;
        end
    end

    maxVel = max(actVel);
    for i = 1:length(actLengthChange)
        if maxVel(i) > actSpacing
            [topCords,actLengths,n,diff_actLengths]=splineCalcEStop(topCords,actLengths,n);
        else
            diff_actLengths = 0;
        end
    end
end