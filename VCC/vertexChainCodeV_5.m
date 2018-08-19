%% Construc a test image
clear all;          %#ok<CLALL>
imageTest= test_images(2);
imageTest = logical(imageTest);
[imageCounter, contour ] = contour_image(imageTest,4);         
[m, n] = size(imageTest);
 %%   

 % Initialize the struct array
vals = ([]);
for i  = 1 : m
    for j = 1 : n
        vals(i, j).kd = 0;
        vals(i, j).gd = 0;
        vals(i, j).kb = 0;
        vals(i, j).gb = 0;
    end
end

% Read the image and construct the output
for i = 2 : m - 1
    for j = 2 : n - 1
        if(imageTest(i,j)==1)
            vals(i, j).kb = imageTest(i - 1, j) + imageTest(i - 1, j - 1) + ...
                            imageTest(i, j - 1) + 1;
            vals(i, j).gb = imageTest(i + 1, j-1) + imageTest(i+1, j ) + ...
                            imageTest(i, j - 1) + 1;
            vals(i, j).gd = imageTest(i, j + 1) + imageTest(i + 1, j + 1) + ...
                            imageTest(i + 1, j) + 1;
            vals(i, j).kd = imageTest(i, j + 1) + imageTest(i - 1, j + 1) + ...
                            imageTest(i - 1, j) + 1;
        end
    end
end


%%
neighbourDepth = 3;
secondDiff = 2;
vertexVector = [];
patternDictionary = pattern_dictionary();
indexFlag = 1;
P_pixel = 1;
C_Pattern = zeros(neighbourDepth,neighbourDepth);  % CURRENT pattern
pattern = patternDictionary;

for indexOuter = 1:3:size(contour,1) % swapping all contour vector
    % determine the direction of the truncated piece
    % ---------------------------------------------------------------------------------------
    %    1)---  2) |   3) |   4)  |  5) _   6 _            
    %              |      |_     _|    |       |
    %              |                   |       |                                                                   
    % ---------------------------------------------------------------------------------------
    % the movement direction of the truncated segments. Obtain shape of the concecutive pixels and direction flooding
    
    % pattern  inf. (1,2,3,4,5,6)  
    C_contourIndex = contour(indexOuter:indexOuter+2,:); % CURRENT counter index array
    C_normalizedTruncatedInd = C_contourIndex - (min(C_contourIndex)-1);
    for in=1:size(C_contourIndex,1)
       C_Pattern(C_normalizedTruncatedInd(in,1), C_normalizedTruncatedInd(in,2))=1;
    end
    
    directionFlag = zeros(2,2);
    
    C_contourIndex = contour(indexOuter:indexOuter+secondDiff,:);
    for indexDirectionFlag=1:secondDiff
        directionFlag(indexDirectionFlag,:) = [(C_contourIndex(2,indexDirectionFlag) - C_contourIndex(1,indexDirectionFlag))...
                                               (C_contourIndex(3,indexDirectionFlag) - C_contourIndex(2,indexDirectionFlag))];          
    end
    
    %%*----- 1 ------*
    if ( sum( sum( C_Pattern - pattern(1).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(1).direction(:,:,1))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
    elseif ( sum( sum( C_Pattern - pattern(1).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(1).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kd);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
        
    %%*----- 2 ------*        
    elseif ( sum( sum( C_Pattern - pattern(2).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(2).direction(:,:,1))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.gd);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
    elseif ( sum( sum( C_Pattern - pattern(2).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(2).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end

        %%*----- 3 ------*
    elseif ( sum( sum( C_Pattern - pattern(3).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(3).direction(:,:,1))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.gb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
    elseif ( sum( sum( C_Pattern - pattern(3).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(3).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kd);  
            
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
           
    %%*----- 4 ------*       
    elseif ( sum( sum( C_Pattern - pattern(4).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(4).direction(:,:,1))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.gb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
    elseif ( sum( sum( C_Pattern - pattern(4).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(4).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kd);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;    
        end
        
    %%*----- 5 ------*
    elseif ( sum( sum( C_Pattern - pattern(5).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(5).direction(:,:,1))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.gd);  
            x = C_contourIndex(indexOuter+1,1);
            y = C_contourIndex(indexOuter+1,2);
        end
    elseif ( sum( sum( C_Pattern - pattern(5).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(5).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end

    %%*----- 6 ------*
    elseif ( sum( sum( C_Pattern - pattern(6).template))== 0 && ...
         sum( sum( directionFlag - patternDictionary(6).direction(:,:,1))) == 0)
         x = C_contourIndex(1,1);
         y = C_contourIndex(1,2);
         for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.kb);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
         end
    elseif ( sum( sum( C_Pattern - pattern(6).template))== 0 && ...
        sum( sum( directionFlag - patternDictionary(6).direction(:,:,2))) == 0)
        x = C_contourIndex(1,1);
        y = C_contourIndex(1,2);
        for indexInner = 1:size(C_contourIndex,1) % determine (3 pixels) vertex valueshesap 
            fieldValue = vals(x,y);
            vertexVector = cat(2,vertexVector,fieldValue.gd);  
            x = C_contourIndex(indexOuter+1,1) ;
            y = C_contourIndex(indexOuter+1,2) ;
        end
    end
    
end % end of outer index for swapping contour vector
 
%% test image function
function imageTest = test_images(imageNumber)
    switch imageNumber
        case 1
        imageTest = [0 0 0 0 0 0;
                     0 1 1 1 1 0;
                     0 1 0 0 1 0;
                     0 1 0 0 1 0;
                     0 1 1 1 1 0;
                     0 0 0 0 1 0];
        case 2  
        imageTest = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0;
                     0 0 0 0 0 1 1 0 1 1 0 0 0 0 0;
                     0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                     0 0 0 1 1 0 0 0 0 0 1 1 0 0 0;
                     0 0 1 1 0 0 0 0 0 0 0 1 1 0 0;
                     0 1 1 0 0 0 0 0 0 0 0 0 1 1 0;
                     0 1 0 0 0 0 0 0 0 0 0 0 0 1 0;
                     0 1 1 0 0 0 0 0 0 0 0 0 1 1 0;
                     0 0 1 1 0 0 0 0 0 0 0 1 1 0 0;
                     0 0 0 1 1 0 0 0 0 0 1 1 0 0 0;
                     0 0 0 0 1 1 0 0 0 1 1 0 0 0 0;
                     0 0 0 0 0 1 1 0 1 1 0 0 0 0 0;
                     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        case 3
        imageTest=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                   0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0;
                   0 1 0 0 0 0 0 0 0 0 0 1 1 0 0 0;
                   0 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0; 
                   0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0;
                   0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 0;
                   0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 0;
                   0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0;
                   0 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0;
                   0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0;
                   0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0;
                   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
               
        case 4
        imageTest = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                     0 0 0 0 1 1 1 0 0 0 0 0 0 0 0;
                     0 0 0 1 1 0 1 1 0 0 0 0 0 0 0;
                     0 0 1 1 0 0 0 1 1 0 1 0 0 0 0;
                     0 1 1 0 0 0 0 0 1 1 1 1 1 1 0;
                     0 1 0 0 0 0 0 0 0 0 0 0 1 0 0;
                     0 1 0 0 0 0 0 0 0 0 0 0 1 0 0;
                     0 1 1 0 0 0 0 0 0 0 0 1 1 0 0;
                     0 0 1 1 0 0 0 0 0 0 1 1 0 0 0;
                     0 0 0 1 1 0 0 0 0 0 1 0 0 0 0;
                     0 0 0 0 1 1 1 1 1 1 1 0 0 0 0;
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
    end
end
