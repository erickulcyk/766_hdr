function [ hdr_rgb_img, tone_map, hdr_img, g, weight ] = HDRComplete(fnames, n, channel, hsl_lut, rgb_lut, use_hsl, use_tonemap )

    if(channel==-1)
        [imgs, Z, T, lambda, weight] = setupHDR(fnames,n, 0);
        disp(T);
        img_w = size(imgs,2);
        img_h = size(imgs,3);
        channels = size(imgs,4);
        hdr_img = zeros(img_w,img_h, channels);
        for i=1:channels
            [imgs, Z, T, lambda, weight] = setupHDR(fnames,n, i);
            disp('Done Setup');
            g = gsolve2(Z, T, lambda, weight);
            disp('Done Gsolve');
            hdr_img = hdr(hdr_img,imgs,T, g, weight, i);
            disp('Done to hdr_img');
        end
    else
        [imgs, Z, T, lambda, weight] = setupHDR(fnames,n, channel);
        disp('Done Setup');
        
        %handle unused channels
        if(use_hsl == 1)
            hsl_imgs =  FramesToHSL(imgs, hsl_lut);
            hdr_img = squeeze(mean(hsl_imgs,1)); %use average value across images for unused channels
            disp('Done Convert To HSL');
        else
            hdr_img = squeeze(mean(imgs,1)); %use average value across images for unused channels
        end

        g = gsolve2(Z, T, lambda, weight);
        disp('Done gsolve');
        hdr_img = hdr(hdr_img,hsl_imgs,T, g, weight, channel);
        disp('Done to hdr_img');
    end
    
    if(use_tonemap ==1)
        tone_map = SimpleToneMap(hdr_img);
        if(use_hsl==1)
            hdr_rgb_img = FrameToRGB(tone_map, rgb_lut);
        end
    else
        hdr_rgb_img = hdr_img;
    end
end