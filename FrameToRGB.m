%Converts an entire image to rgb
% imgs = (row, column, channel)
% hslImgs = (row, column, channel)
function [ rgbImg ] = FrameToRGB(img)
    rows = size(img,1);
    columns = size(img,2);
    channels = size(img,3);
    
    rgbImg = uint8(zeros(rows, columns, channels));
    for i=1:rows
        for j=1:columns
            pixel = img(i,j,:)/255.0;
            rgbImg(i,j,:) = uint8(HSLtoRGB(pixel));
        end
    end
end