function[ACCEPTED_POP] = saveSample(ACCEPTED_POP, sample, ALL_SAMPLES)

linkIDs = ALL_SAMPLES.keys;

for i = 1 : length(linkIDs)
    sampleOfLink = ALL_SAMPLES(linkIDs{i}).samples(:,sample);
    linkSamples = ACCEPTED_POP(linkIDs{i});
    linkSamples.samples = [linkSamples.samples sampleOfLink];
    ACCEPTED_POP(linkIDs{i}) = linkSamples;
end