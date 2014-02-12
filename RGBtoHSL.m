% rgb to hsl converter for one pixel
% algorithm adapted from serennu.com/colour/rgbtohsl.php
% hue/saturation returned on continuous 0-255 scale
% lightness binned to discrete values 0-255
function [ hsl ] = RGBtoHSL(rgbi)
    rgb = double(rgbi)/255;
    vmin = min(rgb);
    vmax = max(rgb);
    dmax = vmax-vmin;
    hsl = zeros([3, 1]);
    hsl(3) = (vmax+vmin)/2;
    
    if dmax ~= 0
        if hsl(3) < 0.5
            hsl(2) = dmax/(vmax+vmin);
        else
            hsl(2) = dmax/(2-vmax-vmin);
        end
        delr = ((vmax - rgb(1))/6 + dmax/2)/dmax;
        delg = ((vmax - rgb(2))/6 + dmax/2)/dmax;
        delb = ((vmax - rgb(3))/6 + dmax/2)/dmax;
        if rgb(1) == vmax
            hsl(1) = delb - delg;
        elseif rgb(2) == vmax
            hsl(1) = 1/3 + delr - delb;
        elseif rgb(3) == vmax
            hsl(1) = 2/3 + delg - delr;
        end
        
        if hsl(1) < 0
            hsl(1) = hsl(1) + 1;
        end
        
        if hsl(1) > 1
            hsl(1) = hsl(1) - 1;
        end
    end
    hsl = hsl*255;
    % bin lightness
    hsl(3) = round(hsl(3));
end