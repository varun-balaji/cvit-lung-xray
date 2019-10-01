function labelMat = immaskLabel(im,n)
    
    if(size(im,3) > 1)
        im = rgb2gray(im);
    end

    imshow(im)
    hold on
    labelMat = zeros(n,2);
    origin = [floor(size(im,2)/2) floor(size(im,1)/2)];

    for i=1:n
        [labelMat(i,1) labelMat(i,2)] = ginput(1);
        scatter(labelMat(i,1),labelMat(i,2),60,'k','filled');
    end
    hold off
    %labelMat = labelMat - repmat(origin,[n 1]);
end