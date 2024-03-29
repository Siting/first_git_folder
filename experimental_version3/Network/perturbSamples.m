function[POPULATION_1] = perturbSamples(POPULATION_1)

global perturbationFactor

para_cov = 0;

linkIDs = POPULATION_1.keys;

for i = 1 : length(linkIDs)
    sampleInfo = POPULATION_1(linkIDs{i});
    priorPopulation = sampleInfo.samples;
    % mean & var
    meanValue = zeros(size(priorPopulation,1),1);
    vmax_std = perturbationFactor * var(priorPopulation(1,:));
    dmax_std = 0.01 * perturbationFactor * var(priorPopulation(2,:));
    dc_std = 0.1 * perturbationFactor * var(priorPopulation(3,:));
    covMatrix = [vmax_std^2, para_cov para_cov;
        para_cov, dmax_std^2 para_cov;
        para_cov para_cov dc_std^2];
    % sample noise and add to old samples
    j = 1;
    postPopulation = [];
    while j <= size(priorPopulation, 2)
        
        noise = mvnrnd(meanValue,covMatrix)';
        priorPop = priorPopulation(:,j);
        postPop = priorPop + noise;
        
        % check the new sample
        if postPop(1)>0 && postPop(2)>0 && postPop(3)>0 && postPop(2)>postPop(3) &&...
                postPop(1)<=100 && postPop(2) <= (max(priorPopulation(2,:))+1) && postPop(2) >= (min(priorPopulation(2,:))-1) &&...
                postPop(3) <= (max(priorPopulation(3,:)) + 1) && postPop(3) >= (min(priorPopulation(3,:)) -1) &&...
                postPop(1) <= (max(priorPopulation(1,:)) + 1) && postPop(1) >= (min(priorPopulation(1,:)) -1)
            postPopulation = [postPopulation postPop];
            j = j + 1;
        end
        
    end
    
    sampleInfo.samples = postPopulation;
    POPULATION_1(linkIDs{i}) = sampleInfo;
end


