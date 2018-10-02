function [] = optimisation(img,H)
% this function makes it possible to look for 
% an optimization of a, b, c  in the following calculation: 
% C = a * imR + b * imG + c * imB, which makes it possible 
% to find an RGB image comparable to an infrared image.

    
    % Binarization of the second image.

    imR = img(:,:,1);
    imG = img(:,:,2);
    imB = img(:,:,3);
    
    [height, width] = size(img);
    
%     Ans = height*width;
    Ans = 0;

    % Course of a, b, c possible.
    a = 1;
    while ( a>0.01 )

        b = 1;
        while ( b>0.01 )

            c = 1;
            while ( c>0.01 )

                if ((a+b+c) <= 1)
                    % Creating the image with the a, b, c.
                    C = a * imR + b * imG + c * imB;
%                     C  = imadjust(C);
                    
                    % Binarization
                    C = binarize(img,C);

                    diff = difference(C,H);
                    

                    % Search for the lowest difference according to a, b
                    % and c.
                    if (Ans <= diff)
                        Ans = diff;
                        rep1 = a;
                        rep2 = b;
                        rep3 = c;
                        
                    end
                end
                c = c-0.1;
            end
            b = b-0.1;
        end
        a = a-0.1;
    end
    
    % Answer.
    disp('difference = ')
    disp(Ans)
    
    disp('a = ')
    disp(rep1)
    
    disp('b = ')
    disp(rep2)
    
    disp('c = ')
    disp(rep3)
end

