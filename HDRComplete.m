function [ hdr_rgb_img, tone_map, hdr_img, g, weight ] = HDRComplete(fnames, n, channel,hsl_lut, rgb_lut, use_hsl, use_tonemap, g,weight,man, deGhost)
if(man==1)
    if(channel==-1)
        [Z, T, lambda, garbage] = setupHDR(fnames,n, 0);
        disp(T);
        img_w = size(imgs,2);
        img_h = size(imgs,3);
        channels = size(imgs,4);
        hdr_img = zeros(img_w,img_h, channels);
        for i=1:channels
            [Z, T, lambda, garbage] = setupHDR(fnames,n, i);
            imgs = ReadImgs(fnames);
            disp('Done Setup');
            refind = selectRef(imgs);
            disp('Got reference');
            hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, i,deGhost,1.5, use_hsl);% 3);
            disp('Done to hdr_img');
        end
    else
        [Z, T, lambda, garbage] = setupHDR(fnames,n, channel);
        imgs = ReadImgs(fnames);
        disp('Done Setup');
        refind = selectRef(imgs);
        disp('Got reference');
           
        %handle unused channels
        if(use_hsl == 1)
            hsl_imgs =  FramesToHSL(imgs, hsl_lut);
            hdr_img = squeeze(mean(hsl_imgs,1)); %use average value across images for unused channels
            disp('Done Convert To HSL');
            hdr_img = hdr(hdr_img,hsl_imgs,refind, T, g, weight, channel,deGhost,1.5, use_hsl);
        else
            hdr_img = squeeze(mean(imgs,1)); %use average value across images for unused channels
            hdr_img = hdr(hdr_img,imgs,refind,T, g, weight, channel,deGhost,1.5, use_hsl);% 3);
        end
        disp('Done to hdr_img');
        
        if(use_tonemap==1)
            tone_map = uint8(round(hdr_img));
            tone_map(:,:,channel) = SimpleToneMap(hdr_img,channel,50);
            if(use_hsl==1)
                hdr_rgb_img = FrameToRGB(tone_map,rgb_lut);
            end
        else
            hdr_rgb_img = uint8(round(hdr_img));
            tone_map = hdr_img;
        end
    end
end    
if(man==0)
    if(channel==-1)
        disp(T);
        imgs = ReadImgs(fnames);
        img_w = size(imgs,2);
        img_h = size(imgs,3);
        channels = size(imgs,4);
        hdr_img = zeros(img_w,img_h, channels);
        for i=1:3
            [Z, T, lambda, weight] = setupHDR(fnames,n, i);
            disp('Done Setup');
            refind = selectRef(imgs);
            disp('Got reference');
            g = gsolve2(Z, T, lambda, weight);
            disp('Done Gsolve');
            hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, i, deGhost,1.5, use_hsl);% 3);
            disp('Done to hdr_img');
        end
    else
        [Z, T, lambda, weight] = setupHDR(fnames,n, channel);
        disp('Done Setup');
        
        disp('Got reference');
        g = gsolve2(Z, T, lambda, weight);
        disp('Done gsolve');
        
         imgs = ReadImgs(fnames);
         disp('Done reading imgs');
         
        refind = selectRef(imgs);
        
        %handle unused channels
        if(use_hsl==1)
            hsl_imgs = FramesToHSL(imgs, hsl_lut);
            hdr_img = squeeze(hsl_imgs(4,:,:,:));%mean(hsl_imgs,1)); %use average value across images for unused channels
            disp('Done Convert To HSL');
            hdr_img = hdr(hdr_img,hsl_imgs, refind, T, g, weight, channel,deGhost,1.5, use_hsl);
        else
            hdr_img = squeeze(mean(imgs,1)); %use average value across images for unused channels
            hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, channel,deGhost,1.5, use_hsl);
        end
        disp('Done to hdr_img');
    end
    
    if(use_tonemap == 1)
        tone_map = uint8(round(hdr_img));
        tone_map(:,:,channel) = SimpleToneMap(hdr_img,channel,60);
        if(use_hsl==1)
            hdr_rgb_img = FrameToRGB(tone_map,rgb_lut);
        end
    else
        hdr_rgb_img = uint8(round(hdr_img));
        tone_map = hdr_img;
    end
end
end