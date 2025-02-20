function result = findCycle(func, max)
    container = strings(1, max);
    
    for i = 1:max
        container(i) = findWalk(func, i, max);
    end
    
    result = container;
end

function walk = findWalk(func, seed, max)
    random_container = zeros(1, max);
    random_container(1) = seed; 
    
    for i = 2:max
        random_container(i) = func(random_container(i - 1));
    end
    
    str = num2str(random_container);
    str = strrep(str, ' ', ''); 
    
    walk = str;
end

lcg1 = @(z_curr) mod((7 * z_curr + 2), 11);
result = findCycle(lcg1, 11);
disp(result);
