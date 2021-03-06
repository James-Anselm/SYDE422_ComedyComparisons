length = size(prunedFunnyInput);

prunedFunnyTargetComb = zeros(length(1), 1);

for i = 1:length(1)
    if prunedFunnyTarget(i, 1) == 1
        prunedFunnyTargetComb(i) = 0;
    else
        prunedFunnyTargetComb(i) = 1;
    end
end

funnyInputTrain = prunedFunnyInput(1:375000, :);
funnyTargetTrain = prunedFunnyTargetComb(1:375000, :);
funnyInputTest = prunedFunnyInput(375001:end, :);
funnyTargetTest = prunedFunnyTargetComb(375001:end, :);    

t = classregtree(funnyInputTrain, funnyTargetTrain, 'method', 'classification');

funnyTargetTestResult = eval(t, funnyInputTest);
funnyTargetTestResultInt = cellfun(@str2num, cellstr(funnyTargetTestResult));
mean(funnyTargetTestResultInt ~= funnyTargetTest)