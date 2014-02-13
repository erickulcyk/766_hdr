%Input is HSL value of complementary colour, held in $h2, $s, $l as fractions of 1
%Output is RGB in normal 255 255 255 format, held in $r, $g, $b
%Hue is converted using function hue_2_rgb, shown at the end of this code
function [ rgb ] = HSLtoRGB(hsl)
h = hsl(1);
s = hsl(2);
l = hsl(3);

if (s==0)
    r = l * 255;
    g = l * 255;
    b = l * 255;
else
    if (l < 0.5)
        var_2 = l * (1 + s);
    else
        var_2 = (l + s) - (s * l);
    end
    
    var_1 = 2 * l - var_2;
    r = 255 * hue_2_rgb(var_1,var_2,h + (1 / 3));
    g = 255 * hue_2_rgb(var_1,var_2,h);
    b = 255 * hue_2_rgb(var_1,var_2,h - (1 / 3));
    
end

rgb(1) = r;
rgb(2) = g;
rgb(3) = b;

end