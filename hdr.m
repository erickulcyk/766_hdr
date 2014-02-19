% Converts many images to one hdr image
% Time = exposure times array, 1 for each image
% g = solved for function
% weight = weight of each brightness (0..255)
% channel = channel to apply hdr to.
% returns a single hdr image.
function [ hdr_img ] = hdr( hdr_img, imgs, refind, Time, g, weightfunc, channel, useRef, ghostthresh)
    
    img_size = size(imgs,1);
    img_w = size(imgs,2);
    img_h = size(imgs,3);
    Irr = zeros(size(imgs,2),size(imgs,3),size(imgs,1));
    
    %Find the log irradiance values for each image
    IrrRef(:,:) = FindLogIrr(squeeze(imgs(refind,:,:,channel)),Time(refind),g);
    for k=1:img_size
        img(:,:) = squeeze(imgs(k,:,:,channel));
        Irr(:,:,k) = FindLogIrr(img(:,:),Time(k),g);
        disp(['Image ',num2str(k) ,' max difference ', num2str(max(max(squeeze(Irr(:,:,k))-IrrRef(:,:))))]);
    end
    disp('Found log irradiances.  Weighting images...');
    
    % get ready to construct hdr values for this channel
    hdr_img(:,:,channel) = zeros(size(hdr_img(:,:,channel)));
    weight = zeros(size(imgs,2),size(imgs,3));
    weight_total = zeros(img_w,img_h);
        
    
    for k=1:img_size
        %compute weights using weightfunc
        img(:,:) = squeeze(imgs(k,:,:,channel));
        parfor i=1:img_w
            for j=1:img_h
                weight(i,j) = weightfunc(img(i,j)+1);
            end
        end
        if useRef > 0
            %de-ghost by filtering weights based on correlation with reference image
            weight(:,:) = DeGhostWeights(weight(:,:),Irr(:,:,k),IrrRef,100, ghostthresh);
        end
        
        %add weighted value to totals for each pixel
        parfor i=1:img_w
            for j=1:img_h
                hdr_img(i,j,channel) = hdr_img(i,j,channel) + weight(i,j)*(Irr(i,j,k));
                weight_total(i,j) = weight_total(i,j) + weight(i,j);
            end
        end
        
        disp(['Deghosting complete for image ',num2str(k)]);
    end
    
    for i=1:img_w
        for j=1:img_h
           if(weight_total(i,j) ==0)
               hdr_img(i,j,channel) = 1;
           else
                hdr_img(i,j,channel) = hdr_img(i,j,channel)/weight_total(i,j);
           end
        end
    end
end