function [C1,C2,C3,C4] = searchCorner3(img)
% This function allows to find the points on a hand
% After transformation with japanese hand
% For NIR image

% Grayscale
gray_img = rgb2gray(img);

% Binarisation
bw_img= im2bw(gray_img,0.03);  

bw_img = im2bw(gray_img,0.5);  

% Representation in the form of squares
[B,L] = bwboundaries(bw_img,'noholes');
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
        if A(i)>(A(j)-350) && A(i)<(A(j)+350)
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
C1 = double(stats(find(A==L(l,m(1)))).Centroid);
C2 = double(stats(find(A==L(l,m(2)))).Centroid);
C3 = double(stats(find(A==L(l,m(3)))).Centroid);
C4 = double(stats(find(A==L(l,m(4)))).Centroid);
end

