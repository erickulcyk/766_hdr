function phists(img)
    figure('Name','Red histogram');
    imhist(img(:,:,1));
    figure('Name','Blue histogram');
    imhist(img(:,:,3));
    figure('Name','Green histogram');
    imhist(img(:,:,2));
    