function [reject, R] = runsTest(u, a)
    aboveAVG = 0;
    belowAVG = 0;
    r = 0;
    AVG = 0.5; % because X~U(0,1) and E(x) = 0.5
    seriesCOUNT = zeros(length(u), 1);
    aboveAVG_ROW = 0;
    belowAVG_ROW = 0;
    iFOR_SERIES_COUNT = 1;
    i = 1;

    % alg to divide the series
    while(i<=length(u))
        if(u(i)<=AVG)
            belowAVG=belowAVG+1;

            if(aboveAVG_ROW>0)
                seriesCOUNT(iFOR_SERIES_COUNT) = aboveAVG_ROW;
                iFOR_SERIES_COUNT=iFOR_SERIES_COUNT+1;
            end

            aboveAVG_ROW=0;
            belowAVG_ROW=belowAVG_ROW+1;
        else
            aboveAVG=aboveAVG+1;
            aboveAVG_ROW=aboveAVG_ROW+1;
            if(belowAVG_ROW>0)
                seriesCOUNT(iFOR_SERIES_COUNT) = belowAVG_ROW;
                iFOR_SERIES_COUNT=iFOR_SERIES_COUNT+1;
            end
            belowAVG_ROW=0;
        end

        i=i+1;
    end

    if aboveAVG_ROW > 0
        seriesCOUNT(iFOR_SERIES_COUNT) = aboveAVG_ROW;
    elseif belowAVG_ROW > 0
        seriesCOUNT(iFOR_SERIES_COUNT) = belowAVG_ROW;
    end

    %count series
    for n = 1:length(seriesCOUNT)
        if(seriesCOUNT(n)>0)
            r=r+1;
        end
    end

    % calculate expected R and variance
    N = length(u); 
    expected_R = (2*aboveAVG*belowAVG)/n + 0.5;
    variance_R = (2 * aboveAVG * belowAVG * (2 * aboveAVG * belowAVG - N)) / (N^2 * (N - 1));

    R = (r - expected_R) / sqrt(variance_R);

    % critical value 
    critical_value = norminv(1 - a / 2); 
    disp("R: "+R);
    disp("CriticalValue: "+critical_value);
    % determine if null hypothesis is rejected
    if(abs(R)<critical_value)
        reject = false;
    else
        reject = true;

end