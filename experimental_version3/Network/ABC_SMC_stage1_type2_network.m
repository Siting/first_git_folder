function[ACCEPTED_POP, REJECTED_POP, indexCollection] = ABC_SMC_stage1_type2_network(measConfigID, configID, samplingSize, ALL_SAMPLES,...
    populationSize, times, ACCEPTED_POP, REJECTED_POP, indexCollection, tSensorIDs, sensorDataMatrix, nodeMap, sensorMetaDataMap, linkMap,...
    stage)

global thresholdVector
global junctionIndex

criteria = thresholdVector(junctionIndex, 1);

% start model parameter calibration
sensorSelection = [];
for sample = ((times-1)*samplingSize + 1) : (times * samplingSize)
    
    % load model density simulation data (first row = initial state)
    [modelDataMatrix] = getModelSimulationData_network(configID, sample, tSensorIDs);

    % create error matrix (density)
    errorMatrix = generateErrorMatrixTest_network(modelDataMatrix, sensorDataMatrix, tSensorIDs);

    % reject or select?
    [choice, sensorSelection] = rejectAccept_network(errorMatrix, criteria, nodeMap, sensorMetaDataMap, linkMap, stage, sensorSelection);

    % store in population matrix
    if strcmp(choice, 'accept')
        ACCEPTED_POP = saveSample(ACCEPTED_POP, sample, ALL_SAMPLES);
        indexCollection = [indexCollection, sample];
    elseif strcmp(choice, 'reject')
        REJECTED_POP = saveSample(REJECTED_POP, sample, ALL_SAMPLES);
    else
        disp('There is an error occurs when making choices.');
    end
    
%     if mod(sample, 100) == 0
%         disp(['sample ' num2str(sample) ' finished']);
%     end
    
end

%============
% sensorSelection = sum(sensorSelection);
% ar1 = sensorSelection(1) / samplingSize;
% ar2 = sensorSelection(2) / samplingSize;
% keyboard
