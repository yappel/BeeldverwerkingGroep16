function [ data2] = thresholdFilter( frame )
%THRESHOLDFILTER Summary of this function goes here
%   Detailed explanation goes here
frame(:,:,1) = medfilt2(frame(:,:,1),[3 3]);
frame(:,:,2) = medfilt2(frame(:,:,2),[3 3]);
frame(:,:,3) = medfilt2(frame(:,:,3),[3 3]);
hsidata = rgb2hsv(frame);
mask1 = frame(:,:,2) <= 1.08 .* frame(:,:,1) + 5.6;
mask2 = frame(:,:,2) >= 0.48 .* frame(:,:,1) - 4.1;
mask3 = frame(:,:,3) <= 0.68 .* frame(:,:,2) + 4.18;

mask4 = hsidata(:,:,1) < 0.25;
mask =  mask1 .* mask2 .* mask3 .* mask4;
SE = strel('disk',15);
SE2 = strel('square',3);
% mask = imclose(mask,strel('disk',5));
mask = imdilate(mask,SE2);
mask = imopen(mask,SE);

cc = bwconncomp(mask);
prop = regionprops(cc, 'Image');
ratio = zeros(1, cc.NumObjects);
for i = 1:cc.NumObjects
    totalsize = size(prop(i).Image);
    ratio(i) = totalsize(1)/totalsize(2) - 0.2400;
end
[M,I] = min(ratio);
prop2 = regionprops(cc, 'BoundingBox')
mask = zeros(size(frame(:,:,1)));;
prop2 = prop2(I).BoundingBox
for i = floor(prop2(1)):floor(prop2(1))+floor(prop2(3))
    for i2 = floor(prop2(2)):floor(prop2(2))+floor(prop2(4))
        mask(i,i2) = 1;
    end
end
size(mask);


data2(:,:,1) = uint8(mask) .* frame(:,:,1);
data2(:,:,2) = uint8(mask) .* frame(:,:,2);
data2(:,:,3) = uint8(mask) .* frame(:,:,3);

data2 = rgb2gray(data2);
% data2 = medfilt2(data2,[3 3]);
% data2= edge(data2, 'sobel');
% SE3 = strel('square', 2);
% data2 = imdilate(data2,SE3);
% data2 = imerode(data2,SE3);

% data2 = imfill(data2, 'holes');
end

 