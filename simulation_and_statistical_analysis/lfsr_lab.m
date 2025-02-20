r = 5-1;
q = 3-1;
starting_bit = [1,1,1,1,1];

i = 0;
while(i<45)
    decimal_value = 0;
    for k = 1:length(starting_bit)
        decimal_value = decimal_value + starting_bit(k) * 2^(length(starting_bit) - k);
    end    
    disp("W" + i + " " + mat2str(starting_bit) + " - Decimal: " + num2str(decimal_value));    new_bits = starting_bit;
    for j=0:4
        bi = xor(new_bits(5-r), new_bits(5-q));
        for n = 1:(length(starting_bit) - 1)
            new_bits(n) = new_bits(n + 1); 
        end
        new_bits(5) = bi;

    end
    starting_bit = new_bits;
    i=i+1;
end