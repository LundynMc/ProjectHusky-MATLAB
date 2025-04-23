function [totalActTravel,avgActChange] = actTravel(actLengths)
% Determine the total and average actuator length change
actLengthChange = diff(actLengths,1,2);

totalActTravel = sum(abs(actLengthChange'));

avgActChange = totalActTravel/size(actLengths,2);