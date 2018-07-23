function [r,c] = nonZeroIndex(image)
% this file indicate first nonzero pixels locations
    % convert to logical form
    image = logical (image);

     r=0; c=0;  % initialize variables
    [Row, Col]= size(image);

    for index1 = 1:Col  % scan row
        for index2 = 1:Row  % scan colums
            if(image(index1,index2)==1)
                r=index1; 
                c=index2;
                break;
            end
        end
    end

end