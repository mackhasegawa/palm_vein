function [erodedBW] = binarize(im,img)

% Display image
% figure,subplot(3,3,1),imshow(im),title('Basic image');

% Display grayscale
I = img;
% subplot(3,3,2), imshow(I),title('Grayscale image');

% Applying median filter to remove noise
K = medfilt2(I);
% subplot(3,3,3),imshow(K), title('Median filtering');

% Applying CLAHE
J = adapthisteq(I,'clipLimit',0.06,'Distribution','rayleigh');
% subplot(3,3,4),imshow(J), title('CLAHE');

% Applying median filtering to remove the noise
K1 = medfilt2(J);
% subplot(3,3,5),imshow(K1), title('Median filtering 2');

% Blurring images for accuracy
% Adaptive thresholding
T = adaptthresh(K1, 0.7);
BW = imbinarize(K1,T);
% subplot(3,3,6), imshow(BW), title('Adaptive threshold')

% Dilate image
se1 = strel('line',9,90);
erodedBW = imdilate(BW,se1);
% subplot(3,3,7),imshow(erodedBW), title('Dilated image');

% % Search perimeter
% BW3 = bwperim(erodedBW);
% subplot(3,3,8), imshow(BW3,[]),title('Perimeter');

end

