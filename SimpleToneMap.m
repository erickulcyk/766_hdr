function [ toneImg ] = SimpleToneMap( img,p )
    img(:,:) = img(:,:)-min(min(img(:,:)));
    img(:,:) = img(:,:)/max(max(img(:,:)));
    max_num = exp(max(max(img(:,:))));
    min_num = exp(min(min(img(:,:))));
    av = mean(mean(img(:,:)));
    toneImg(:,:) = squeeze((exp(img(:,:))-min_num)/av*p);
    disp(size(toneImg));
end

