% Converts many images to one hdr image
% Time = exposure times array, 1 for each image
% g = solved for function
% weight = weight of each brightness (0..255)
% channel = channel to apply hdr to.
% returns a single hdr image.
function [ hdr_img ] = hdr( hdr_img, imgs, Time, g, weight, channel)

    %o = squeeze(imgs(1,:,:,:));
    %disp(size(o));
    %imshow(o);
    img_size = size(imgs,1);
    img_w = size(imgs,2);
    img_h = size(imgs,3);
    channels = size(imgs,4);
    
    %hdr_img = zeros(img_w,img_h, channels);
    weight_total = zeros(img_w,img_h);
    disp('HDR size:');
    disp(size(hdr_img));
    parfor i=1:img_w
        %disp(i);
        for j=1:img_h
            hdr_img(i,j,channel) = 0;
            for k=1:img_size
                %for l=1:channels
                %    if(l==channel || channel==-1)
                        pixel = imgs(k,i,j,channel)+1;
                        %
                        hdr_img(i,j,channel) = hdr_img(i,j,channel) + weight(pixel)*(g(pixel)-log(Time(k)));
                        weight_total(i,j) = weight_total(i,j) + weight(pixel);
               %     else
                %        pixel = imgs(k,i,j,l);%(k
                        %new_pixel = hdr_img(i,j,l) + pixel/img_size;%weight(pixel+1);
                 %       new_pixel = pixel/img_size;%weight(pixel+1);
                 %       hdr_img(i,j,l) = new_pixel;
                 %   end
                %end
            end
        end
    end
    disp('Done with hdr part 1');
    parfor i=1:img_w
        for j=1:img_h
            %if(channel==-1)
            %    for l=1:channels
            %        hdr_img(i,j,l) = hdr_img(i,j,l)/weight_total(i,j);
           %     end
           % end
           % if (channel>0)
           if(weight_total(i,j) ==0)
               hdr_img(i,j,channel) = 1;
           else
                hdr_img(i,j,channel) = hdr_img(i,j,channel)/weight_total(i,j);
           end
                %if(hdr_img(i,j,channel)<0)
                %    disp(hdr_img(i,j,channel));
                %end
           % end
        end
    end
end