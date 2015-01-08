function [ data2 ] = thresholdFilter( frame )
%THRESHOLDFILTER Summary of this function goes here
%   Detailed explanation goes here
hsidata = rgb2hsv(frame);
mask1 = frame(:,:,2) <= 1.08 .* frame(:,:,1) + 5.6;
mask2 = frame(:,:,2) >= 0.48 .* frame(:,:,1) - 4.1;
mask3 = frame(:,:,3) <= 0.68 .* frame(:,:,2) + 4.18;
mask4 = hsidata(:,:,1) < 0.25;
mask =  mask1 .* mask2 .* mask3 .* mask4;
SE = strel('square',5);
SE2 = strel('square',20);
mask = imopen(mask,SE);
mask = imclose(mask,SE2);
SE2= strel('square',30);
mask = imopen(mask,SE2);
data2(:,:,1) = uint8(mask) .* frame(:,:,1);
data2(:,:,2) = uint8(mask) .* frame(:,:,2);
data2(:,:,3) = uint8(mask) .* frame(:,:,3);

end

 