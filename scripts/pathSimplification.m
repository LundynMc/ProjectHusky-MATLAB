function [actLengths,topCords] = pathSimplification(actLengths,topCords)
%% New Simplification
% Remove any pose that does not result in a significant change
% To ensure that this does not remove poses that stay still it will iterate
% across full path and skip insignificant poses that remain in the same
% position

diff_actLengths = max(abs(diff(actLengths,1,2)),[],1) < 0.4;

diff2 = diff([0,diff_actLengths,0]);
startOnes = find(diff2 == 1);
endOnes = find(diff2 == -1) - 1;

mask = ~diff_actLengths;

% Loop through each sequence of ones
for i = 1:length(startOnes)
    if (endOnes(i) - startOnes(i) + 1 >= 5) 
        mask(startOnes(i):endOnes(i)) = true; % Keep if at least 5 ones
    end
end

% Apply mask to keep only the required elements
actLengths = actLengths(:,mask);
topCords = topCords(:,:,mask);
end