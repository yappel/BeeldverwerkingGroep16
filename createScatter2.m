function [  ] = createScatter2( listFOR, listBACK )
%CREATESCATTER Summary of this function goes here
%   Detailed explanation goes here
close all;
size1 = size(listFOR(:));
length = size1(1);
redFOR = cell(length);
greenFOR = cell(length);
blueFOR = cell(length);
hueFOR = cell(length);
satFOR = cell(length);
intFOR = cell(length);

redBACK = cell(length);
greenBACK = cell(length);
blueBACK = cell(length);
hueBACK = cell(length);
satBACK = cell(length);
intBACK = cell(length);

for i = 1:length
    redFOR{i} = listFOR{i}(:,:,1);
    greenFOR{i} = listFOR{i}(:,:,2);
    blueFOR{i} = listFOR{i}(:,:,3);
    hsi_image = rgb2hsv(listFOR{i});
    hueFOR{i} = hsi_image(:,:,1);
    satFOR{i}= hsi_image(:,:,2);
    intFOR{i}= hsi_image(:,:,3);
    
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
%     R = redBACK{i};
%     G = greenBACK{i};
%     scatter(R(:),G(:),'b', '.');
    
     R = redFOR{i};
     G = greenFOR{i};
     scatter(R(:),G(:), 'r', '.');
    
    
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
%     R = redBACK{i};
%     B = blueBACK{i};
%     scatter(R(:),B(:), 'b', '.');
    
    R = redFOR{i};
    B = blueFOR{i};
    scatter(R(:),B(:), 'r', '.');
    
   
end
xlabel('red');
ylabel('blue');
title('red vs blue');

x = 0:255;
y = 0.68 * x + 4.18;
scatter(x,y,'.')

  figure(3)
  hold on

for i = 1:length
%     B = blueBACK{i};
%     G = greenBACK{i};
%     scatter(B(:),G(:), 'b', '.');
    
    B = blueFOR{i};
    G = greenFOR{i};
    scatter(B(:),G(:), 'r', '.');
    
    
end
xlabel('blue');
ylabel('green');
title('blue vs green');

%figure(1);
 figure(4)
  hold on

for i = 1:length
%     H = hueBACK{i};
%     S = satBACK{i};
%     scatter(H(:),S(:), 'b', '.');
    
    H = hueFOR{i};
    S = satFOR{i};
    scatter(H(:),S(:), 'r', '.');
    
    
end
xlabel('hue');
ylabel('saturation');
title('hue vs saturation');

    figure(2)
    hold on

figure(5)
  hold on

for i = 1:length
%     H = hueBACK{i};
%     I = intBACK{i};
%     scatter(H(:),I(:), 'b', '.');
    
    H = hueFOR{i};
    I = intFOR{i};
     scatter(H(:),I(:), 'r', '.');
    
    
end
xlabel('hue');
ylabel('intensity');
title('hue vs intensity');

figure(6)
  hold on

for i = 1:length 
    
%     S = satBACK{i};
%     I = intBACK{i};
%     scatter(S(:),I(:), 'b', '.');
    
    S = satFOR{i};
    I = intFOR{i};
    scatter(S(:),I(:), 'r', '.');
    
   
end
xlabel('saturation');
ylabel('intensity');
title('saturation vs intensity');

end

