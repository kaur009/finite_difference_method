% Solution of Laplace's Equation using Finite Difference Method
% code by Muujic

% Parameters
v1 = 20.0;   % Potential on the bottom edge
v2 = 150.0;  % Potential on the right edge
v3 = 50.0;   % Potential on the top edge
v4 = 10.0;   % Potential on the left edge
ni = 200;    % Number of iterations
nx = 20;     % Number of X grid points
ny = 15;     % Number of Y grid points

% Initialize the potential grid with zeroes
phi = zeros(nx, ny);

% Set fixed potentials on the grid boundaries
phi(2:nx-1, 1) = v1;    % Bottom edge
phi(2:nx-1, ny) = v3;   % Top edge
phi(1, 2:ny-1) = v4;    % Left edge
phi(nx, 2:ny-1) = v2;   % Right edge

% Set corner potentials as the average of adjacent edges
phi(1, 1) = 0.5 * (v1 + v4);      % Bottom-left corner
phi(nx, 1) = 0.5 * (v1 + v2);     % Bottom-right corner
phi(1, ny) = 0.5 * (v3 + v4);     % Top-left corner
phi(nx, ny) = 0.5 * (v2 + v3);    % Top-right corner

% Perform the finite difference method iterations
for k = 1:ni
    for i = 2:nx-1
        for j = 2:ny-1
            phi(i, j) = 0.25 * (phi(i+1, j) + phi(i-1, j) + phi(i, j+1) + phi(i, j-1));
        end
    end
end

% Visualization of the potential field
figure;
[X, Y] = meshgrid(1:ny, 1:nx);
surf(X, Y, phi, 'EdgeColor', 'none');
title('Solution of Laplace''s Equation', 'FontSize', 16, 'Color', 'b');
xlabel('X', 'FontSize', 14, 'Color', 'r');
ylabel('Y', 'FontSize', 14, 'Color', 'r');
zlabel('\phi (Potential)', 'FontSize', 14, 'Color', 'r');
colorbar;
colormap(jet);
view(45, 45);
grid on;
axis tight; 
