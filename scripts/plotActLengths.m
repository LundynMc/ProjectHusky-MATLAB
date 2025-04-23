function plotActLengths(actLengths)

time = (0:size(actLengths,2)-1)/10;

plot(time,actLengths(1,:), 'r-',  'LineWidth', 1.5)

hold on
plot(time,actLengths(2,:), 'k--', 'LineWidth', 1.5)
plot(time,actLengths(3,:), 'g:',  'LineWidth', 1.5)
plot(time,actLengths(4,:), 'c-.', 'LineWidth', 1.5)
plot(time,actLengths(5,:), 'b-.',  'LineWidth', 1.5)
plot(time,actLengths(6,:), 'm--', 'LineWidth', 1.5)
xlabel("Time")
ylabel("Actuator Lengths")
legend("Act 1", "Act 2","Act 3","Act 4","Act 5","Act 6",'Location','northeastoutside')