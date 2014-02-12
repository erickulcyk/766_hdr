% Takes in cell array of j filenames corresponding to aligned set of images
% Returns an array of nxnxj luminances samples
% taken from an nxn grid centered on each of the images
% And an array of j exposure lengths
% Also maybe some other things
function [ Z, T ] = setupHDR(fnames, n)
    
    i = 1;
    for name = fnames
        img = imread(name);
        
        % set up Z(:,j) by extracting nxn grid of pixels in hsl format
        pxd = size(img)/6;
        crds(1) = pxd(1)*(1:n);
        crds(2) = pxd(2)*(1:n);
        for x = crds(1)
            for y = crds(2)
                tmp = RGBtoHSL(img(x,y,:));
                Z(n*x+y,i) = tmp(3);
            end
        end
        i = i+1;
        
        % set up T(i) based on image metadata? (exif tag)
        %    code here
    end
    
end