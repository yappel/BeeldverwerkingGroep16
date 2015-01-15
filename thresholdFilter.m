function [ data2] = thresholdFilter( frame )
hold on;
% imshow(frame), axis square;
frame(:,:,1) = medfilt2(frame(:,:,1),[3 3]);
frame(:,:,2) = medfilt2(frame(:,:,2),[3 3]);
frame(:,:,3) = medfilt2(frame(:,:,3),[3 3]);
hsidata = rgb2hsv(frame);
mask1 = frame(:,:,2) <= 1.08 .* frame(:,:,1) + 5.6;
mask2 = frame(:,:,2) >= 0.48 .* frame(:,:,1) - 4.1;
mask3 = frame(:,:,3) <= 0.68 .* frame(:,:,1) - 4.18;
mask5 = frame(:,:,3) <= 0.68 .* frame(:,:,2) - 4.18;
mask4 = hsidata(:,:,1) < 0.18;
mask =  mask1 .* mask2 .* mask3 .* mask4 .* mask5;

SE = strel('disk',10);
SE2 = strel('square',3);


 mask = imclose(mask,strel('disk',5));
 maskoud = mask;
% mask = imdilate(mask,SE2);
 mask = imopen(mask,SE);
 
 mask = imdilate(mask,strel('disk',10));
 mask = mask .* maskoud;
 mask = imopen(mask,strel('square',3));
 
 data2(:,:,1) = uint8(mask) .* frame(:,:,1);
data2(:,:,2) = uint8(mask) .* frame(:,:,2);
data2(:,:,3) = uint8(mask) .* frame(:,:,3);

imshow(data2), axis square;
 
 
%imshow(mask), axis square;

% get the connected components (cc)
cc = bwconncomp(mask);
% get the binary images (logical) with the same size as the boundingbox
props = regionprops(cc, 'all');
% create an empty matrix
ratio = zeros(1, cc.NumObjects);
% for every connected component
for i = 1:cc.NumObjects
    % get the total size of this cc
    totalsize = size(props(i).Image);
    % get the ratio width/heigth of this cc
    ratio(i) = totalsize(1)/totalsize(2) - 0.2400;
end
% get the index I of the cc with the smallest ratio
[M,I] = min(ratio);
% create an empty mask with the size of the original frame
%mask = zeros(size(frame(:,:,1)));

numberOfBlobs = size(props, 1);
blobECD = zeros(1, numberOfBlobs);
% Print header line in the command window. Which of these parameters can we
% use to select the correct blobs?
fprintf(1,'Blob #      Mean Intensity  Area   Perimeter    Centroid       Diameter   x       y    Ratio       Angle\n');
% Loop over all blobs printing their measurements to the command window.
maxIntensity = 0;
bestBlobIntensity = 0;
bestBlobRatio = 0;
bestRatio = 1000;
for k = 1 : numberOfBlobs           % Loop through all blobs.
	% Find the mean of each blob.  
	% directly into regionprops.  The way below works for all versions including earlier versions.)
    thisBlobsPixels = props(k).PixelIdxList;  % Get list of pixels in current blob.
    meanGL = mean(frame(thisBlobsPixels)); % Find mean intensity (in original image!)
	
	blobArea = props(k).Area;		% Get area.
	blobPerimeter = props(k).Perimeter;		% Get perimeter.
	blobCentroid = props(k).Centroid;		% Get centroid.
	blobECD(k) = sqrt(4 * blobArea / pi);					% Compute ECD - Equivalent Circular Diameter.
    bounding = props(k).BoundingBox;
    extrema = props(k).Extrema;
    top_left = [floor(extrema(1,2)) floor(extrema(1,1))];
    top_right = [floor(extrema(2,2)) floor(extrema(2,1))];
    right_top = [floor(extrema(3,2)) floor(extrema(3,1))];
    right_bottom = [floor(extrema(4,2)) floor(extrema(4,1))];
    bottom_right = [floor(extrema(5,2)) floor(extrema(5,1))];
    bottom_left = [floor(extrema(6,2)) floor(extrema(6,1))];
    left_bottom = [floor(extrema(7,2)) floor(extrema(7,1))]; 
    left_top = [floor(extrema(8,2)) floor(extrema(8,1))];
    
    x_init = floor(bounding(2));
    y_init = floor(bounding(1));
    x_width = floor(bounding(4));
    y_width = floor(bounding(3));
    blobRatio = x_width/y_width;
    % max angle is +/-40 degree
    angle = props(k).Orientation;
    %draw a boundingbox around each blob
    rectangle('Position', [bounding(1),bounding(2),bounding(3),bounding(4)],...
    'EdgeColor','r','LineWidth',2 )
    fprintf(1,'#%2d %17.3f %11.3f %8.3f %8.3f %8.3f % 8.3f % 8.3f % 8.3f % 8.3f % .3f\n', k, meanGL, blobArea, blobPerimeter, blobCentroid, blobECD(k), x_width, y_width, blobRatio, angle);
	% Put the "blob number" labels on the "boundaries" grayscale image.
	text(blobCentroid(1) - 7, blobCentroid(2), num2str(k), 'FontSize', 14, 'FontWeight', 'Bold', 'Color','w');
    
    
    %Needed to calculate the blob with the maximum mean intensity etc
    if meanGL > maxIntensity
        maxIntensity = meanGL;
        bestBlobIntensity = k;
    end
    if bestRatio > blobRatio - 0.25
       bestRatio = blobRatio - 0.25; 
       bestBlobRatio = k;
    end
end

bestBlobIntensity
bestBlobRatio

%TODO: create mask for the original frame and display it
% 1. we have an empty mask with the size of the original frame
% 2. find the location of the boundingbox in the original frame
% 3. add 1's on the location of the boundingbox
% 4. apply the created mask on the orignal frame
% 5. result is only the segmented license plate

% in the original image, go from the startpoint of the boundingbox to the
% endpoint


% for i = x_init:x_init+x_width
%     for i2 = y_init:y_init+y_width
%         mask(i,i2) = 1;
%     end
% end



%data2 = rgb2gray(data2);
 %data2 = medfilt2(data2,[3 3]);
%data2 = imsharpen(data2);
%data2 = edge(hsidata(:,:,3), 'sobel');
%  SE3 = strel('square', 2);
%  data2 = imdilate(data2,SE3);
%  data2 = imerode(data2,SE3);
% 
%  data2 = imfill(data2, 'holes');
end

 