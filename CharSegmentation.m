function [ charlist ] = CharSegmentation( inputImage )
%CHARSEGMENTATION segmentates 6 characters out of the input image
%   Detailed explanation goes here

% figure(100)
% image(inputImage)

%Create the list containing the images of the characters
charlist = cell(1,6);

%Convert the image to a grey-value image
grayImg = rgb2gray(inputImage);
%Apply treshholding
bw = im2bw(grayImg, graythresh(grayImg));
%Invert the binary image
bw = imcomplement(bw);

%Label all the differnt objects
cc = bwconncomp(bw);
%Create an image for every labeled object
prop = regionprops(cc, 'Image');

%Create a list of all heights of the labeled images
sizes = zeros(1,cc.NumObjects);
for i = 1:cc.NumObjects
    tempsize = size(prop(i).Image);
    sizes(i) = tempsize(1);
end

%Sorted the heights
[sortedValues, sortedIndexes] = sort(sizes,'descend');

%Only take the 6 biggest images (this removes the -) and sort the indexes back
%to the right order
sortedIndexesSorted = sort(sortedIndexes(1:6), 'ascend');

%Get the 6 images of the characters and put them into the list
for i = 1:6
    charlist{i} = prop(sortedIndexesSorted(i)).Image;
%      figure(i)
%      image(imresize(charlist{i},[75,75]))
%      result = PatternRec(charlist{i});
%      name = result.name(1);
%      title(name);
end
end

