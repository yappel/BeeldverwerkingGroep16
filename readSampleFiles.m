filelist = dir('resources/KentekenSamples/*.png');
list = cell(1,length(filelist));
for K = 1:length(filelist)
  list{K} = imread(filelist(K).name);
end
createScatter(list)
