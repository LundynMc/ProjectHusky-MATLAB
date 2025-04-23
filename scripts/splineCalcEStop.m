function [topCords,actLengths,n,diff_actLengths]=splineCalcEStop(topCords,actLengths,n)
% Interpolation between poses to generate a smoother platform movement

% Initialize differencing arrays
diff_actLengths = diff(actLengths,1,2);
diff_actLengths = cat(2,zeros(6,1),diff_actLengths);
interpFactor = 4; % Number of poses between old and new poses
interpArray_actLengths = zeros(6,2); % Initialize embedded array
interpArray_topCords = zeros(7,3,interpFactor);
maxDiff = max(abs(diff_actLengths)); % Find maximum difference in diff array

% numDiff = sum(maxDiff>2.6);

actSpacing = 2.6; % Maximum actuator travel per 0.1 seconds
if max(maxDiff) > actSpacing
    for i = 1:size(diff_actLengths,2)
        if maxDiff(i) > actSpacing
            A_actLengths = [actLengths(:,i-1) actLengths(:,i)]; % Index values that are greater than max distance
            A_topCords = [topCords(:,:,i-1) topCords(:,:,i)];
            t = linspace(0,1,2);

            t_interp = linspace(0,1,interpFactor);

            interpArray_actLengths = spline(t,A_actLengths,t_interp);
            interpArray_topCords(:,1,:) = spline(t,[A_topCords(:,1) A_topCords(:,4)],t_interp);
            interpArray_topCords(:,2,:) = spline(t,[A_topCords(:,2) A_topCords(:,5)],t_interp);
            interpArray_topCords(:,3,:) = spline(t,[A_topCords(:,3) A_topCords(:,6)],t_interp);

            actLengths = [actLengths(:,1:i-2) interpArray_actLengths actLengths(:,i+1:end)];
            topCords = cat(3, topCords(:,:,1:i-2), interpArray_topCords, topCords(:,:,i+1:end));
        end
    end
end
