function [plate, boxed] = getPlate( frame )

mask = getMask(frame);

% get the connected components (cc)
cc = bwconncomp(mask);

% get the binary images (logical) with the same size as the boundingbox
boxes = regionprops(cc, 'BoundingBox');
numberOfBlobs = size(boxes, 1);
maxIntensity = 50;
thisIsAPlate = 1; % select the first blob by default, when no other index is found
props2 = regionprops(cc, 'PixelIdxList');
angles = regionprops(cc, 'Orientation');
for k = 1 : numberOfBlobs           % Loop through all blobs.
    box = boxes(k).BoundingBox;
    % check if box is greater than 100 pixels
    if box(3) > 100
        if angles(k).Orientation < 40 && angles(k).Orientation > -40
            ratio = box(4)/box(3);
            if ratio < 1 && ratio > 0.1
                % Find the mean of each blob.  
                thisBlobsPixels = props2(k).PixelIdxList;  % Get list of pixels in current blob.
                meanGL = mean(frame(thisBlobsPixels)); % Find mean intensity (in original image!)
                % Needed to calculate the blob with the maximum mean intensity etc
                if meanGL > maxIntensity
                    maxIntensity = meanGL;
                    thisIsAPlate = k;
                end
            end
        end
    end
end
angle = angles(thisIsAPlate).Orientation;
bounding = boxes(thisIsAPlate).BoundingBox;
plate = imrotate(imcrop(frame, bounding), -angle);
boxed = insertShape(frame, 'Rectangle', bounding, 'Color','g','LineWidth',3);
end

