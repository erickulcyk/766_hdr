%Converts an entire image to rgb
% imgs = (row, column, channel)
% hslImgs = (row, column, channel)
function [ rgbImg ] = FrameToRGB(img, lut)
    rows = size(img,1);
    columns = size(img, 2);
    channels = size(img,3);
    rgbImg = zeros(rows, columns, channels);

    parfor i=1:rows
        disp(i);
        for j=1:columns
            tmp = img(i,j,:);
            tmp2 = lut(tmp(1,1,1)+1,tmp(1,1,2)+1,tmp(1,1,3)+1,:);
            rgbImg(i,j,:) = tmp2(1,1,1,:);
        end
    end
    
    rgbImg = uint8(round(rgbImg));
end
