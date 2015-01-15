function [  ] = createScatter2( listFOR, listBACK )
%CREATESCATTER Summary of this function goes here
%   Detailed explanation goes here
close all;
size1 = size(listFOR(:));
size2 = size(listBACK(:));
length = size1(1);
length2 =  size2(1);
redFOR = cell(length);
greenFOR = cell(length);
blueFOR = cell(length);
hueFOR = cell(length);
satFOR = cell(length);
intFOR = cell(length);

redBACK = cell(length2);
greenBACK = cell(length2);
blueBACK = cell(length2);
hueBACK = cell(length2);
satBACK = cell(length2);
intBACK = cell(length2);

for i = 1:length
    redFOR{i} = listFOR{i}(:,:,1);
    greenFOR{i} = listFOR{i}(:,:,2);
    blueFOR{i} = listFOR{i}(:,:,3);
    hsi_image = rgb2hsv(listFOR{i});
    hueFOR{i} = hsi_image(:,:,1);
    satFOR{i}= hsi_image(:,:,2);
    intFOR{i}= hsi_image(:,:,3);
end
for i = 1:length2
    redBACK{i} = listBACK{i}(:,:,1);
    greenBACK{i} = listBACK{i}(:,:,2);
    blueBACK{i} = listBACK{i}(:,:,3);
    hsi_image = rgb2hsv(listBACK{i});
    hueBACK{i} = hsi_image(:,:,1);
    satBACK{i}= hsi_image(:,:,2);
    intBACK{i}= hsi_image(:,:,3);
end

  figure(1)
  hold on


for i = 1:length
     R = redFOR{i};
     G = greenFOR{i};
     scatter(R(:),G(:), 'r', '.');  
end

for i = 1:length2
    R = redBACK{i};
    G = greenBACK{i};
    scatter(R(:),G(:),'b', '.');
end

xlabel('red');
ylabel('green');
title('red vs green');
x = 0:255;
y = 0.48 * x -4.1;
scatter(x,y,'.')
y = 1.08 * x + 5.6;
scatter(x,y,'.')

    figure(2)
    hold on


for i = 1:length
    R = redFOR{i};
    B = blueFOR{i};
    scatter(R(:),B(:), 'r', '.');  
end
for i = 1:length2
    R = redBACK{i};
    B = blueBACK{i};
    scatter(R(:),B(:), 'b', '.');
end
xlabel('red');
ylabel('blue');
title('red vs blue');

x = 0:255;
% y = 0.68 * x + 4.18;
y = 0.68 * x -4;
scatter(x,y,'.')

  figure(3)
  hold on


for i = 1:length
    
    B = blueFOR{i};
    G = greenFOR{i};
    scatter(B(:),G(:), 'r', '.');   
end
for i = 1:length2
    B = blueBACK{i};
    G = greenBACK{i};
    scatter(B(:),G(:), 'b', '.');
    end
xlabel('blue');
ylabel('green');
title('blue vs green');

x = 0:255;
y = 1.5 * x +25;
scatter(x,y,'.')

%figure(1);
 figure(4)
  hold on


for i = 1:length
    
    H = hueFOR{i};
    S = satFOR{i};
    scatter(H(:),S(:), 'r', '.');  
end
for i = 1:length2
    H = hueBACK{i};
    S = satBACK{i};
    scatter(H(:),S(:), 'b', '.');
    end

xlabel('hue');
ylabel('saturation');
title('hue vs saturation');

    figure(2)
    hold on

figure(5)
  hold on


for i = 1:length
    
    H = hueFOR{i};
    I = intFOR{i};
     scatter(H(:),I(:), 'r', '.')  
end
for i = 1:length2
    H = hueBACK{i};
    I = intBACK{i};
    scatter(H(:),I(:), 'b', '.');
    end
xlabel('hue');
ylabel('intensity');
title('hue vs intensity');

figure(6)
  hold on


for i = 1:length
    
    S = satFOR{i};
    I = intFOR{i};
    scatter(S(:),I(:), 'r', '.');
  
end
for i = 1:length2
    
    S = satBACK{i};
    I = intBACK{i};
    scatter(S(:),I(:), 'b', '.');
    end
xlabel('saturation');
ylabel('intensity');
title('saturation vs intensity');

end

