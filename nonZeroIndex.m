function [r,c] = nonZeroIndex(image)
% this file indicate first nonzero pixels locations
             r=0; c=0;  % initialize variables
            [Row, Col]= size(image);

            for index1 = 1:Row  % scan row
                for index2 = 1:Col  % scan colums
                    if(image(index2,index1)==1)
                        r=index1; 
                        c=index2;
                        break;
                    end
                end
            end

end