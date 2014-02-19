function [ out ] = gcountExcThresh( lik, lir, xdist, ydist, b, dist, thresh)
% auxiliary function for DeGhostWeights.m
% returns 0 if the number of pixels greater than dist
% from the correlation line lik=lir+b is fewer than thresh
% returns 1 otherwise
    gcount = 0;
    maxfound = 0;
    for i=1:xdist
        for j=1:ydist
            if abs(lir(i,j) + b - lik(i,j))>maxfound
                maxfound = abs(lir(i,j) + b - lik(i,j));
            end
            if abs(lir(i,j) + b - lik(i,j))>dist
                %pixel outside threshold, ghosting likely
                gcount = gcount+1;
                if gcount > thresh
                    out = 1;
                    return;
                end
            end
        end
    end
    out = 0;
    %if gcount ~= 0 || maxfound ~=0
    %    disp(['found a total of ', num2str(gcount), ' potential ghosts, worst pixel ', num2str(maxfound)]);
    %end
    return;
end

