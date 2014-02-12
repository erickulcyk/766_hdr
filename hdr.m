function [ hdr_img ] = hdr( imgs, Time, g, weight)

    img_w = size(imgs(1),1);
    img_h = size(imgs(1),2);
    img_size = size(imgs,1);
    
    hdr_img = zeros(size(img_w),size(img_h));
    weight_total = zeros(size(img_w),size(img_h));
    for i=1:img_w
        for j=img_h
            for k=1:img_size
                pixel = imgs(k,i,j);
                hdr_img(i,j) = hdr_img(i,j) + weight(pixel)*(g(pixel)-Time(k));
                weight_total(i,j) = weight_total(i,j) + weight(pixel);
            end
        end
    end
    
    for i=1:img_w
        for j=img_h
            hdr_img(i,j) = hdr_img(i,j)/weight_total(i,j);
        end
    end
end