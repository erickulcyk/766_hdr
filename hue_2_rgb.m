%Function to convert hue to RGB, called from above
function [ hue ] = hue_2_rgb(v1,v2,vh)
if (vh < 0)
    vh = vh + 1;
end

if (vh > 1)
    vh = vh - 1;
end

if ((6 * vh) < 1)
    hue = (v1 + (v2 - v1) * 6 * vh);
    return;
end

if ((2 * vh) < 1)
    hue = v2;
    return;
end

if ((3 * vh) < 2)
    hue = (v1 + (v2 - v1) * ((2 / 3 - vh) * 6));
    return;
end

hue = v1;
end