function [ ] = HDRComplete(fnames, n)
    [imgs, Z, T] = setupHDR(fnames,n);
    HSLImgs = FramesToHSL(imgs);
    
    lambda = 1;
    weight = ones(size(256));
    
    g = gsolve2(Z, T, lambda, weight);
    hdr_img = hdr(HSLImgs,T, g, weight, 3);
    hdr_rgb_img = ImgToRGB(hdr_img);
    imshow(hdr_rgb_img);
end