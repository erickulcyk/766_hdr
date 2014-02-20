function [ imgs ] = ReadImgs( fnames )
i = 1;

while i<=numel(fnames)
    img = imread(fnames{i});
    
    if(i==1)
        imgs= zeros(numel(fnames),size(img,1),size(img,2),size(img,3));
    end
    imgs(i,:,:,:) = img;
    i=i+1;
end
end

