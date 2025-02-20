% Add your code for Task 1 in this file
% a)part
u = lEcuyer(2957, 646, 3847, 947, 10000);
disp("H0 - assumes that the numbers are random independent draws from the U(0, 1) distribution.");

[reject, R] = runsTest(u, 0.05);


% H0 - assumes that the numbers are random independent draws from the U(0, 1) distribution.
if reject
    disp("The null hypothesis is rejected");
else
    disp("The null hypothesis is NOT rejected");
end