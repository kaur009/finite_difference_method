% One-Dimensional FDTD Simulation with Mur's Absorbing Boundary Conditions
% Code by Muujic

% Parameters
z = 500; % Number of points in the z direction
time = 300; % Number of time steps
zs = 250; % Position of the source in the domain
c = 3e8; % Speed of light (m/s)
Cs = 1; % Courant stability factor
dz = 1e-6; % Spatial step length (m)
dt = Cs * dz / c; % Time step (s)
f = 1e13; % Frequency of the source (Hz)

% Initialize electric and magnetic field intensity vectors
Ex = zeros(1, z);
Hy = zeros(1, z);

% Physical constants
u0 = 1.256e-6; % Magnetic permeability of free space (H/m)
e0 = 8.854e-12; % Electric permittivity of free space (F/m)
n0 = sqrt(u0 / e0); % Intrinsic impedance of free space

% Main loop for time-stepping
for m = 1:time
    % Update Hy using FDTD update equation
    for k = 1:z-1
        Hy(k) = Hy(k) - (dt * c / dz) * (Ex(k + 1) - Ex(k));
    end
    
    % Update Ex using FDTD update equation
    for k = 2:z
        Ex(k) = Ex(k) - (dt * c / dz) * (Hy(k) - Hy(k - 1));
    end
    
    % Sinusoidal source
    Ex(zs) = n0 * sin((2 * pi * f) * (m - 1) * dt);
    
    % Apply Mur's absorbing boundary conditions
    if m >= 2
        Ex(1) = temp_left + ((c * dt - dz) / (c * dt + dz)) * (Ex(2) - Ex(1));
        Ex(z) = temp_right + ((c * dt - dz) / (c * dt + dz)) * (Ex(z - 1) - Ex(z));
    end
    
    % Store boundary values for the next iteration
    temp_left = Ex(2);
    temp_right = Ex(z - 1);
    
    % 3D Plotting of the fields
    figure(1); clf;
    plot3((1:z) * dz, Ex, zeros(1, z), 'b-', 'LineWidth', 2); hold on;
    plot3((1:z) * dz, zeros(1, z), Hy, 'r-', 'LineWidth', 2);
    grid on;
    title('Ex (Blue), Hy (Red)', 'Color', 'black');
    xlabel('z (meters)', 'FontSize', 13, 'Color', 'b');
    ylabel('Ex (Volts/meter)', 'FontSize', 13, 'Color', 'b');
    zlabel('Hy (Tesla)', 'FontSize', 13, 'Color', 'b');
    set(gca, 'FontSize', 13, 'Color', 'c');
    axis([0 z * dz -600 600 -600 600]);
    view([45 45]);
    drawnow;
end
% thankyou for reading