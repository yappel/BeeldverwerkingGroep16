function [ charlist ] = CharSegmentation( inputImage )
%CHARSEGMENTATION segmentates 6 characters out of the input image
%   Detailed explanation goes here
charlist = cell(1,6);
grayImg = rgb2gray(inputImage);
bw = im2bw(grayImg, graythresh(grayImg));
bw = imcomplement(bw);
bw = imclose(bw,strel('disk',3));
cc = bwconncomp(bw);
prop = regionprops(cc, 'Image');
sizes = zeros(1,cc.NumObjects);
for i = 1:cc.NumObjects
    tempsize = size(prop(i).Image);
    sizes(i) = tempsize(1);
end
[sortedValues, sortedIndexes] = sort(sizes,'descend');
sortedIndexesSorted = sort(sortedIndexes(1:6), 'ascend');
for i = 1:6
    charlist{i} = prop(sortedIndexesSorted(i)).Image;
    figure(i)
    image(charlist{i})
end
end

