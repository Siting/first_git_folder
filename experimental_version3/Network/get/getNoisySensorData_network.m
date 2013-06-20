function[sensorDataMatrix] = getNoisySensorData_network(tSensorIDs)

global startTime
global endTime

for i = 1 : length(tSensorIDs)
    sensorID = tSensorIDs(i);
    load(['.\SensorData\' num2str(sensorID) '.mat']);
    
    % load data from startTime to endTime
    startCell = ceil((startTime*60)/5 + 1);
    endCell = floor((endTime*60)/5 + 1);
    flowDataSum = flowDataSum(startCell:endCell,1);
    
    sensorDataMatrix(:,i) = flowDataSum;
end