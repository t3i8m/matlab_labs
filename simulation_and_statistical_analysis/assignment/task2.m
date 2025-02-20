% Add your code for Task 2 in this file

% a) 
load("dataIndAss2425.mat");
columnNames = fieldnames(dat);
disp("Column name: "+columnNames);
% get all the observations of benzene        
benzene = dat.C6H6;

% some params of the benzene column before any modifications
disp("STATISTICS FOR BENZE COLUMN BEFORE: ");
medianBENZENE = median(benzene);
meanBENZENE = mean(benzene);
standardDev = std(benzene);
disp("MEDIAN: "+medianBENZENE);
disp("MEAN: "+meanBENZENE);
disp("std: "+standardDev);

% visualization
% box plot
figure;
boxplot(benzene, "Orientation", "vertical");
title("Box Plot of Benzene");
ylabel("Concentration");

% scatter plot
figure;
scatter(1:length(benzene), benzene, "filled", "MarkerFaceColor", "b");
title("Scatter Plot of Benzene");
xlabel("Index");
ylabel("Concentration");

% histogram
figure;
histogram(benzene, 20, "FaceColor", "g", "EdgeColor", "black");
title("Histogram of Benzene");
xlabel("Concentration");
ylabel("Frequency");

% after data visualization it is clearly seen:
% 1) box plot - we may see group of outliers below -200(probably an invalid data, because the concentration cannot be below 0) and a high
% outlier concentration after 3rdQuartile meanning a specific data behaviour - long right tail (will examine it later) 
% 2) scatter plot - found out, that there are several variables with the value
% -200(maybe a systematic error) and a couple of very high variables with
% values above 60 possibly representing rare events or anomalies
%3) histogram - data is mostly concentrated between 0 and 40, variables with
% -200 value interfere with observation 


%data cleanning
%1 we will remove invalid data <0
benzene_cleaned = benzene(benzene >= 0);

%2 will examine data with histogram and increased number of bins
figure;
histogram(benzene_cleaned, 60, "FaceColor", "g", "EdgeColor", "black");
title("Histogram of Benzene");
xlabel("Concentration");
ylabel("Frequency");

% however, there is a noticeable presence of low-frequency bins in the higher 
% concentration range, which may indicate extreme values rather than outliers, 
% which we cannot remove 
% Meanwhile 60 are extremely rare, 
% appearing only in isolated bin, which emphasizes the long tail distribution of the data (further inspection needed, maybe it is connected somehow with the time of the measurments) 

%b) part
disp("\nSTATISTICS FOR BENZE COLUMN AFTER CLEANING: ");
medianBENZENE = median(benzene_cleaned);
meanBENZENE = mean(benzene_cleaned);
standardDev = std(benzene_cleaned);
variance = var(benzene_cleaned);
disp("MEDIAN: "+medianBENZENE);
disp("MEAN: "+meanBENZENE);
disp("std: "+standardDev);
disp("VARIANCE: "+variance)

%seven number summary
disp("SEVEN NUMBER SUMMARY: ");
percntile2 = prctile(benzene_cleaned, 2);
percentile9 = prctile(benzene_cleaned, 9);
percentile25 = prctile(benzene_cleaned, 25);
percentile50 = prctile(benzene_cleaned, 50);
percentile75 = prctile(benzene_cleaned, 75);
percentile91 = prctile(benzene_cleaned, 91);
percentile98 = prctile(benzene_cleaned, 98);
disp("2nd Percentile: " + percntile2);
disp("9th Percentile: " + percentile9);
disp("25th Percentile (Q1): " + percentile25);
disp("50th Percentile (Median): " + percentile50);
disp("75th Percentile (Q3): " + percentile75);
disp("91st Percentile: " + percentile91);
disp("98th Percentile: " + percentile98);

% calculate kurtosis and skewness to better describe the data
% distribution(will needed later)
skewnessValue = sum((benzene_cleaned - meanBENZENE).^3)/numel(benzene_cleaned)/(standardDev^3);
kurtosisValue = sum((benzene_cleaned - meanBENZENE).^4)/numel(benzene_cleaned)/(standardDev^4);

disp("SHAPE");
disp("Kurtosis: "+kurtosisValue);
disp("Skewness: "+skewnessValue);

% as we can see, the data has a long right tail and is assymetric(Skewness is 2.9428),
% moreover kurtosis is positive, meanning the data has many data around median and long tail

% build hist to see the new data spreading
figure;
histogram(benzene_cleaned, 20, "FaceColor", "g", "EdgeColor", "black");
title("Histogram of Benzene");
xlabel("Concentration");
ylabel("Frequency");

%LIST OF DISTRIBUTIONS TO CHECK:
% Normal - it`s not normal as it is assymmetric
% Bernoulli - no
% Binomial - no, do not have success/not 
% Poisson - no, variance does not equal to the E(x)
% Exponential - maybe, however has low values at the very beggining
% Gamma - looks like the most probable distribution for this data
% (visualy). The variance is significantly larger than the mean, aligns well 
% with a Gamma distribution and long right tail

%VERDICT - Gamma Distribution 

%с)
%retrieve data
dates = dat.Date;    
times = dat.Time;   
co = dat.CO; 
benzene = dat.C6H6;

% we get only rows where both measurments are not null 
validIdx = ~isnan(co) & ~isnan(benzene); 
co_valid = co(validIdx);
benzene_valid = benzene(validIdx);

figure;
scatter(co_valid, benzene_valid, "filled");
xlabel("CO Measurements");
ylabel("Benzene Measurements");
title("Scatter Plot of CO vs Benzene Measurements BEFORE REMOVAL");
grid on;

% after visualization inspection, we can observe that valid data is
% gathered, when (benzene>=0 and benzene<=65) and (CO>=0 and CO<=10),
% everything that beyond this range we call anomalies

% now we will retrieve such an anomalies 
anomalies_indices = (benzene < 0) | (co < 0 );

benzene_clean=benzene_valid(~anomalies_indices);
co_clean = co_valid(~anomalies_indices);

% now we will visualize cleaned data
figure;
scatter(co_clean, benzene_clean, "filled");
xlabel("CO Measurements");
ylabel("Benzene Measurements");
title("Scatter Plot of CO vs Benzene Measurements AFTER REMOVAL");
grid on;

% most of the dots are concentrated in a narrow region along the diagonal, 
% showing a clear correlation between CO and benzene
% There are a few points that are slightly away from the main data cloud 
% (e.g., at high benzene values with low CO values)
% These points could be outliers, but they need to be checked further.

%find rows corresponding to the anomalies indices
anomalies_dates = dates(anomalies_indices); 
anomalies_times = times(anomalies_indices); 
anomalies_benzene = benzene(anomalies_indices); 
anomalies_co = co(anomalies_indices); 
anomalies_datetime = datenum(anomalies_dates) + datenum(anomalies_times);

% we create a table to see the anomalies values
anomalies_table = table(anomalies_dates, anomalies_times, anomalies_benzene, anomalies_co,  ...
    'VariableNames', {'Date', 'Time','Benzene', 'CO'});

%display table of the date and time of anomalies
disp("Table of Date and Time of Anomalies:");
disp(anomalies_table);

%after creating a table, we can clearly see, that in each invalid
%measurment either benzene concentration or co concentration gets an
%extreme value of -200, it is an error of the sensor or instrument. So, we
%did it right, when we did not remove "outliers" at the very beginning
anomalies_times = times(anomalies_indices); 
disp(anomalies_times);