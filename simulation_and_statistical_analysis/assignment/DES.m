function [avgWaitingTime, avgQueueLength] = DES()
    % Initialize DES
    totalCustomers = 10000;

    serverStatus = 0;  
    clock = 0;
    numberInQueue = 0;
    timesOfArrivals = [];
    timeOfLastEvent = 0;
    
    numberDelayed = 0;
    totalDelay = 0;
    areaUnderQ = 0;
    areaUnderB = 0;

    serviceTime = 0; 
    remainingServiceTime = 0; 
    repairTime = inf; 

    nxtDeparture = inf; 

    % init time
    interArrivalTime = arrival(); 
    nextArrival = clock + interArrivalTime; 
    breakdownTime = clock + breakdown(); 


    while (serverStatus == 1) || (numberDelayed < totalCustomers) || (numberInQueue > 0) 

        nextEventTime = min([nextArrival, nxtDeparture, breakdownTime, repairTime]);
        
        sinceLastEventTime = nextEventTime - timeOfLastEvent;
        areaUnderQ = areaUnderQ + numberInQueue * sinceLastEventTime;

        if serverStatus == 1 
            areaUnderB = areaUnderB + sinceLastEventTime;
        end

        timeOfLastEvent = nextEventTime;
        clock = nextEventTime;
        
        %arrival
        if nextEventTime == nextArrival

            if (numberDelayed + numberInQueue + (serverStatus == 1)) < totalCustomers

                % next arrival time
                interArrivalTime = arrival();
                nextArrival = clock + interArrivalTime;
            else
                nextArrival = inf;
            end
            
            if serverStatus == 0 
                serverStatus = 1;
                serviceTime = service();
                nxtDeparture = clock + serviceTime;
            else
                numberInQueue = numberInQueue + 1;
                timesOfArrivals = [timesOfArrivals; clock];
            end
        %breakdown
        elseif nextEventTime == breakdownTime

            if serverStatus == 1
                remainingServiceTime = nxtDeparture - clock;
                nxtDeparture = inf; 
            end
     
            repairTime = clock + repair(); 
            breakdownTime = clock + breakdown(); 
        
        %departure
        elseif nextEventTime == nxtDeparture

            if numberInQueue > 0
                % next product in queue
                arrivalTime = timesOfArrivals(1);
                timesOfArrivals(1) = []; 

                numberInQueue = numberInQueue - 1;
                delay = clock - arrivalTime;

                totalDelay = totalDelay + delay;
                serviceTime = service();

                nxtDeparture = clock + serviceTime;
            else
                %if nothing is in the queue
                serverStatus = 0;
                nxtDeparture = inf;
            end

            numberDelayed = numberDelayed + 1; 
            
        %repair
        elseif nextEventTime == repairTime

            if remainingServiceTime > 0
                serverStatus = 1; 

                nxtDeparture = clock + remainingServiceTime;
                remainingServiceTime = 0;

            elseif numberInQueue > 0
                %next item in the queue
                serverStatus = 1; 

                serviceTime = service();

                arrivalTime = timesOfArrivals(1);
                timesOfArrivals(1) = [];

                numberInQueue = numberInQueue - 1;

                delay = clock - arrivalTime;
                totalDelay = totalDelay + delay;

                nxtDeparture = clock + serviceTime;
            else

                serverStatus = 0;
                nxtDeparture = inf;
            end

            repairTime = inf; 

        end
    end
    
    avgWaitingTime = totalDelay / numberDelayed;
    avgQueueLength = areaUnderQ / clock;
end
