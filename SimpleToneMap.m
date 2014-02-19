function [ toneImg ] = SimpleToneMap( img )
    img(:,:,3) = img(:,:,3)-min(min(img(:,:,3)));
    img(:,:,3) = img(:,:,3)/max(max(img(:,:,3)));
    toneImg(:,:,3) = (exp(img(:,:,3))-1)/(1.718281)*255;
    toneImg = uint8(round(toneImg));
end

