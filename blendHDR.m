function [ hdr_blended ] = blendHDR( hdr_log_irr  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sli1 = size(hdr_log_irr,1);
    sli2 = size(hdr_log_irr,2);
    indst = (sli2-sli1)/2;
    log_irr(:,:) = hdr_log_irr;
    log_irr = padarray(log_irr,[(sli2-sli1)/2+1, 1],'replicate');
    disp(size(log_irr));
    sli2 = size(log_irr,2);
    
    [gx,gy] = gradient((log_irr),1,1);
    divg = divergence(gx,gy);
    b = -reshape(divg(2:sli2-1,2:sli2-1),(sli2-2)*(sli2-2),1);
    A = gallery('poisson',sli2-2);
    U = A\b;
    u = reshape(U,sli2-2,sli2-2);
    
    disp(size(u));
    disp([(sli2-sli1)/2,(sli2+sli1)/2]);
    hdr_blended = u(((sli2-sli1)/2-1):((sli2+sli1)/2-2),:);
    
end

