% Change the current folder to the folder of this m-file.
% (The line of code below is from Brett Shoelson of The Mathworks.)
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
format compact;
workspace;  % Make sure the workspace panel is showing.

if(~isdeployed)
	cd(fileparts(which(mfilename)));
end

filelist = dir('resources/Trainingsset/Categorie I/*.avi');
for K = 1:length(filelist)
  vid = VideoReader(['resources/Trainingsset/Categorie I/', filelist(K).name]);
  frame = readFrame(vid);
  fprintf(1,[num2str(K) ': \n']);
  frame2 = thresholdFilter(frame);
  %frame2 = rotation(frame);
  pause
  name = ['resources/SegmentationTest/test', num2str(K), '.png'];
  imwrite(frame2, name);
  %imshow(frame2);
end