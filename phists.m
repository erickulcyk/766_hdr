function phists(img)
    figure('Name','Red histogram');
    hist(img(:,:,1));
    figure('Name','Blue histogram');
    hist(img(:,:,3));
    figure('Name','Green histogram');
    hist(img(:,:,2));
    