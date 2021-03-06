% Takes in cell array of j filenames corresponding to aligned set of images
% Returns an array of nxnxj luminances samples
% taken from an nxn grid centered on each of the images
% And an array of j exposure lengths
% Also maybe some other things
function [ Z, T, L, W ] = setupHDR(fnames, n, channel, use_hsl)
    assert(iscellstr(fnames), 'Error: fnames must be a cell array of filename strings');
       
    Z = zeros(n*n,numel(fnames));
    i = 1;
    while i<=numel(fnames)
        img = imread(fnames{i});
        
        % set up Z(:,i) by extracting nxn grid of pixels in hsl format
        pxd = size(img)/(n+1);
        crds(1,:) = pxd(1)*(1:n);
        crds(2,:) = pxd(2)*(1:n);
        crds = round(crds);
        for x = (1:n)
            for y = (1:n)
                if(channel>0 && ~use_hsl)
                    tmp = img(crds(1,x),crds(2,y),:);
                    Z(n*x+y-n,i) = tmp(channel);
                end
                
                if(channel>0 && use_hsl)
                    tmp = RGBtoHSL(img(crds(1,x),crds(2,y),:));
                    Z(n*x+y-n,i) = tmp(channel);
                end
                
                if(channel == 0)
                    tmp = RGBtoHSL(img(crds(1,x),crds(2,y),:));
                    Z(n*x+y-n,i) = tmp(3);
                end
            end
        end
                
        % set up T(i) based on image metadata (exif tag)
        info = imfinfo(fnames{i});
        try
            T(i) = info.DigitalCamera.ExposureTime;
        catch err
            %T(i) = 1/(numel(fnames)-i+1);
            T(1) = 1/30;
            T(2) = 1/120;
        end
        
        %Next image
        i = i+1;
    end
    
    W = zeros(256);
    W = W(:,1);
    for j = (0:255)
        if j > 127.5 
            W(j+1) = 255-j;
        else
            W(j+1) = j;
        end
    end

    L = 1; W = W+1;
    
end