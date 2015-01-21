function [plate, boxed] = getPlate( frame )
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

 
% get the connected components (cc)
cc = bwconncomp(mask);

% get the binary images (logical) with the same size as the boundingbox
props = regionprops(cc, 'BoundingBox');
% create an empty matrix
ratio = zeros(1, cc.NumObjects);
% for every connected component
for i = 1:cc.NumObjects
      boundbox = props(i).BoundingBox;
      ratio(i) = boundbox(4)/boundbox(3);
end


numberOfBlobs = size(props, 1);
maxIntensity = 0;
bestBlobIntensity = 0;
props2 = regionprops(cc, 'PixelIdxList');
for k = 1 : numberOfBlobs           % Loop through all blobs.
	
    if ratio(k) < 1 && ratio(k) > 0.1
    
    % Find the mean of each blob.  
	% directly into regionprops.  The way below works for all versions including earlier versions.)
    thisBlobsPixels = props2(k).PixelIdxList;  % Get list of pixels in current blob.
    meanGL = mean(frame(thisBlobsPixels)); % Find mean intensity (in original image!)
	
    
    
    %Needed to calculate the blob with the maximum mean intensity etc
    if meanGL > maxIntensity
        maxIntensity = meanGL;
        bestBlobIntensity = k;
    end
%     if bestRatio > blobRatio - 0.25
%        bestRatio = blobRatio - 0.25; 
%        bestBlobRatio = k;
%     end

    end
end
bounding = props(bestBlobIntensity).BoundingBox; 
plate = imcrop(frame, bounding);
boxed = insertShape(frame, 'Rectangle', bounding, 'Color','r','LineWidth',3);
end

