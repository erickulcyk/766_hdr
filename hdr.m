function [ hdr_img ] = hdr( imgs, Time, g, weight, channel)

    img_size = size(imgs,1);
    img_w = size(imgs,2);
    img_h = size(imgs,3);
    channels = size(imgs,4);
    
    hdr_img = zeros(img_w,img_h, channels);
    weight_total = zeros(img_w,img_h);
    for i=1:img_w
        for j=img_h
            for k=1:img_size
                for l=1:channels
                    if(l==channel)
                        pixel = imgs(k,i,j,l);
                        hdr_img(i,j,l) = hdr_img(i,j,l) + weight(pixel)*(g(pixel)-Time(k));
                        weight_total(i,j) = weight_total(i,j) + weight(pixel);
                    else
                        hdr_img(i,j,l) = hdr_img(i,j,l) + weight(pixel);
                    end
                end
            end
        end
    end
    
    for i=1:img_w
        for j=1:img_h
            for l=1:channels
                hdr_img(i,j,l) = hdr_img(i,j)/weight_total(i,j);
            end
        end
    end
end