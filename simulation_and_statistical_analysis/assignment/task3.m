% Add your code for Task 3 in this file


% arrays to store results of indep. simulations
avgWaitingTimeContainer = zeros(20,1);
avgQueueLengthContainer = zeros(20,1);

% execute 20 simulations
for i = 1:20
    [avgWaitingTime, avgQueueLength] = DES();
    avgWaitingTimeContainer(i) = avgWaitingTime;
    avgQueueLengthContainer(i) = avgQueueLength;
end

% get descreptive statistics
meanWaitingTime = mean(avgWaitingTimeContainer);
meanQueueLength = mean(avgQueueLengthContainer);

disp("Waiting Time Mean: "+meanWaitingTime);
disp("Queue Length Mean: "+meanQueueLength);
