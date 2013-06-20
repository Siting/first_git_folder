function[ACCEPTED_POP] = extractSelectedSamples(indexCollection, ACCEPTED_POP)

linkIDs = ACCEPTED_POP.keys;

for i = 1 : length(linkIDs)
    sampleInfo = ACCEPTED_POP(linkIDs{i});
    sampleInfo.samples = sampleInfo.samples(:,indexCollection);
    ACCEPTED_POP(linkIDs{i}) = sampleInfo;
end