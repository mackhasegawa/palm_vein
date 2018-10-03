function [diff] = difference(inputArg1,inputArg2)
% This function takes in two binary images 
% and returns the difference between the two.

    C = inputArg1;
    H = inputArg2;

    [height,width] = size(C);
    diff = 0;
    % Course of the image.
    x = height;
    while (x > 0)

        y = width;
        while (y > 0)
            
            % Look for the difference between two pixels.
%             t = ((int64(C(x,y)))-(int64(H(x,y))))^2;
%             diff = diff + (t);
            t = ((int64(C(x,y)))+(int64(H(x,y))))^2;
            if t==4
                diff = diff + (t);
            end
            y = y-1;

        end
        x = x-1;
        
    end
    
    % Return the difference.
    return;
end