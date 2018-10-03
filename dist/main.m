%% Main
% In this script, I try to optimize the equation from french palm image

% Load images
im = imread('squareIR5.jpeg');
im2 = imread('square4.jpeg');

% Croppping
im = cropIR(im);
im2 = crop(im2);
im2 = imrotate(im2,90);

% Binarisation of NIR image
imBin = binarize(im,rgb2gray(im));

% Optimisation
optimisation(im2,imBin)
