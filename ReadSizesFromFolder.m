imagefiles = dir('resources/TrainingsIMGs/Foreground/*.png');      
nfiles = length(imagefiles);    % Number of files found
S = [];
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   dims = size(currentimage);
   images{ii} = currentimage;
   sizes{ii} = dims(1)/dims(2);
end

meanRatio = mean(cell2mat(sizes))