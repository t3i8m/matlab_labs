function [x_new, y_new] = simStep(x, y, e1, a1, e2, a2, dt)
    x_new = x+(e1*x-a1*x*y)*dt;
    y_new = y+(-e2*y+a2*x*y)*dt;
end


% Write a function simStep that takes the parameter set x(t), y(t), ε1, α1, ε2, α2, ∆t as its input
% arguments and gives x(t + ∆t) and y(t + ∆t) as its output arguments, according to the Lotka-
% Volterra Predator-Prey Model. This involves discretization of the model; you have to replace
% the derivatives by appropriate expressions involving the time step. The input will thus be
% scalar and will contain the current state of the model along with the parameters and the
% time-step. The function simStep should start as:
x = 10;   % init prey num
y = 5;    % init pred num
e1 = 0.5; 
a1 = 0.02;
e2 = 0.3; 
a2 = 0.01;
dt = 0.1; 

[x_new, y_new] = simStep(x, y, e1, a1, e2, a2, dt);

disp(['New x: ', num2str(x_new)]);
disp(['New y: ', num2str(y_new)]);

% Write a script file that simulates by iteration the Lotka-Volterra Predator-Prey Model, using
% simStep for 10000 time-steps of size ∆t = 0.1 with the following parameters and initial
% conditions:

i = 1;
iterations = 10000;
new_x = zeros(iterations, 1);
new_y = zeros(iterations, 1);
time = (0:iterations) * dt;
e1 = 0.04;
a1 = 0.0005;
e2 = 0.3;
a2 = 0.001;
x_eq = e2 / a2;
y_eq = e1 / a1;
new_x(1) = x_eq;
new_y(1) = y_eq;
dt = 0.1;
while(i<=iterations)
    i=i+1;
    [x_new, y_new] = simStep(new_x(i-1), new_y(i-1), e1, a1, e2, a2, dt);
    new_x(i) = x_new;
    new_y(i) = y_new;
end


figure;
plot(time, new_x, 'b', 'LineWidth', 1.5); hold on;
plot(time, new_y, 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Population');
legend('Prey (x)', 'Predators (y)');
title('Predator-Prey Population Dynamics');
grid on;

%Solve the model that has been described earlier with one of the Matlab solvers for the same
% parameters, initial condition and time steps.
function dydt = lotka_volterra(t, y, e1, a1, e2, a2)
    dydt = zeros(2,1);
    dydt(1) = e1 * y(1) - a1 * y(1) * y(2); % dx/dt
    dydt(2) = -e2 * y(2) + a2 * y(1) * y(2); % dy/dt
end

y0 = [50; 5]; % init conditions x0 y0
tspan = [0 1000];
[t, Y] = ode45(@(t,y) lotka_volterra(t, y, e1, a1, e2, a2), tspan, y0);
figure;
plot(t, Y(:,1), 'b', 'LineWidth', 1.5); hold on;
plot(t, Y(:,2), 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Population');
legend('Prey (x)', 'Predators (y)');
title('Predator-Prey Model Solution (ode45)');
grid on;

% The Lotka-Volterra model described above involves exponential growth of the preys in absence
% of predators. It can be made more realistic by including a term which limits the growth rate
% of the preys depending on the population size. (See for instance the model specification on
% p.14 of the lecture notes.) This means that an extra quadratic term is included in the first
% differential equation. Add such a term −σ1x2 to obtain the model

function [x_new, y_new] = simStepImproved(x, y, e1, a1, e2, a2, dt, sigm)
    x_new = x+(e1*x-a1*x*y-sigm*x^2)*dt;
    y_new = y+(-e2*y+a2*x*y)*dt;
end

i = 1;
iterations = 10000;
new_x = zeros(iterations, 1);
new_y = zeros(iterations, 1);
time = (0:iterations) * dt;
e1 = 0.04;
a1 = 0.0005;
e2 = 0.3;
a2 = 0.001;
sigm = 0.00004;
x_eq = 50;
y_eq = 5;
new_x(1) = x_eq;
new_y(1) = y_eq;
dt = 0.1;
while(i<=iterations)
    i=i+1;
    [x_new, y_new] = simStepImproved(new_x(i-1), new_y(i-1), e1, a1, e2, a2, dt, sigm);
    new_x(i) = x_new;
    new_y(i) = y_new;
end
x_eq = (e2 / a2) * (1 - sigm * e2 / (a2 * e1));
y_eq = e2/a2;
figure;
plot(time, new_x, 'b', 'LineWidth', 1.5); hold on;
plot(time, new_y, 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Population');
legend('Prey (x)', 'Predators (y)');
title('Predator-Prey Population Dynamics');
grid on;
disp(['Eq x: ', num2str(x_eq)]);

disp(['Eq y: ', num2str(y_eq)]);

% Consider the following state-space system in continuous time, with input u(t) and output
% y(t):
% x′(t) = Ax(t) + Bu(t)
% y(t) = Cx(t) + Du(t)

A = [4,1,0; -7,-1,-1; 119,32,-8];
B = [0; 0; -1];
C = [227, 55, -13];
D = -2;

system1 = ss(A,B,C,D);
H = tf(system1);
disp('Transfer Function H(s):');
H