% This file is for testing network case
clear all
clc

profile on

dbstop if error

global map
global numStages
global arForEveryRound
global thresholdVector
global ABC_selection_type
global perturbationFactor
global boundarySourceSensorIDs
global boundarySinkSensorIDs
global testingSensorIDs
global funsOption
global startTime
global endTime
global sensorDataSource


% name the index of configuration(s) 
configID = [41];

% start & end time
startTime = 8;
endTime = 8.5;   % 0.5 = 30 mins

% boundary sensorIDs & testing sensorIDs
boundarySourceSensorIDs = [400468; 402955; 402954; 402950];
boundarySinkSensorIDs = [402953; 400698];
testingSensorIDs = [400739; 400363];
funsOption = 2;    % 1: uniform,  2:non-uniform
sensorDataSource = 2;  % 2: from real sensor data

ABC_selection_type = 2;

% 1: excel, 2: mat
map = 2;

% 1: set AR, 2: set thresholds
if ABC_selection_type == 1
    numStages = 10;
    arForEveryRound = 0.5;
elseif ABC_selection_type == 2
    thresholdVector = [30 35; 25 27; 22 24];
    perturbationFactor = 0.1;
    numStages = size(thresholdVector,2);
end


for i = 1 : length(configID)
    configuration_setting(configID);
    disp(['i = ' num2str(i)]);
    runConfigTest(configID(i), i);
end

profile viewer