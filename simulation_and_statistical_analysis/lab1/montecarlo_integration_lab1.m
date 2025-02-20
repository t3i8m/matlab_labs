function result = calculateZ(a,b,c,d,rx,ry, gx)
    result = (b-a)*(d-c)*gx(rx,ry);
end

gx = @(x,y) 4 - x.^2 - y.^2;
a = 0;
b = 5/4;

c = 1;
d = 7/2;
samples = 1000000;

containerAvg = zeros(1, samples);

i = 1;
while(i<=samples)
    ry = c + (d - c) * rand;
    rx = a + (b - a) * rand;
    z =calculateZ(a,b,c,d,rx,ry,gx);
    containerAvg(i)=z;
    i=i+1;
end
solution = sum(containerAvg)/length(containerAvg);
disp("Approximated solution with " + num2str(samples) + " samples: " + num2str(solution));

optimal = integral2(gx, a,b,c,d);
disp("Optimal solution"+optimal);

figure;
histogram(containerAvg, 100); 
title("Distribution of Values in containerAvg");
xlabel("Values");
ylabel("Frequency");
% Kolmogorov-Smirnov test for normality
[h, p] = kstest((containerAvg - mean(containerAvg)) / std(containerAvg));

if h == 0
    disp("containerAvg appears to be normally distributed (fail to reject null hypothesis).");
else
    disp("containerAvg does not appear to be normally distributed (reject null hypothesis).");
end
