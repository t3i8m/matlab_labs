n =10000;
i = 1;

containerAvg = zeros(1,n);

while(i<=n)
    X=random('Rician',5,4,100,1);
    containerAvg(i) = sum(X)/100;
    i=i+1;
end

histogram(containerAvg, 100);
title("Distribution of Values in containerAvg");
xlabel("Values");
ylabel("Frequency");

is_normal = lillietest(containerAvg);
if(is_normal==0)
    disp("The mean values are normally distributed.");
else
    disp("The mean values are not normally distributed.");
end