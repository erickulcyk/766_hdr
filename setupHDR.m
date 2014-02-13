% Takes in cell array of j filenames corresponding to aligned set of images
% Returns an array of nxnxj luminances samples
% taken from an nxn grid centered on each of the images
% And an array of j exposure lengths
% Also maybe some other things
function [ imgs, Z, T, L, W ] = setupHDR(fnames, n)
    assert(iscellstr(fnames), 'Error: fnames must be a cell array of filename strings');
        
    Z = zeros(n*n,numel(fnames));
    W = zeros(n*n,numel(fnames));
    i = 1;
    while i<=numel(fnames)
        img = imread(fnames{i});
        imgs(i,:,:,:)=img;
        
        % set up Z(:,i) by extracting nxn grid of pixels in hsl format
        pxd = size(img)/6;
        crds(1,:) = pxd(1)*(1:n);
        crds(2,:) = pxd(2)*(1:n);
        crds = round(crds);
        for x = (1:n)
            for y = (1:n)
                tmp = RGBtoHSL(img(crds(1,x),crds(2,y),:));
                Z(n*x+y-n,i) = tmp(3);
            end
        end
                
        % set up T(i) based on image metadata (exif tag)
        info = imfinfo(fnames{i});
        try
            T(i) = info.DigitalCamera.ExposureTime;
        catch err
            T(i) = 1/(numel(fnames)-i+1);
        end
        
        % choose w(j,i) according to distance from max,min
        % w(j,i) = z-Zmin for z close to Zmin
        % w(j,i) = Zmax-z for z close to Zmax
        for j = (1:n*n)
            px = Z(j,i);
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