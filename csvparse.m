clc;
clear;

% Get data for each video.

[id, commentCount, dislikeCount, favoriteCount, likeCount, viewCount, funnyWordsInTitle, funnyWordsInDesc] = textread('download.dat', '%s %d %d %d %d %d %d %d');
inputs = [commentCount, dislikeCount, favoriteCount, likeCount, viewCount, funnyWordsInTitle, funnyWordsInDesc];

% Convert data to a form that we can use in a map (a single cell containing
% a matrix, for each id).

length = size(inputs);
values = cell(length(1), 1);
for i = 1:size(values)
    values(i) = {[inputs(i, 1), inputs(i, 2), inputs(i, 3), inputs(i, 4), inputs(i, 5), inputs(i, 6), inputs(i, 7)]};
end

%values(end + 1) = {[5, 5, 5, 5, 5, 5, 5]};
%id{end + 1} = 'sNabaB-eb3Y';

videos = containers.Map(id, values);

% Get comparison data.

[left, right, winner] = textread('comedy_comparisons.train.space', '%s %s %s');

% Convert comparison data into uniquely identifying data so we can compare
% directly.

length = size(left);
finalInputData = zeros(length(1), 14);
for i = 1:videos.length
    %if videos.isKey(left{i}) || videos.isKey(right{i})
    %    disp('found!'); 
    %end
    
    if videos.isKey(left{i}) && videos.isKey(right{i})
        leftData = videos(left{i});
        rightData = videos(right{i});
        finalInputData(i) = [leftData(1)'; rightData(1)'];
    end
end