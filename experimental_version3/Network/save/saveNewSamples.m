function[NEW_ACCEPTED_POP] = saveNewSamples(NEW_ACCEPTED_POP, POPULATION_3)

linkIDs = POPULATION_3.keys;

for i = 1 : length(linkIDs)
    newSampleInfo = NEW_ACCEPTED_POP(linkIDs{i});
    sampleInfo = POPULATION_3(linkIDs{i});
    newSampleInfo.samples = [newSampleInfo.samples sampleInfo.samples];
    NEW_ACCEPTED_POP(linkIDs{i}) = newSampleInfo;
end