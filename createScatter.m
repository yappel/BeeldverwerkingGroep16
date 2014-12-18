function [  ] = createScatter( list )
%CREATESCATTER Summary of this function goes here
%   Detailed explanation goes here
close all;
size1 = size(list(:));
length = size1(1);
red = cell(length);
green = cell(length);
blue = cell(length);
hue = cell(length);
sat = cell(length);
int = cell(length);
for i = 1:length
    red{i} = list{i}(:,:,1);
    green{i} = list{i}(:,:,2);
    blue{i} = list{i}(:,:,3);
    hsi_image = rgb2hsv(list{i});
    hue{i} = hsi_image(:,:,1);
    sat{i}= hsi_image(:,:,2);
    int{i}= hsi_image(:,:,3);
end
    
  figure(1)
  hold on

for i = 1:length
    R = red{i};
    G = green{i};
    scatter(R(:),G(:),'filled');
end
xlabel('red');
ylabel('green');
title('red vs green');
x = 1:255;
y = 0.9*x + 22;
y2 = 0.9*x -70;
scatter(x,y,'.');
scatter(x,y2,'.');


    figure(2)
    hold on

for i = 1:length
    R = red{i};
    B = blue{i};
    scatter(R(:),B(:),'filled');
end
xlabel('red');
ylabel('blue');
title('red vs blue');

  figure(3)
  hold on

for i = 1:length
    B = blue{i};
    G = green{i};
    scatter(B(:),G(:),'filled');
end
xlabel('blue');
ylabel('green');
title('blue vs green');

%figure(1);
 figure(4)
  hold on

for i = 1:length
    H = hue{i};
    S = sat{i};
    scatter(H(:),S(:),'filled');
end
xlabel('hue');
ylabel('saturation');
title('hue vs saturation');

    figure(2)
    hold on

figure(5)
  hold on

for i = 1:length
    H = hue{i};
    I = int{i};
    scatter(H(:),I(:),'filled');
end
xlabel('hue');
ylabel('intensity');
title('hue vs intensity');

figure(6)
  hold on

for i = 1:length
    S = sat{i};
    I = int{i};
    scatter(S(:),I(:),'filled');
end
xlabel('saturation');
ylabel('intensity');
title('saturation vs intensity');

end

