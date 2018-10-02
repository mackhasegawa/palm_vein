%% Main 2 :
% This script allows search optimization of the equation 
% from a palm of a Japanese hand

% Load images
im = imread('squareIRJ2.jpeg');
im2 = imread('squareJ2.jpeg');

% Croppping
im = cropIR2(im);
im2 = crop2(im2);
im2 = imrotate(im2,90);

% Display the croped images
figure,
subplot(1,2,1), imshow(im), title('NIR image cropped')
subplot(1,2,2), imshow(im2), title('RGB image cropped')

% Binarisation of NIR image
imBin = binarize(im,rgb2gray(im));

% Optimisation
optimisation(im2,imBin)
