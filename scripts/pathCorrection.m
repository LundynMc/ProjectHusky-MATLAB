function [topCords,actLengths,violIndices,maxVel,diff_actLengths] = pathCorrection(topCords,actLengths,n)
% Determine out of bounds top plate positions
violIndexMin = find(any(actLengths<297));
violIndexMax = find(any(actLengths>439));
violIndices = [violIndexMin,violIndexMax];

% Initialize home position
topCordsHome = [...
    37.8886,109.3750,253.7500;
    113.6658,-21.8750,253.7500;
    75.7772,-87.5000,253.7500;
    -75.7772,-87.5000,253.7500;
    -113.6658,-21.8750,253.7500;
    -37.8886,109.3750,253.7500;
    37.8886,109.3750,253.7500;
    ];
actLengthsHome =  [292.4993;292.4993;292.4993;...
    292.4993;292.4993;292.4993];

%% Conditions 1, 3, and 4
%{
Condition 1: Path starts in a OoB (Out of Bounds) position

Condition 3: Path goes from a safe position to an OoB position and later
returns to a safe position

Condition 4: Path goes from a safe position to an OoB position and does
not return to a safe position
%}
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
%% Conditions 5: The distance between poses is greater than maximum allowable pose change
% Determine plate accelerations > 1.1"/s or 27.94mm/s
timeStep = 1;

% determine actuator velocity between poses
actLengthChange = diff(actLengths,1,2);
actVel = actLengthChange/timeStep;
maxVel = max(actVel); % index all max velocities of actuators

% interpolate between poses if max velocity is greater than 26mm/s
actSpacing = 2.6; % Maximum actuator mm travel per time interval

if max(maxVel) > actSpacing
    for i = 1:length(actLengthChange)
        if actVel(i) > actSpacing
            [topCords,actLengths,n,diff_actLengths]=splineCalcEStop(topCords,actLengths,n);
        else
            diff_actLengths = 0;
        end
    end

    % Run while loop to ensure that new poses did not create velocity spikes
    while max(maxVel) > actSpacing
        % determine actuator velocity between poses
        actLengthChange = diff(actLengths,1,2);
        actVel = actLengthChange/timeStep;

        maxVel = max(actVel);
        for i = 1:length(actLengthChange)
            if maxVel(i) > actSpacing
                [topCords,actLengths,n,diff_actLengths]=splineCalcEStop(topCords,actLengths,n);
            else
                diff_actLengths = 0;
            end
        end
    end
else
    diff_actLengths = 0;
end