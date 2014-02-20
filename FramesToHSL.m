%Converts entires images to hsl
% imgs = (frame, row, column, channel)
% hslImgs = (frame, row, column, channel)
function [ hslImgs ] = FramesToHSL(imgs, lut)
    imgCount = size(imgs,1);
    rows = size(imgs,2);
    columns = size(imgs, 3);
    channels = size(imgs,4);
    
    hslImgs = zeros([imgCount, rows, columns, channels]);
    parfor i=(1:imgCount)
        disp(i);
        for j=1:rows
            disp(j);
            for k=1:columns
                tmp = squeeze(imgs(i,j,k,:))+1;
                hslImgs(i,j,k,:) =  squeeze(lut(tmp(1),tmp(2),tmp(3),:));
            end
        end
        disp(['Done: ', num2str(i)]);
    end
end