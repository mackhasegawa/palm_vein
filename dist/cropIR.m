function [cI] = cropIR(im)
% This function allows you to crop a square of the image of 
% the hand according to the points drawn.

% Grayscale
I = rgb2gray(im);

% Find corners of the square
[C1,C2,C3,C4] = searchCorner(im);



% Transform the two images (RGB and NIR) so that the points form a square.
movingPoints = [C2(1) C2(2); C1(1) C1(2); C3(1) C3(2); C4(1) C4(2)];
fixedPoints = [0 500; 500 500; 500 0; 0 0];
tform = fitgeotrans(movingPoints,fixedPoints,'projective');
im = imwarp(im,tform,'FillValues',255);

% Find the new corners to crop
[C1,C2,C3,C4] = searchCorner(im);

x = C2(1);
y = C2(2);
j = C1(2)-C2(2);

% Cropping of the squares.
cI = imcrop(im, [x y j j]);

end

