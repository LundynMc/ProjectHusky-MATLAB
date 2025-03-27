function rangeFinding(actLengths,currData)
%% Range Finding
minLegLengths = 292; %[246, 292, 348]; % 4, 6, 8
maxLegLengths = 444.5; %[346, 444.5, 548]; % 4, 6, 8
minActIndex = zeros(1,length(minLegLengths));
maxActIndex = zeros(1,length(maxLegLengths));

% for i = 1:length(minLegLengths)
%     test = find(all(actLengths > minLegLengths(i) & actLengths < maxLegLengths(i), 1),1);
% end

for i = 1:length(minLegLengths)
    min = find(all(actLengths > minLegLengths(i) & actLengths < maxLegLengths(i), 1),1);
    if ~isempty(min)
        minActIndex(i) = min;
    else
        minActIndex(i) = 1;
        fprintf('Path Out of Bounds\n')
    end

    max = find(all(actLengths > minLegLengths(i) & actLengths < maxLegLengths(i), 1),1,"last");
    if ~isempty(max)
        maxActIndex(i) = max;
    else
        maxActIndex(i) = 1;
        fprintf('Path Out of Bounds\n')
    end
end

minAct = actLengths(1,minActIndex);
maxAct = actLengths(1,maxActIndex);


range = maxLegLengths-minLegLengths;
fprintf('Stroke Length: 6 inch\n')
fprintf('Min Stroke Length: %.1f\n',minLegLengths)
fprintf('Range %.2f\n',range)
fprintf('Lowest Platform Value:     %.4fmm\n', minAct)
fprintf('Actuator Lengths:          %.4fmm %.4fmm %.4fmm %.4fmm %.4fmm %.4fmm \n\n',actLengths(:,minActIndex))
fprintf('Input Data:\n')
disp(currData(:,minActIndex))
fprintf('Max Stroke Length: %.1f\n', maxLegLengths)
fprintf('Maximum Platform Value:    %.4fmm\n', maxAct)
fprintf('Actuator Lengths:          %.4fmm %.4fmm %.4fmm %.4fmm %.4fmm %.4fmm \n\n',actLengths(:,maxActIndex))
fprintf('Input Data:\n')
disp(currData(:,maxActIndex))