function plot3D(b,p,topCords,x,y,z,N,n)
%% Create a 3D plot
n = length(topCords);
bDatum = zeros(1,3);
pDatum = [x;y;z];

% Plot the base points in blue
figure(1)
plot3(b(:,1,end), b(:,2,end), b(:,3,end), 'b-o', 'MarkerSize', 8, 'DisplayName', 'Base Points');

% Plot configuration
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
% view(11.5508,22.9084) % GoAero
% Plot base datum
plot3(bDatum(1,1),bDatum(1,2),bDatum(1,3),'b-x','MarkerSize',8,'DisplayName','Base Plate Datum');

% Plot the platform points in green
% plot3(p(:,1), p(:,2), p(:,3), 'g-o', 'MarkerSize', 8, 'DisplayName', 'Platform Points');

% Plot the leg points in red
top = plot3(topCords(:,1,end), topCords(:,2,end), topCords(:,3,end), 'r-o', ...
    'MarkerSize', 8, 'DisplayName', 'Leg Points');

% % Plot dynamic datum
% topDatum = plot3(pDatum(1,end),pDatum(2,end),pDatum(3,end),'r-x', ...
%     'MarkerSize',8,'DisplayName','Dynamic Plate Datum');

% Plot lines (legs) connecting the base points and platform points
legPlot = gobjects(1,N);
for i = 1:N
    % Draw a line between corresponding base and platform points
    legPlot(i) = plot3([b(i,1), topCords(i,1,end)], [b(i,2), topCords(i,2,end)], ...
        [b(i,3), topCords(i,3,end)], 'k-', 'LineWidth', 2,'DisplayName','Leg');
end

%% Animation
% k = 10;
for i = 1:n-1
    set(top, 'XData', topCords(:,1,i),'YData',topCords(:,2,i),'ZData',topCords(:,3,i))
    % set(topDatum,'XData',pDatum(1,i),'YData',pDatum(2,i),'ZData',pDatum(3,i))

    for j = 1:N
    % Draw a line between corresponding base and platform points
    set(legPlot(j),'XData',[b(j,1), topCords(j,1,i)],'YData', [b(j,2), topCords(j,2,i)], ...
        'ZData', [b(j,3), topCords(j,3,i)]);
    end
    drawnow;
    % view(90,0) % Side view
    % view(k,18) % Rotating angled Side view
    % view(10,18) % Angled side view
    % view(0,90) % Top view
    % view(11.5508,22.9084) % GoAero
    view(50,20)
    % pause(.01)
    % k = k+2;
end
set(top, 'XData', topCords(:,1,end),'YData',topCords(:,2,end),'ZData',topCords(:,3,end))
% set(topDatum,'XData',pDatum(1,end),'YData',pDatum(2,end),'ZData',pDatum(3,end))
for i=1:N
    set(legPlot(i),'XData',[b(i,1), topCords(i,1,end)],'YData', [b(i,2), topCords(i,2,end)], ...
        'ZData', [b(i,3), topCords(i,3,end)]);
end

hold off;