function [ output ] = CharRecogn( inputImage )
%PATTERNREC Recognizes what character is in the input image
%   Detailed explanation goes here

file = load('patternCounts');
pixcount2 = file.pixcount2;
charnames = file.charnames;

%   fileList = dir('resources/Patterns/*.png');
%  patternList = cell(1,length(fileList));
%      for K = 1:length(fileList)
%         patternList{K} = imresize(imread(['resources/Patterns/', fileList(K).name]), [75, 75]);
%      end
     
%Resize the input image to be the size of the characterimages
 inputImage=imresize(inputImage,[75,75]);
 pixcount = zeros(5,5);
 pixsum = 0;
 %Count the amount of 1 pixels of the inputimage
 for i = 1:5
     for r = 1:5
         pixcount(i,r) = sum(sum(inputImage((i-1)*15+1:i*15,(r-1)*15+1:r*15)));
         pixsum = pixsum + pixcount(i,r)^2;
     end
 end
 
%  pixcount2 = zeros(5,5,length(fileList));
%  %Count the amount of 1 pixels of the character image
%  for i = 1:5
%      for r = 1:5
%          for K = 1:length(fileList)
%              pixcount2(i,r,K) = sum(sum(patternList{K}((i-1)*15+1:i*15,(r-1)*15+1:r*15)));
%          end
%      end
%  end
 
 difference = zeros(5,5,29);
  for i = 1:5
     for r = 1:5
         for K = 1:29
              difference(i,r,K) = abs(pixcount(i,r)-pixcount2(i,r,K))^2;
         end
     end
  end
  
  difference2 = zeros(1,29);
  for K = 1:29
        difference2(K) = sum(sum(difference(:,:,K)));
  end
  
  [sortedValues, sortedIndexes] = sort(difference2,'ascend');
  
  output = zeros(3,2);
  if sortedIndexes(1) == 22 || sortedIndexes(1) == 15
      
  end
 %Give back the 3 most likely chars + the likelyhood
 for k = 1:3
     output(k,1) = charnames(sortedIndexes(k));
     output(k,2) = 1-sortedValues(k)/pixsum;
 end

end

