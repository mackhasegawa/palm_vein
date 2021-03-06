%% Main 2 :
% This script allows search optimization of the equation 
% from a palm of a Japanese hand

% Load images
IMG = imread('00000000.bmp');
% Croppping
bw_thres = 0.05; % 調整必要
IMG = cropIR2(IMG,bw_thres);
IMG = imresize(IMG,[256 256]);
IMG(:,:,1) = imadjust(IMG(:,:,1));
IMG(:,:,2) = imadjust(IMG(:,:,2));
IMG(:,:,3) = imadjust(IMG(:,:,3));
imagesc(IMG); colorbar; axis image;
pause;
IMG0 = IMG;

% Load images
IMG = imread('10000000.bmp');
% Croppping
bw_thres = 0.1; % 調整必要
IMG = cropIR2(IMG,bw_thres);
IMG = imresize(IMG,[256 256]);
IMG(:,:,1) = imadjust(IMG(:,:,1));
IMG(:,:,2) = imadjust(IMG(:,:,2));
IMG(:,:,3) = imadjust(IMG(:,:,3));
imagesc(IMG); colorbar; axis image;
pause;

IMG = [IMG IMG0];
imwrite(IMG,'20000000.jpg')
imagesc(IMG); colorbar; axis image;
pause;


