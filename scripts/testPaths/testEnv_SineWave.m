function [x, y, z, phi, theta, psi, n] = testEnv_SineWave
    % Number of points
    n = 3000;  
    t = linspace(0, 20, n);

    % Mid-range wave parameters
    A1 = 0.2; f1 = 0.22; phase1 = pi()/5;  % Primary wave (moderate)
    A2 = 0.1; f2 = 0.35; phase2 = pi()/4;  % Secondary wave (smaller)
    
    % Translation components (X, Y, Z)
    x = zeros(1, n);  
    y = 10 * (A1 * rad2deg(sin(2 * pi * f1 * t + phase1)) + ...
              A2 * rad2deg(sin(2 * pi * f2 * t + phase2)));  
          
    z = 50 * (A1 * sin(2 * pi * f1 * t + phase1) + ...
              A2 * sin(2 * pi * f2 * t + phase2)) + 300;  
    
    % Rotation components (Phi, Theta, Psi)
    phi = 1 * rad2deg(A1 * sin(2 * pi * f1 * t + phase1) + ...
                      A2 * sin(2 * pi * f2 * t + phase2));  
    
    theta = 0.75 * rad2deg(A2 * sin(2 * pi * f2 * t + phase2));  
    
    psi = 0.75 * rad2deg(A2 * sin(2 * pi * f2 * t + phase2));  
end
