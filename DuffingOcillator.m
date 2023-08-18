function DuffingOscillation
    clear all;
    figure(1);
    fid = fopen('double.dat','w');
            
    amp = 0.42;
    b = 0.5;
    alpha = -1.0;
    beta = 1.0;
    w = 1.0;
    
    % Time step and initial condition          
    tspan = 0:0.1:500;
    x10 = 0.5021;
    x20 = 0.17606;
    y0 = [x10; x20];
    
    op = odeset('abstol',1e-9,'reltol',1e-9);
    [t, y] = ode45(@(t, x) f(t, x, b, alpha, beta, amp, w), tspan, y0, op);
    x1 = y(:, 1);
    x2 = y(:, 2);
    
    % Create a colored 3D trajectory using lines
    colormap(jet(length(t)));
    for i = 1:length(t) - 1
        color = jet(length(t));
        plot3(x1(i:i+1), x2(i:i+1), t(i:i+1), 'Color', color(i, :), 'LineWidth', 1.5);
        hold on;
    end
    colorbar;
    xlabel('X');
    ylabel('Y');
    zlabel('Time');
    title('Colored Duffing Oscillator Trajectory');
    view(45, 30); % Set the view angle for better visualization
    
    fprintf(fid, '%12.6f\n', x1, x2);
    
    function dy = f(t, y, b, alpha, beta, amp, w)
        x1 = y(1);
        x2 = y(2);
        dx1 = x2;
        dx2 = -b * x2 - alpha * x1 - beta * x1^3 + amp * sin(w * t);
        dy = [dx1; dx2];
    end
end
