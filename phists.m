function phists(img)
    figure('Name','Red histogram');
    hist(img(:,:,1));
    set(gca,'XScale','log');
    figure('Name','Blue histogram');
    hist(img(:,:,3));
    set(gca,'XScale','log');
    figure('Name','Green histogram');
    hist(img(:,:,2));
    set(gca,'XScale','log');
    