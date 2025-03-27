function createCSV(actLengths, actVoltages)
diff_actLengths = diff(actLengths,1,2);
for i = 1:size(actVoltages,1)
    for j = 1:size(actVoltages,2)
        if diff_actLengths(i,j) < 0
            actVoltages(i,j) = -actVoltages(i,j);
        end
    end
end

actLengths = actLengths';
actLengths = round(actLengths,2);
actVoltages = actVoltages';

pathData = [actLengths(1:end-1,:),actVoltages];

writematrix(pathData,"test1.csv")