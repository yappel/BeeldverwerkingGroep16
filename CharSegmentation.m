function [ charlist, id ] = CharSegmentation( inputImage )
%CHARSEGMENTATION segmentates 6 characters out of the input image
%   Detailed explanation goes here

% figure(100)
% image(inputImage)

%Create the list containing the images of the characters
charlist = cell(1,6);





%Convert the image to a grey-value image
grayImg = rgb2gray(imsharpen(imsharpen(inputImage)));
%Apply treshholding
bw = im2bw(grayImg, graythresh(grayImg));

%Invert the binary image
bwinv = imcomplement(bw);

bwinv = imclearborder(bwinv);

%Label all the differnt objects
cc = bwconncomp(bwinv);
%Create an image for every labeled object
prop = regionprops(cc, 'Image');
prop2 = regionprops(cc, 'BoundingBox');


if cc.NumObjects > 5
    


%Create a list of all heights of the labeled images
sizes = zeros(1,cc.NumObjects);
    
for i = 1:cc.NumObjects
   
    
%     figure(i)
%     image(prop(i). Image);

    tempsize = size(prop(i).Image);
    imgsize = size(inputImage);
    sizes(i) = tempsize(1);
    
    if tempsize(1) > .9 * imgsize(1)
        sizes(i) = 0;
    elseif tempsize(2) > .25 * imgsize(2)
        sizes(i) = 0;
    elseif tempsize(2) < 5
        sizes(i) = 0;
    end
end

%Sorted the heights
[sortedValues, sortedIndexes] = sort(sizes,'descend');

%Only take the 6 biggest images (this removes the -) and sort the indexes back
%to the right order

    
sortedIndexesSorted = sort(sortedIndexes(1:6), 'ascend');



topright = zeros(6,1);
topleft = zeros(6,1);
%Get the 6 images of the characters and put them into the list
for i = 1:6
    charlist{i} = prop(sortedIndexesSorted(i)).Image;
    boundingbox = prop2(sortedIndexesSorted(i)).BoundingBox;
    topright(i) = boundingbox(1)+boundingbox(3);
    topleft(i) = boundingbox(1);
end
xspace = zeros(5,1);
for i = 1:5
   xspace(i)=topleft(i+1)-topright(i); 
end
%Get the 2 bigges spaces
[sortedValues, sortedIndexes] = sort(xspace,'descend');
id = sortedIndexes(1) + sortedIndexes(2);

else
    charlist = [];
    id= 0;
end

end


