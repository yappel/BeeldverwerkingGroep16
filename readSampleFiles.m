method = 2;
listSize = 0;
if (method == 1)
    filelist = dir('resources/KentekenSamples/*.png');
    list = cell(1,length(filelist));
    for K = 1:length(filelist)
        list{K} = imread(['resources/KentekenSamples/', filelist(K).name]);
    end
    createScatter(list)
end

if (method == 2)
    
    filelistFOR = dir('resources/TrainingsIMGs/Foreground2/*.png');
    listFOR = cell(1,length(filelistFOR));
     for K = 1:length(filelistFOR)
        listFOR{K} = imread(['resources/TrainingsIMGs/Foreground2/', filelistFOR(K).name]);
     end
     
    filelistBACK = dir('resources/TrainingsIMGs/Background/*.png');
    listBACK = cell(1,length(filelistBACK));
     for K = 1:length(filelistBACK)
        listBACK{K} = imread(['resources/TrainingsIMGs/Background/', filelistBACK(K).name]);
     end
     
    createScatter2(listFOR, listBACK);
    
     
end