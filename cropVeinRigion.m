function [IMG] = cropVeinRigion(IMG)
%CROPVEINRIGION この関数の概要をここに記述
%   詳細説明をここに記述
    S= 500;

    imagesc(IMG); colorbar; axis image;
    [x,y] = getpts;
    P = [x y];
    movingPoints = P;
    fixedPoints = [0 0; S 0; 0 S; S S];
    tform = fitgeotrans(movingPoints,fixedPoints,'projective');
    IMG = imwarp(IMG,tform,'FillValues',255);
    
    imagesc(IMG); colorbar; axis image;    
    [x,y] = getpts;
    P = [x y];
    IMG = imcrop(IMG, [P(1,1) P(1,2) P(2,1)-P(1,1) P(2,2)-P(1,2)]);
    
    IMG = imresize(IMG,[256 256]);
    IMG(:,:,1) = imadjust(IMG(:,:,1));
    IMG(:,:,2) = imadjust(IMG(:,:,2));
    IMG(:,:,3) = imadjust(IMG(:,:,3));

end

