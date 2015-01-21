function [plate, boxed] = getPlate( frame )

mask = getMask(frame);

% get the connected components (cc)
cc = bwconncomp(mask);

% get some properties of the blobs
props = regionprops(cc, {'BoundingBox','PixelIdxList','Orientation'});
numberOfBlobs = size(props, 1);
maxIntensity = 0; % keep track of the maximum Intensity
thisIsAPlate = 1; % select the first blob by default, when no other index is found

for k = 1 : numberOfBlobs
    box = props(k).BoundingBox;
    % check if box is greater than 89 pixels (min width should be 100px,
    % but when we rotate we can't recognize the smallest plates)
    if box(3) > 89
        % if the angle is bigger than 40 degrees it can't be a license
        % plate
        if props(k).Orientation < 40 && props(k).Orientation > -40
            ratio = box(4)/box(3);
            if ratio < 1 && ratio > 0.1
                % Find the mean of each blob.  
                thisBlobsPixels = props(k).PixelIdxList;  % Get list of pixels in current blob.
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
bounding = props(thisIsAPlate).BoundingBox;
angle = props(thisIsAPlate).Orientation;
% only adjust angle when it's greater than 5 degrees
if angle > -5 && angle < 5
    plate = imcrop(frame, bounding);
else
    plate = imrotate(imcrop(frame, bounding), -angle);
end
% return an image with the license plate marked with a rectangle
boxed = insertShape(frame, 'Rectangle', bounding, 'Color','g','LineWidth',3);
end

