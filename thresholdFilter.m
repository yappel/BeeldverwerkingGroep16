function [ data2 ] = thresholdFilter( frame )
%THRESHOLDFILTER Summary of this function goes here
%   Detailed explanation goes here
hsidata = rgb2hsv(frame);
mask1 = frame(:,:,2) <= 0.9 .* frame(:,:,1) + 22;
mask2 = frame(:,:,2) >= 0.9 .* frame(:,:,1) - 70;
mask3 = frame(:,:,3) <= 0.9 .* frame(:,:,2) -10;
mask4 = hsidata(:,:,1) < 0.22;
mask =  mask1 .* mask2 .* mask3 .* mask4;
data2(:,:,1) = uint8(mask) .* frame(:,:,1);
data2(:,:,2) = uint8(mask) .* frame(:,:,2);
data2(:,:,3) = uint8(mask) .* frame(:,:,3);

end

