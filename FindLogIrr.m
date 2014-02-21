function [ Irr ] = FindLogIrr(image,Time,g)
% computes the irradiance map for the one-channel image
% exposed for Time over camera response function g
    Irr = zeros(size(image));
    for i=1:size(image,1)
        for j=1:size(image,2)
            Irr(i,j) = g(image(i,j)) - log(Time);
        end
    end
end

