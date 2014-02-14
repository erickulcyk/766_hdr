function [ hdr_rgb_img, g, weight ] = HDRComplete(fnames, n)
    [imgs, Z, T, lambda, weight] = setupHDR(fnames,n);
    disp('Done Setup');
    HSLImgs = FramesToHSL(imgs);
    disp('Done to HSL');
    g = gsolve2(Z, T, lambda, weight);
    disp('Done gsolve');
    hdr_img = hdr(HSLImgs,T, g, weight, 3);
    disp('Done to hdr_img');
    
    %map resulting radiances to 0-255 scale
    hdr_img(:,:,3) = (hdr_img(:,:,3)-min(min(hdr_img(:,:,3))))*255/max(max(hdr_img(:,:,3)));
    
    hdr_rgb_img = FrameToRGB(hdr_img);
end