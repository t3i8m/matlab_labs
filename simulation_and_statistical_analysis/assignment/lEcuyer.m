function u = lEcuyer(z1, z2, z3, z4, n)
    %params
    L = 32;
    J=4;
    s1=18;
    s2=2;
    s3=7;
    s4=13;

    result = zeros(n,1); %temp container 

    % i use uint33, because we work with 32 bits 
    i = 1;
    while(i<=n)
        
        %for z1
        tempBitsSHIFT_LEFT = bitshift(z1, 6, "uint32");
        tempBitsXOR_CURRENT  = bitxor(tempBitsSHIFT_LEFT, z1);
        tempBitsSHIFT_RIGHT = bitshift(tempBitsXOR_CURRENT, -13, "uint32");
        z1 = bitshift(bitand(z1, 4294967294, "uint32"), s1, "uint32");
        z1 = bitxor(z1, tempBitsSHIFT_RIGHT);
        
        %for z2
        tempBitsSHIFT_LEFT = bitshift(z2, 2, "uint32");
        tempBitsXOR_CURRENT = bitxor(tempBitsSHIFT_LEFT, z2);
        tempBitsSHIFT_RIGHT = bitshift(tempBitsXOR_CURRENT, -27, "uint32");
        z2 = bitshift(bitand(z2, 4294967288, "uint32"), s2, "uint32");
        z2 = bitxor(z2, tempBitsSHIFT_RIGHT);
        
        %for z3
        tempBitsSHIFT_LEFT = bitshift(z3, 13, "uint32");
        tempBitsXOR_CURRENT = bitxor(tempBitsSHIFT_LEFT, z3);
        tempBitsSHIFT_RIGHT = bitshift(tempBitsXOR_CURRENT, -21, "uint32");
        z3 = bitshift(bitand(z3, 4294967280, "uint32"), s3, "uint32");
        z3 = bitxor(z3, tempBitsSHIFT_RIGHT);
        
        % for z4
        tempBitsSHIFT_LEFT = bitshift(z4, 3, "uint32");
        tempBitsXOR_CURRENT = bitxor(tempBitsSHIFT_LEFT, z4);
        tempBitsSHIFT_RIGHT = bitshift(tempBitsXOR_CURRENT, -12, "uint32");
        z4 = bitshift(bitand(z4, 4294967168, "uint32"), s4, "uint32");
        z4 = bitxor(z4, tempBitsSHIFT_RIGHT);
        
        % combine all z and scale it 
        tempRESULT = bitxor(bitxor(z1, z2), bitxor(z3, z4));
        scalling = double(tempRESULT) * 2.3283064365387e-10;
        result(i) = scalling;
        i=i+1;
    end
    u=result;
end