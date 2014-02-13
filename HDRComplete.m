function [ ] = HDRComplete(fnames, n)
    [imgs, Z, T] = setupHDR(fnames,n);
    HSLImgs = FramesToHSL(imgs);
    
    lambda = 1;
    
    gsolve2(Z, T, lambda, weight);
end