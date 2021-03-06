function [C1,C2,C3,C4] = searchCorner2(IMG,bw_thres)
% This function allows to find the points on a hand
% Before transformation with japanese hand
% For NIR image

% Grayscale
IMG = rgb2gray(IMG);

% Binarisation
BW = im2bw(IMG,bw_thres);  
imagesc(BW); colorbar;  axis image;
pause;

% Representation in the form of squares
[B,L] = bwboundaries(BW,'noholes');
se1=strel('square',20);
L_erode=imerode(L,se1,'same'); 

% Calculation of the size of the regions
stats =[regionprops(L_erode); regionprops(not(L_erode))];
A=[stats.Area];

% Search for similar points and tabulation of regions of similar size
[k,n] = size(A);
i = n;
L = zeros(n);
while i>0
    j = n;
    while j>0
        if A(i)>(A(j)-700) && A(i)<(A(j)+700)
            L(i,j)=A(j);
        end
        j = j-1;
    end
    i = i-1;
end

% Search in the rows table with 4 similar values
i = n;
cb = 0;
found = false;
while i>1 && found == false
    cb = size(find(L(i,:)~=0));
    if cb(2) == 4
        found = true;
    end
    i = i-1;
end
l = i+1;

% Search positions of these 4 regions
m = find(L(l,:)~=0);

P = 2; %find(A==L(l,m(1)))
C1 = double(stats(P(1)).Centroid);
P = 3; %find(A==L(l,m(2)))
C2 = double(stats(P(1)).Centroid);
P = 4; %find(A==L(l,m(3)))
C3 = double(stats(P(1)).Centroid);
P = 5; %find(A==L(l,m(4)))
C4 = double(stats(P(1)).Centroid);

end

