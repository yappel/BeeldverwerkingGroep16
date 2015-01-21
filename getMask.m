function mask = getMask(frame)
    frame(:,:,1) = medfilt2(frame(:,:,1),[3 3]);
    frame(:,:,2) = medfilt2(frame(:,:,2),[3 3]);
    frame(:,:,3) = medfilt2(frame(:,:,3),[3 3]);
%     hsidata = rgb2hsv(frame);
    mask1 = frame(:,:,2) <= 1.08 .* frame(:,:,1) + 5.6;
    mask2 = frame(:,:,2) >= 0.48 .* frame(:,:,1) - 4.1;
    mask3 = frame(:,:,3) <= 0.68 .* frame(:,:,1) - 4.18;
    mask5 = frame(:,:,3) <= 0.68 .* frame(:,:,2) - 4.18;
%     mask4 = hsidata(:,:,1) < 0.18;
%     mask =  mask1 .* mask2 .* mask3 .* mask4 .* mask5;
    mask =  mask1 .* mask2 .* mask3  .* mask5;
end