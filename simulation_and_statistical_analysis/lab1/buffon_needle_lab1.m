d = 1.5;
l = 1;
n = 1000000000;

num_intersections = 0;

for i =1:n
    alpha = rand * (pi / 2);
    x = rand * (d / 2);
    if(x<=(l/2)*sin(alpha))
        num_intersections = num_intersections+1;
    end
end

pi_estimate = (2*n*l)/(d*num_intersections);
disp(pi_estimate);