function [r,c] = nonZeroIndex(image)
% this file indicate first nonzero pixels locations
             r=0; c=0;
            [Row, Col]= size(image);

            for index1 = 1:Row
                for index2 = 1:Col
                    if(image(index2,index1)==1)
                        r=index1; 
                        c=index2;
                        break;
                    end
                end
            end

end