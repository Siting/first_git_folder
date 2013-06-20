function[ACCEPTED_POP] = trimExessiveSamples(ACCEPTED_POP,populationSize)

linkIDs = ACCEPTED_POP.keys;

for i = 1 : length(linkIDs)
    samplesInfo = ACCEPTED_POP(linkIDs{i});
    samplesInfo.samples = samplesInfo.samples(:,1 : populationSize);
    ACCEPTED_POP(linkIDs{i}) = samplesInfo;
end