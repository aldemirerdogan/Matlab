%% Vertex code for 2D images
% load imageTest
% x --> {x, x+1, x-1} --> {x, x+1, x-1, x-2, x+2 }
% x --> {y, y+1, y-1} --> {y, y+1, y-1, y-2, y+2 }
% there is a algebraic relationship between the vertex number and scanning
% path through the contour of the shape
%% image acquisition

imageTest = imread('rectangular_36x36.png');
imageTest = imageTest (:,:,1);
imageTest = logical(imageTest);
imshow(imageTest);

%% Contour extracting


% Index of the first noZero pixel
[r,c] = nonZeroIndex(imageTest);
contourF4 = bwtraceboundary(imageTest,[r c],'W',4,Inf,'counterclockwise'); % 4 connectivity index of the contour

imageF4Contour = zeros(size(imageTest,1),size(imageTest,2));
sizeContourF4 = size(contourF4,1);

% reconstruct the image in contourized form
for index=1:sizeContourF4
    imageF4Contour(contourF4(index,1),contourF4(index,2))=1;
end

hold on; plot(contourF4(:,2),contourF4(:,1),'g','LineWidth',2);

%% new approach

vertexVector = zeros(size(contourF4,1)+3,1);
vertex = 1;
directionFlag = [0;0;0;0];

vertexVector(1) = 1;
flag = 1;
traceScalar = 2;
neighbourDepth = 3;
scanningWindow = ones(3,3);
imageF4ContourPadded = padarray(imageF4Contour,[1 1],0,'both');


for indexTrace =1:size(contourF4,1)
    contourIndex = contourF4(indexTrace,1);
    
    for indexTruncate = 1:neighbourDepth
        truncatedRegion = imageF4ContourPadded(contourIndex(1,1)+indexTruncate-1,...
                                               contourIndex(1,2):contourIndex(1,2)+indexTruncate-1);
    end
    for indexNeigbour = 1:neigbourDepth
        imageF4Contour(contourF4(indexTrace+index-1,1),contourF4(indexTrace+index-1,2))= traceScalar;
    end
    flag =flag+1;

end


%% Differential vector generation

% find one-pixel depth differential vector of the contours
differentialVector = zeros(size(contourF4,1),2);
differential2ndVector = zeros(size(contourF4,1),2);
differential3thVector = zeros(size(contourF4,1),2);


for indexDiff = 1:size(contourF4,1)
    differentialVector(indexDiff,:) = contourF4(indexDiff+1,:) - ...
                                      contourF4(indexDiff,:);
    if (indexDiff == size(contourF4,1)-1)
        differentialVector(indexDiff+1,:) = contourF4(end,:) - ...
                                      contourF4(1,:);
        break;
    end
end

for index2ndDiff = 1:size(differentialVector,1)
    differential2ndVector(index2ndDiff,:) = differentialVector(index2ndDiff+1,:)- ...
                                            differentialVector(index2ndDiff,:);
    if (index2ndDiff==size(contourF4,1)-1)
        break;
    end
end

for index3thDiff = 1:size(differential2ndVector,1)
    differential3thVector(index3thDiff,:) = differential2ndVector(index3thDiff+1,:)- ...
                                            differential2ndVector(index3thDiff,:);
    if (index3thDiff==size(contourF4,1)-1)
        break;
    end
end
%%
% initialiaze vertex vector

for indexX = 1:2
        
        contourIndex = contourF4(indexY,:) ;
        contourIndexNext1 = contourF4(indexY+1,:);
        contourIndexNext2 = contourF4(indexY+2,:);
        
        moveDirection1 = contourIndexNext1 - contourIndex;
        moveDirection2 = contourIndexNext2 - contourIndex;
        
        vertex = 1;
        vertexDictionary = [1 2 3];
        moveDictionary = [0 1;-1 1;-1 0;-1 -1;0 -1;1 -1;1 0;1 1];
        
        if ( abs(moveDirection2(1,1))== 2 || abs(moveDirection2(1,2)) == 2 )
           % the case of next pixel are not in the zone of the eight
           % connectivity
           if (moveDirection1 == moveDictionary(1,:))  
                vertex  = cat(2,vertex, vertexDictionary(2));
           elseif (moveDirection1 == moveDictionary(2,:)) 
                vertex  = cat(2,vertex, [vertexDictionary(1) vertexDictionary(3)] );
           elseif (moveDirection1 == moveDictionary(3,:))
                vertex  = cat(2,vertex, [vertexDictionary(1) vertexDictionary(2)] );
           elseif (moveDirection1 == moveDictionary(4,:)) 
                vertex  = cat(2,vertex, [vertexDictionary(1) vertexDictionary(1) ...
                                         vertexDictionary(3)] );
           elseif (moveDirection1 == moveDictionary(5,:)) 
                vertex  = cat(2,vertex, [vertexDictionary(1) vertexDictionary(2)] );
           elseif (moveDirection1 == moveDictionary(5,:))
                vertex  = cat(2,vertex, [vertexDictionary(1) vertexDictionary(1)...
                                         vertexDictionary(3)]);
           elseif (moveDirection1 == moveDictionary(6,:))
                vertex  = cat(2,vertex, [vertexDictionary(2) vertexDictionary(1) ...
                                         vertexDictionary(1) vertexDictionary(2)]);
           elseif (moveDirection1 == moveDictionary(7,:)) 
                vertex  = cat(2,vertex, [vertexDictionary(3)] );
           end
        else 
          bla bla
        end
        
        
        
        
        
        
        
        
        
        if (moveDirection1 == moveDictionary(1,:))
            vertex  = cat(2,vertex, vertexDictionary(2));
        elseif (moveDirection1 == moveDictionary(2))
            vertex = cat(2,vertex, [VertexDictionary(1) VertexDictionary(3)]);
        elseif (moveDirection1 == [-1 0])
             vertex = 1;  
             VertexBuffer= 2;
             vertex = cat(2,vertex, VertexBuffer);
        elseif (moveDirection1 == [-1 -1])
             vertex = 1;  
             VertexBuffer= [1 3];
             vertex = cat(2,vertex, VertexBuffer)
        elseif (moveDirection1 == [0 -1])
             vertex = 1;  
             VertexBuffer= 2;
             vertex = cat(2,vertex, VertexBuffer)
        elseif (moveDirection1 == [1 -1])
             vertex = 1;  
             VertexBuffer= [1 2];
             vertex = cat(2,vertex, VertexBuffer)
        elseif (moveDirection1 == [1 0])
             vertex = 1;  
             VertexBuffer= [1 3];
             vertex = cat(2,vertex, VertexBuffer);
        end

    moveDirection2 = contourIndexMoveDepth2-contourF4(indexY+1,:); 

end