function [actVoltages,deltaLength] = length2Voltage(actLengths)
% Translating the data from change in length to change in voltage
% y=mx
% ASSUMPTION: Linear speed scale 
deltaLength = abs(diff(actLengths, 1, 2));
maxSpeed = 27.94; % mm/s
voltRange = 1; % 12 Volt system, but data needs to be formatted from 0-1

slope = maxSpeed/voltRange;
actVoltages = deltaLength/slope;

for i = 1:length(actVoltages)
    for j = 1:6
        if actVoltages(j,i) < 0.05
            actVoltages(j,i) = 0;
        else
            actVoltages(j,i) = round(actVoltages(j,i),2);
        end
    end
end


