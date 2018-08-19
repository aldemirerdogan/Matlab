%% Construc a test image
clear all;          %#ok<CLALL>
imagetest= test_images(2);
imagetest = logical(imagetest);
[imageCounter, contour ] = contour_image(imagetest,4);         
[m, n] = size(imagetest);
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
        if(imagetest(i,j)==1)
            vals(i, j).kb = imagetest(i - 1, j) + imagetest(i - 1, j - 1) + ...
                            imagetest(i, j - 1) + 1;
            vals(i, j).gb = imagetest(i + 1, j-1) + imagetest(i+1, j ) + ...
                            imagetest(i, j - 1) + 1;
            vals(i, j).gd = imagetest(i, j + 1) + imagetest(i + 1, j + 1) + ...
                            imagetest(i + 1, j) + 1;
            vals(i, j).kd = imagetest(i, j + 1) + imagetest(i - 1, j + 1) + ...
                            imagetest(i - 1, j) + 1;
        end
    end
end
%%
secondDiff = 2;
vertexVector = [];
patternDictionary = pattern_dictionary();
indexFlag = 1;

for index = 1:size(contour,1)
       
    directionFlag = zeros(2,2);
    
    C_contourIndex = contour(index:index+secondDiff,:);
    for indexDirectionFlag=1:secondDiff
        directionFlag(indexDirectionFlag,:) = [(C_contourIndex(2,indexDirectionFlag) - C_contourIndex(1,indexDirectionFlag))...
                                               (C_contourIndex(3,indexDirectionFlag) - C_contourIndex(2,indexDirectionFlag))];          
    end

    fieldValue = vals(C_contourIndex(index,1),C_contourIndex(index,2));

    if (sum(sum(directionFlag - patternDictionary(1).direction(:,:,1)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
    elseif (sum(sum(directionFlag - patternDictionary(1).direction(:,:,2)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);

    elseif (sum(sum(directionFlag - patternDictionary(2).direction(:,:,1)))== 0)
        if (localCounter == 1)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
        end
        localCounter = 0;
        vertexVector = cat(2,vertexVector,fieldValue.gd);
    elseif (sum(sum(directionFlag - patternDictionary(2).direction(:,:,2)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);

    elseif (sum(sum(directionFlag - patternDictionary(3).direction(:,:,2)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
    elseif (sum(sum(directionFlag - patternDictionary(3).direction(:,:,1)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);

    elseif (sum(sum(directionFlag - patternDictionary(4).direction(:,:,2)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
    elseif (sum(sum(directionFlag - patternDictionary(4).direction(:,:,1)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);

    elseif (sum(sum(directionFlag - patternDictionary(5).direction(:,:,2)))== 0)
       if (localCounter == 1)
        vertexVector = cat(2,vertexVector,fieldValue.gd);
        end
        localCounter = 0;
        vertexVector = cat(2,vertexVector,fieldValue.gb);
    elseif (sum(sum(directionFlag - patternDictionary(5).direction(:,:,1)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);

    elseif (sum(sum(directionFlag - patternDictionary(6).direction(:,:,2)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
    elseif (sum(sum(directionFlag - patternDictionary(6).direction(:,:,1)))== 0)
        vertexVector = cat(2,vertexVector,fieldValue.kd);
    end
  
end
 
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
               
        
    end
end
