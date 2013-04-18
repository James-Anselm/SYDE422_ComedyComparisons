funnyInputTrain = funnyInput(1:500000, :);
funnyTargetTrain = funnyTarget(1:500000, :);
funnyInputTest = funnyInput(500001:end, :);
funnyTargetTest = funnyTarget(500001:end, :);

t = classregtree(funnyInputTrain, funnyTargetTrain, 'method', 'classification');

funnyTargetTestResult = eval(t, funnyInputTest);
funnyTargetTestResultInt = cellfun(@str2num, cellstr(funnyTargetTestResult));
mean(funnyTargetTestResultInt ~= funnyTargetTest)