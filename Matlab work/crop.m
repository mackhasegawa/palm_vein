function [cI] = crop(im)
% This function allows you to crop a square of the image of 
% the hand according to the points drawn.

% Grayscale
I = rgb2gray(im);

% Find the corners
C = corner(I);
compt = 1;
C1 = C(1,:);
i = 2;

% Search for points that are different
while compt<4
    if compt == 3
       if (((C1(1)-10)>C(i,1)) || (C(i,1)>(C1(1)+10))) && (((C1(2)-10)>C(i,2)) || (C(i,2)>(C1(2)+10)))
           if (((C2(1)-10)>C(i,1)) || (C(i,1)>(C2(1)+10))) && (((C2(2)-10)>C(i,2)) || (C(i,2)>(C2(2)+10)))
               if (((C3(1)-10)>C(i,1)) || (C(i,1)>(C3(1)+10))) && (((C3(2)-10)>C(i,2)) || (C(i,2)>(C3(2)+10)))
                   C4 = C(i,:);
                   compt = compt + 1;
               end
           end
       end
    end
    
    if compt == 2
       if (((C1(1)-10)>C(i,1)) || (C(i,1)>(C1(1)+10))) && (((C1(2)-10)>C(i,2)) || (C(i,2)>(C1(2)+10)))
           if (((C2(1)-10)>C(i,1)) || (C(i,1)>(C2(1)+10))) && (((C2(2)-10)>C(i,2)) || (C(i,2)>(C2(2)+10)))
               C3 = C(i,:);
               compt = compt + 1;
           end
       end
    end
    
    if compt == 1
       if (((C1(1)-10)>C(i,1)) || (C(i,1)>(C1(1)+10))) && (((C1(2)-10)>C(i,2)) || (C(i,2)>(C1(2)+10)))
           C2 = C(i,:);
           compt = compt + 1;
       end
    end
    i = i+1;
end

% Put the points in order
% Sorting by x
G1 = [C1(1),C2(1),C3(1),C4(1)];
G2 = [C1(2),C2(2),C3(2),C4(2)];
X1 = [C1(1),C2(1),C3(1),C4(1)];
[u,idx] = sort(X1(1,:));
X1a = X1(:,idx);
D1(1) = find(X1==X1a(1));
D2(1) = find(X1==X1a(2));
D3(1) = find(X1==X1a(3));
D4(1) = find(X1==X1a(4));

% Sorting by y
X2 = [C1(2),C2(2),C3(2),C4(2)];
X2a = [X2(D1(1)),X2(D2(1))];
[u,idx] = sort(X2a(1,:));
X2b = X2a(:,idx);
E1 = find(X2==X2b(1));
E2 = find(X2==X2b(2));
X2c = [X2(D3(1)),X2(D4(1))];
[u,idx] = sort(X2c(1,:));
X2d = X2c(:,idx);
E3 = find(X2==X2d(1));
E4 = find(X2==X2d(2));


% Transform the images so that the points form a square.
movingPoints = [G1(E2) G2(E2); G1(E4) G2(E4); G1(E3) G2(E3); G1(E1) G2(E1)];
fixedPoints = [0 500; 500 500; 500 0; 0 0];
tform = fitgeotrans(movingPoints,fixedPoints,'projective');
I = imwarp(I,tform,'FillValues',255);
im = imwarp(im,tform,'FillValues',255);

% Find the new corners to crop

% Binarisation
bw_img= im2bw(I,0.30);  

% Representation in the form of squares
[B,L] = bwboundaries(bw_img,'noholes');
se1=strel('square',30);
L_erode=imerode(L,se1,'same'); 

% Calculation of the size of the regions
stats =[regionprops(L_erode); regionprops(not(L_erode))];
A=[stats.Area];

idx=find(A==min(A(A~=0)));
C1 = double(stats(3).Centroid);
C2 = double(stats(2).Centroid);

x = C2(1);
y = C2(2);
j = C1(2)-C2(2);

% Cropping of the square.
cI = imcrop(im, [x y j j]);

end

