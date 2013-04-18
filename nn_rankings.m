length = size(funnyInput);

prunedFunnyInputRankings = zeros(length(1), 2);

for i = 1:length(1)
    prunedFunnyInputRankings(i, 1) = rankings(prunedFunnyIds{i}{1});
    prunedFunnyInputRankings(i, 2) = rankings(prunedFunnyIds{i}{2});
end