clc
close all
clear
% min length 292.35mm
% max length 444.75mm
% 2000, 6250
data = readmatrix("cmotData100.csv");
data = readmatrix("cmotData010.csv");
totalLengthChange = 444.75-292.35;
for j = 1:7
    for i = 1:(size(data,1)-1)
        maxValueCheck(i,j) = max(abs(data(i,j)-data(i+1,j)));
    end
end
k = 1;
for j = 1:7
    for i = 1:(size(maxValueCheck,1))
        if maxValueCheck(i,j) <= 0.01
            index(k,j) = i;
            k = k+1;
        end
    end
end
[maxVal,rowIndex] = max(index)
        

        % if maxValueCheck <= 0.01
            % disp(data(i,j)-data(i+3,j))
            
            % time(j) = data(i,7)-data(1,7);
            % values(j) = data(i,j);
            % maxValues(j) = max(values);
        % end
    % end
    % disp(i)
    % if j < 7
        % voltageChange(j) = maxValues(j)-data(1,j);
        
        % disp(time(j))
        % vel(j) = totalLengthChange/(time(j)/1000);
    % end
% end

% disp(vel)
% 
plot(data(1:end,7),data(1:end,1))

hold on

plot(data(1:end,7),data(1:end,2))
plot(data(1:end,7),data(1:end,3))
plot(data(1:end,7),data(1:end,4))
plot(data(1:end,7),data(1:end,5))
plot(data(1:end,7),data(1:end,6))

xlabel('Time (0.1 sec)')
ylabel('Voltages')
legend('Act 1', 'Act 2', 'Act 3', 'Act 4', 'Act 5', 'Act 6')
hold off
