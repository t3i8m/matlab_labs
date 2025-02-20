

i = 1;
random_container = zeros(1, 10000);
random_container(i) = 2^20;
z_next = @(z_curr) mod((65539 * z_curr), 2^31);

while(i < 10000)
    i = i + 1;
    random_container(i) = z_next(random_container(i - 1));
end

random_normalized = random_container / (2^31 - 1);

n_points = 1000;
x_2d = random_normalized(1:n_points);
y_2d = random_normalized(n_points+1:2*n_points);

figure;
scatter(x_2d, y_2d, 'filled');
title('2D Lattice Structure with Random Points');
xlabel('X');
ylabel('Y');
axis equal;
grid on;

x_3d = random_normalized(1:n_points);
y_3d = random_normalized(n_points+1:2*n_points);
z_3d = random_normalized(2*n_points+1:3*n_points);

figure;
scatter3(x_3d, y_3d, z_3d, 'filled');
title('3D Lattice Structure with Random Points');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;
grid on;

for angle = 1:360
    view(angle, 30);
    pause(0.05);
end
