% Takes in cell array of j filenames corresponding to aligned set of images
% Returns an array of nxnxj luminances samples
% taken from an nxn grid centered on each of the images
% And an array of j exposure lengths
% Also maybe some other things
function [ imgs, Z, T, L, W ] = setupHDR(fnames, n)
    assert(iscellstr(fnames), 'Error: fnames must be a cell array of filename strings');
        
    Z = zeros(n*n,numel(fnames));
    W = zeros(n*n,numel(fnames));
    imgs = zeros(numel(fnames));
    i = 1;
    for name = fnames
        img = imread(name);
        imgs(i)=img;
        
        % set up Z(:,i) by extracting nxn grid of pixels in hsl format
        pxd = size(img)/6;
        crds(1) = pxd(1)*(1:n);
        crds(2) = pxd(2)*(1:n);
        for x = crds(1)
            for y = crds(2)
                tmp = RGBtoHSL(img(x,y,:));
                Z(n*x+y,i) = tmp(3);
            end
        end
                
        % set up T(i) based on image metadata (exif tag)
        info = imfinfo(name);
        T(i) = info.DigitalCamera.ExposureTime;
        
        % choose w(j,i) according to distance from max,min
        % w(j,i) = z-Zmin for z close to Zmin
        % w(j,i) = Zmax-z for z close to Zmax
        j=1;
        for px = Z(:,i)
            if px > 128 
                W(j,i) = 255-px;
            else
                W(j,i) = px;
            end
        end
        %Next image
        i = i+1;
    end
    
    L = 1;
    
end