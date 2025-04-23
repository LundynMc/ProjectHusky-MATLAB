function plot3D2(b,p,topCords,x,y,z,N,n)
%% Fast Real-Time 3D Plotting for Stewart Platform
% This script updates the graphical objects in place rather than replotting,
% significantly improving redraw speed.

% Ensure the number of frames is derived from topCords dimensions
n = size(topCords, 3);

% Define static datum for base and platform
bDatum = zeros(1,3);
pDatum = [x; y; z];

% Create the figure, set renderer for performance, and configure the axes
figure(1)
set(gcf, 'Renderer', 'opengl');  % Use OpenGL for hardware-accelerated rendering

% Plot the base points in blue and the base datum
plot3(b(:,1,end), b(:,2,end), b(:,3,end), 'b-o', 'MarkerSize', 8, 'DisplayName', 'Base Points');
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Stewart Platform');
legend;
grid on;
xlim([-600 600])
ylim([-600 600])
zlim([0 600])
plot3(bDatum(1), bDatum(2), bDatum(3), 'b-x', 'MarkerSize', 8, 'DisplayName', 'Base Plate Datum');

% Plot the moving leg points in red and save its handle for updating
hTop = plot3(topCords(:,1,1), topCords(:,2,1), topCords(:,3,1), ...
    'r-o', 'MarkerSize', 8, 'DisplayName', 'Leg Points');

% Create and store handles for the leg line plots
legPlot = gobjects(1, N);
for i = 1:N
    legPlot(i) = plot3([b(i,1), topCords(i,1,1)], ...
                       [b(i,2), topCords(i,2,1)], ...
                       [b(i,3), topCords(i,3,1)], 'k-', 'LineWidth', 2, 'DisplayName','Leg');
end

% Create a text object to display the current pose index
poseText = text(0, 0, 650, sprintf('Pose: %d', 1), 'FontSize', 14, 'Color', 'blue', 'FontWeight', 'bold');

%% Animation Loop – Efficient Updates
for i = 1:n-1
    % Update the leg points (platform points) for current frame
    set(hTop, 'XData', topCords(:,1,i), 'YData', topCords(:,2,i), 'ZData', topCords(:,3,i));
    
    % Update each leg (line connecting the base to the platform point)
    for j = 1:N
        set(legPlot(j), 'XData', [b(j,1), topCords(j,1,i)], ...
                        'YData', [b(j,2), topCords(j,2,i)], ...
                        'ZData', [b(j,3), topCords(j,3,i)]);
    end
    
    % Update the pose index text
    set(poseText, 'String', sprintf('Pose: %d', i), 'Position', [0, 0, 650]);
    
    % Efficiently redraw the updated objects (limitrate minimizes excessive updates)
    drawnow limitrate;
    pause(0.1)
    % Clear any dynamic camera adjustments if needed – here we keep a static view
    view(10,18) % Angled side view
end

% Ensure that the final frame is set, in case the loop omits it.
set(hTop, 'XData', topCords(:,1,end), 'YData', topCords(:,2,end), 'ZData', topCords(:,3,end))
for i = 1:N
    set(legPlot(i), 'XData', [b(i,1), topCords(i,1,end)], ...
                    'YData', [b(i,2), topCords(i,2,end)], ...
                    'ZData', [b(i,3), topCords(i,3,end)]);
end

hold off;
