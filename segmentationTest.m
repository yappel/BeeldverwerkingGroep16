filelist = dir('resources/Trainingsset/Categorie I/*.avi');
for K = 1:length(filelist)
  vid = VideoReader(['resources/Trainingsset/Categorie I/', filelist(K).name]);
  frame = readFrame(vid);
  frame2 = thresholdFilter(frame);
  name = ['resources/SegmentationTest/test', num2str(K), '.png'];
  imwrite(frame2, name);
end