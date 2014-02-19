function [ refind ] = selectRef( imgs )
% Choose a reference image using the method described by Gallo, et al.
% in their paper, Artifact-free High Dynamic Range Imaging
    sel = strel('square',5);
    parfor i=1:size(imgs,1)
        %remove small saturated regions using erosion followed by dilation
        morphed = imdilate(imerode(imgs(i,:,:,:),sel),sel);
        numSat(i) = sum(sum(sum(morphed==255)))+sum(sum(sum(morphed==0)));
    end
    [minCount,refind] = min(numSat);
    
end

