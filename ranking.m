length = size(inputs);

highestCommentCount = max(funnyInput(:,1));
highestDislikeCount = max(funnyInput(:,2));
highestFavoriteCount = max(funnyInput(:,3));
highestLikeCount = max(funnyInput(:,4));
highestViewCount = max(funnyInput(:,5));
highestFunnyWordsInTitle = max(funnyInput(:,6));
highestFunnyWordsInDesc = max(funnyInput(:,7));

rankingValues = cell(length(1), 1);

for i = 1:length(1)
    rankingValues{i} = inputs(i, 1) / highestCommentCount - ...
                       3 * inputs(i, 2) / highestDislikeCount + ...
                       3 * inputs(i, 4) / highestLikeCount + ...
                       inputs(i, 5) / highestViewCount + ...
                       2 * inputs(i, 6) / highestFunnyWordsInTitle + ...
                       inputs(i, 7) / highestFunnyWordsInDesc;
end

rankings = containers.Map(id, rankingValues);

length = size(funnyInput);

prunedFunnyInput = zeros(length(1), 14);
prunedFunnyTarget = zeros(length(1), 2);
prunedFunnyIds = cell(length(1), 1);
prunedPos = 1;

for i = 1:length(1)
    if funnyTarget(i, 1) == 1 && rankings(funnyIds{i}{1}) < rankings(funnyIds{i}{2})
        
    else
        prunedFunnyInput(prunedPos,:) = funnyInput(i,:);
        prunedFunnyTarget(prunedPos,:) = funnyTarget(i,:);
        prunedFunnyIds{prunedPos} = funnyIds{i};
        prunedPos = prunedPos + 1;
    end
end

prunedFunnyInput = prunedFunnyInput(1:(prunedPos - 1),:);
prunedFunnyTarget = prunedFunnyTarget(1:(prunedPos - 1),:);
prunedFunnyIds = prunedFunnyIds(1:(prunedPos - 1),:);