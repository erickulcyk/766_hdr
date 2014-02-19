function [ hdr_rgb_img, g, weight ] = HDRComplete(fnames, n, channel,g,weight,man)
    if(man==1)
        if(channel==-1)
            [imgs, Z, T, lambda, garbage] = setupHDR(fnames,n, 0);
            disp(T);
            img_w = size(imgs,2);
            img_h = size(imgs,3);
            channels = size(imgs,4);
            hdr_img = zeros(img_w,img_h, channels);
            for i=1:channels
                [imgs, Z, T, lambda, garbage] = setupHDR(fnames,n, i);
                disp('Done Setup');
                refind = selectRef(imgs);
                disp('Got reference');
                hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, i,1,1.5);% 3);
                disp('Done to hdr_img');
            end
        else
            [imgs, Z, T, lambda, garbage] = setupHDR(fnames,n, channel);
    
            %handle unused channels
            hdr_img = mean(imgs,1); %use average value across images for unused channels
            
            disp('Done Setup');
            hdr_img = hdr(hdr_img,imgs,refind,T, g, weight, channel,1,1.5);% 3);
            disp('Done to hdr_img');
            hdr_img(:,:,channel) = (hdr_img(:,:,channel)-min(min(hdr_img(:,:,channel))))*255/max(max(hdr_img(:,:,channel)));
    
        end
    
        %map resulting radiances to 0-255 scale
        if(channel >0)
        end
    end        

    if(man==0)
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
                refind = selectRef(imgs);
                disp('Got reference');
                g = gsolve2(Z, T, lambda, weight);
                disp('Done Gsolve');
                hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, i, 1,1.5);% 3);
                disp('Done to hdr_img');
                %hdr_img = exp(hdr_img);
                %hdr_img(:,:,i) = (hdr_img(:,:,i)-min(min(hdr_img(:,:,i))))*255/(max(max(hdr_img(:,:,i)))-min(min(hdr_img(:,:,i))));
            end
        else
            [imgs, Z, T, lambda, weight] = setupHDR(fnames,n, channel);
    
            %handle unused channels
            hdr_img = mean(imgs,1); %use average value across images for unused channels
            %hdr_img = imgs(1,:,:,:); %arbitrarily take unused channels from first image
    
            disp('Done Setup');
            %HSLImgs = FramesToHSL(imgs);
            disp('Done to HSL');
            refind = selectRef(imgs);
            disp('Got reference');
            g = gsolve2(Z, T, lambda, weight);
            disp('Done gsolve');
            %hdr_img = hdr(HSLImgs,T, g, weight, -1);% 3);
            hdr_img = hdr(hdr_img,imgs, refind, T, g, weight, channel,1,1.5);% 3);
            disp('Done to hdr_img');
            hdr_img(:,:,channel) = (hdr_img(:,:,channel)-min(min(hdr_img(:,:,channel))))*255/max(max(hdr_img(:,:,channel)));
    
        end
    
        %map resulting radiances to 0-255 scale
        if(channel >0)
        end
    end
    hdr_rgb_img = hdr_img;
    %hdr_rgb_img = uint8(round(hdr_img)); %FrameToRGB(hdr_img);
end