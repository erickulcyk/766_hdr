function [ weights ] = DeGhostWeights(weights,LogIrr,LogIrrRef,n, ghostthresh)
% de-ghost by filtering out pixels which deviate significantly from the
% reference image. According to the algorithm described by Orazio, et al.,
% this is done on a patch-by-patch basis, with each image broken into
% an n by n grid of patches
    pxd = (size(LogIrrRef))/(n);
    crds(1,:) = pxd(1)*(0:n)+1;
    crds(2,:) = pxd(2)*(0:n)+1;
    crds = round(crds);
    thresh = 0.005*pxd(1)*pxd(2);
    countThrown = 0;
    for x = (1:n)
        for y = (1:n)
            lik(:,:) = LogIrr(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1));
            lir(:,:) = LogIrrRef(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1));
            b=mean(mean(lik))-mean(mean(lir));
            if gcountExcThresh(lik, lir, (crds(1,x+1)-1)-crds(1,x), (crds(2,y+1)-1)-crds(2,y), b, ghostthresh, thresh) == 1
                % this patch exceeds the threshold condition
                %disp(['Ghosting detected on patch ',num2str(40*(x-1)+y)]);
                weights(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1)) = 0;
                countThrown = countThrown+1;
                                
                %{if(n>5)
                %    weights(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1)) = DeGhostWeights(weights(crds(1,x):(crds(1,x+1)-1),...
                %                                                                          crds(2,y):(crds(2,y+1)-1)),...
                %                                                                          lik,lir,5,ghostthresh);
                %else
                %    weights(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1)) = weights(crds(1,x):(crds(1,x+1)-1),crds(2,y):(crds(2,y+1)-1))/2;
                %end
                %}
            end
            clearvars lik; % forget the patch size as it may be different 
            clearvars lir; % on subsequent iterations
        end
    end
    disp(['Threw out ', num2str(countThrown), ' patches which exceeded ghost thresholds.']);
end

