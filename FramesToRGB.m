%Converts an entire image to rgb
% imgs = (row, column, channel)
% hslImgs = (row, column, channel)
function [ rgbImg ] = FramesToRGB(img)
    rows = size(img,1);
    columns = size(img,2);
    channels = size(img,3);
    
    rgbImg = zeros(rows, columns, channels);
    for i=1:rows
        for j=1:columns
            pixel = img(i,j,:)/256;
            rgbImg(i,j,:) = HSLtoRGB(pixel);
        end
    end
end