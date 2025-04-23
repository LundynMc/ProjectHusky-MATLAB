function [x_spline,y_spline,z_spline,theta_spline,phi_spline,psi_spline,n]=splineCalc(x,y,z,theta,phi,psi,n)
% Interpolation between poses to generate a smoother platform movement
if n > 1 % If the path has more than 1 pose create spline
    
    t = linspace(0,1,n);
    interpFactor = 35; % Scale factor on how much interpolation between poses
    % Use scale factor of 35 for Husky IMU path
    t_interp = linspace(0,1,interpFactor*n); 
    x_spline = spline(t,x,t_interp);
    y_spline = spline(t,y,t_interp);
    z_spline = spline(t,z,t_interp);
    theta_spline = spline(t,theta,t_interp);
    phi_spline = spline(t,phi,t_interp);
    psi_spline = spline(t,psi,t_interp);
    n = length(t_interp);
else % If the path is just one pose maintain position
    x_spline = x;
    y_spline = y;
    z_spline = z;
    phi_spline = phi;
    theta_spline = theta;
    psi_spline = psi;
end