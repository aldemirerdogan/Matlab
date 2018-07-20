% Vertex code for 2D images
% load imageTest

[r,c] = nonZeroIndex(imageTest);
contourF4 = bwtraceboundary(imageTest,[r c],'W',4,Inf,'counterclockwise');

imageF4Buffer = zeros(7,7);
sizeContourF4 = size(contourF4,1);

for index=1:sizeContourF4
    x = contourF4(index,1);
    y = contourF4(index,2);
    imageF4Buffer(x,y)=1;
end

vertex = 1;

for indexX = 1:2
    for indexY = 1:2
        
        contourIndex = contourF4(indexY,:) ;
        contourIndexNext1 = contourF4(indexY+1,:);
        contourIndexNext2 = contourF4(indexY+2,:);
        
        moveDirection1 = contourIndexNext1-contourIndex;
        moveDirection2 = contourIndexNext2 - contourIndex;
        
        vertex = 1;
        vertexDictionary = [1 2 3];
        moveDictionary = [0 1;-1 1;-1 0;-1 -1;0 -1;1 -1;1 0;1 1];
        
        if ( abs(moveDirection2(1,1))== 2 || abs(moveDirection2(1,2)) == 2 )
            bla bla
            
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
end