
file_name = uigetfile('*');
IMG = imread(file_name);
IMG = cropVeinRigion(IMG);
imagesc(IMG); colorbar; axis image;
pause;
IMG0 = IMG;

file_name = uigetfile('*');
IMG = imread(file_name);
IMG = cropVeinRigion(IMG);
imagesc(IMG); colorbar; axis image;
pause;

IMG = [IMG IMG0];

imwrite(IMG,'result.jpg');
imagesc(IMG); colorbar; axis image;


