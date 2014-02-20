function [ toneImg ] = SimpleToneMap( img, channel,p )
    img(:,:, channel) = img(:,:, channel)-min(min(img(:,:,channel)));
    img(:,:, channel) = img(:,:, channel)/max(max(img(:,:,3)));
    max_num = exp(max(max(img(:,:,channel))));
    min_num = exp(min(min(img(:,:,channel))));
    av = mean(mean(img(:,:,channel)));
    toneImg(:,:) = squeeze((exp(img(:,:, channel))-min_num)/av*p);
    disp(size(toneImg));
    toneImg = uint8(round(toneImg));
end

