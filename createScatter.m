function [  ] = createScatter( list )
%CREATESCATTER Summary of this function goes here
%   Detailed explanation goes here
close all;
size1 = size(list(:));
length = size1(1);
red = cell(length);
green = cell(length);
blue = cell(length);
for i = 1:length
    red{i} = list{i}(:,:,1);
    green{i} = list{i}(:,:,2);
    blue{i} = list{i}(:,:,3);
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
y = x + 25;
y2 = 0.9*x -40;
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



end

