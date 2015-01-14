function [ output ] = PatternRec( inputImage )
%PATTERNREC Recognizes what character is in the input image
%   Detailed explanation goes here
 fileList = dir('resources/Patterns/*.png');
 patternList = cell(1,length(fileList));
     for K = 1:length(fileList)
        patternList{K} = imresize(imread(['resources/Patterns/', fileList(K).name]), [75, 75]);
     end
     
%       for K = 1:length(fileList)
%         difference(K) = sum(sum(imresize(patternList{K}, [75, 75]) - imresize(inputImage, [75, 75])));
%      end
%  [m,index] = min(abs(difference));
 inputImage=imresize(inputImage,[75,75]);
 pixcount = zeros(5,5);
 for i = 1:5
     for r = 1:5
         pixcount(i,r) = sum(sum(inputImage((i-1)*15+1:i*15,(r-1)*15+1:r*15)));
     end
 end
 
 pixcount2 = zeros(5,5,length(fileList));
 for i = 1:5
     for r = 1:5
         for K = 1:length(fileList)
             pixcount2(i,r,K) = sum(sum(patternList{K}((i-1)*15+1:i*15,(r-1)*15+1:r*15)));
         end
     end
 end
 
 difference = zeros(5,5,length(fileList));
  for i = 1:5
     for r = 1:5
         for K = 1:length(fileList)
            difference(i,r,K) = abs(pixcount(i,r)-pixcount2(i,r,K))^2;
         end
     end
  end
  
  difference2 = zeros(1,length(fileList));
  for K = 1:length(fileList)
        difference2(K) = sum(sum(difference(:,:,K)));
  end
  
  [m,index] = min(difference2);
 
 output = fileList(index).name;
 output = output(1);
end

