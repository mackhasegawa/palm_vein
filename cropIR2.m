function [IMG] = cropIR2(IMG,bw_thres)
% This function allows you to crop a square of the image of 
% the hand according to the points drawn.
% Debug by hasegawa

img_size = 500;

% Grayscale
I = rgb2gray(IMG);

% Find corners of the square
[C1,C2,C3,C4] = searchCorner2(IMG,bw_thres);

% Bub fix by hasegawa
C1(3) = fix(C1(1)/size(IMG,2)*2)*img_size;
C1(4) = fix(C1(2)/size(IMG,1)*2)*img_size;
C2(3) = fix(C2(1)/size(IMG,2)*2)*img_size;
C2(4) = fix(C2(2)/size(IMG,1)*2)*img_size;
C3(3) = fix(C3(1)/size(IMG,2)*2)*img_size;
C3(4) = fix(C3(2)/size(IMG,1)*2)*img_size;
C4(3) = fix(C4(1)/size(IMG,2)*2)*img_size;
C4(4) = fix(C4(2)/size(IMG,1)*2)*img_size;

% Transform the two images (RGB and NIR) so that the points form a square.
movingPoints = [C2(1) C2(2); C1(1) C1(2); C3(1) C3(2); C4(1) C4(2)];
% Bug fix by hasegawa
fixedPoints = [C2(3) C2(4); C1(3) C1(4); C3(3) C3(4); C4(3) C4(4)];
tform = fitgeotrans(movingPoints,fixedPoints,'projective');
IMG = imwarp(IMG,tform,'FillValues',255);

% Find the new corners to crop
[C1,C2,C3,C4] = searchCorner2(IMG,bw_thres);

C = fix([C1(1) C1(2); C2(1) C2(2); C3(1) C3(2); C4(1) C4(2)]);
P = fix([C(1,1)+C(1,2); C(2,1)+C(2,2); C(3,1)+C(3,2); C(4,1)+C(4,2)]);
P2 = (P==min(P));
P3 = find(P2);
P2 = (P==max(P));
P4 = find(P2);

IMG = imcrop(IMG, [C(P3,1) C(P3,2) C(P4,1)-C(P3,1) C(P4,2)-C(P3,2)]);

end

