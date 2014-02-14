%Converts entires images to hsl
% imgs = (frame, row, column, channel)
% hslImgs = (frame, row, column, channel)
function [ hslImgs ] = FramesToHSL(imgs)
    imgCount = size(imgs,1);
    rows = size(imgs,2);
    columns = size(imgs,3);
    channels = size(imgs,4);
    
    hslImgs = zeros([imgCount, rows, columns, channels]);
    for i=(1:imgCount)
        for j=(1:rows)
            for k=(1:columns)
                pixel = imgs(i,j,k,:);
                hslImgs(i,j,k,:) = RGBtoHSL(pixel);
            end
        end
    end
end