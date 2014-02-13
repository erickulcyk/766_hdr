function [ ] = HDRComplete(fnames, n)
    [imgs, Z, T, lambda, weight] = setupHDR(fnames,n);
    HSLImgs = FramesToHSL(imgs);
    
    g = gsolve2(Z, T, lambda, weight);
    hdr_img = hdr(HSLImgs,T, g, weight, 3);
    hdr_rgb_img = ImgToRGB(hdr_img);
    imshow(hdr_rgb_img);
end