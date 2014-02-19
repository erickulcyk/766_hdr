function [ hsl_lut, rgb_lut ] = RGB_HSL_lut( )

    hsl_lut = zeros(256,256,256,3);
    rgb_lut = zeros(256,256,256,3);
    parpool(4);
    parfor i=1:256
        disp(i);
        for j=1:256
            for k=1:256
                hsl_lut(i,j,k,:) = RGBtoHSL([i,j,k]);
                rgb_lut(i,j,k,:) = uint8(round(HSLtoRGB([i/255,j/255,k/255])));
                %disp(rgb_lut(i,j,k,:));
            end
        end
    end
end

