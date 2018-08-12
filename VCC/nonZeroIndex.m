function [r,c] = nonZeroIndex(image)
    %% this file indicate first nonzero pixels locations
    % convert to logical form 
    % new brach 
    image = logical (image);

     r=0; c=0;  % initialize variables
     flag = 0;
    [Row, Col]= size(image);

    for index1 = 1:Row  % scan row
        if (flag == 1)
            break
        end
        for index2 = 1:Col  % scan colums
            if(image(index1,index2)==1)
                r=index1; c=index2;
                flag = 1;
                break;
            end
        end
    end
% end of function 
end
