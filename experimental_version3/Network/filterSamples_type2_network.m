function[ACCEPTED_POP, rejectedPop, indexCollectionPost, filteredWeights] = filterSamples_type2_network(POPULATION_2, indexCollection_1, oldWeights,...
    configID, measConfigID, stage, sensorDataMatrix, tSensorIDs, linkMap, nodeMap, sensorMetaDataMap)

% NOTE: there are two kind of indexes involved in the function.
% 1st: sample index. Which is the index indicating which sample being
% selected from the previous population.
% 2nd: population index. In order to avoid the chaos caused by repeated
% selection samples (e.g. sampel 2 being selected 3 times), we save the
% simulation result of each sample based on their order in the selected
% population(i.e. 1,2,3,4,5...).

global thresholdVector
global junctionIndex

criteria = thresholdVector(junctionIndex, stage);

[ACCEPTED_POP, NEW_REJECTED_POP] = initializeAcceptedRejected(linkMap);
rejectedPop = [];
indexCollectionPost = [];       % index of the sample which is kept
filteredWeights = [];           % weights of the samples which are kept
sensorSelection = [];
for sample = 1 : length(oldWeights)
    
%     % get sample vector
%     s = priorPop(:, sample);
    
    % extract sample info
    index = indexCollection_1(sample);
    w = oldWeights(sample);

    % load model density simulation data (first row = initial state)
    [modelDataMatrix] = getModelSimulationData_network(configID, sample, tSensorIDs);
    
    if any(modelDataMatrix < 0)
        keyboard
    end
    
    % create error matrix (density)
    errorMatrix = generateErrorMatrixTest_network(modelDataMatrix, sensorDataMatrix, tSensorIDs);

    % reject or select?
    [choice, sensorSelection] = rejectAccept_network(errorMatrix, criteria, nodeMap, sensorMetaDataMap, linkMap, stage, sensorSelection);
    
    % store in population matrix
    if strcmp(choice, 'accept')
        ACCEPTED_POP = saveSample(ACCEPTED_POP, sample, POPULATION_2);
        indexCollectionPost = [indexCollectionPost index];
        filteredWeights = [filteredWeights w];
    end
    
    if mod(sample, 80) == 0
        disp(['sample ' num2str(sample) ' filtering finished']);
    end
    
end