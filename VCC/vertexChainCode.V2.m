%% Vertex code for 2D images
% load imageTest
% x --> {x, x+1, x-1} --> {x, x+1, x-1, x-2, x+2 }
% x --> {y, y+1, y-1} --> {y, y+1, y-1, y-2, y+2 }
% there is a algebraic relationship between the vertex number and scanning
% path through the contour of the shape
%% image acquisition
% 4-pixel group and connect the next to previous one
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

%% new approach: 3x3 window swapping
% initialization
directionFlag = [0;0;0;0];
vertexVector(1) = 1;
flag = 1;
traceScalar = 2;
neighbourDepth = 3;
scanningWindow = ones(neighbourDepth,neighbourDepth);
imageF4ContourPadded = padarray(imageF4Contour,[1 1],0,'both'); % one pixel padding
vertexVector = zeros(size(contourF4,1)+neighbourDepth ,1);
vertexDictionary = zeros(3,3,5);

% Define vertex dictionary elements
vertexDictionary(:,:,1) = [1 0 0; 1 0 0; 1 0 0]; vertexDictionary(:,:,2) = [0 1 0; 1 1 0; 0 0 0];
vertexDictionary(:,:,3) = [1 0 0; 1 1 0; 0 0 0]; vertexDictionary(:,:,4) = [1 1 0; 0 1 0; 0 0 0];
vertexDictionary(:,:,5) = [1 1 1; 0 0 0; 0 0 0];

for indexTrace =1:size(contourF4,1)
    contourIndex = contourF4(indexTrace:indexTrace+2,:);
    matrixBuffer = zeros(neighbourDepth,neighbourDepth);
    normalizedTruncatedInd = contourIndex - (min(contourIndex)-1);
    
    for in=1:size(normalizedTruncatedInd,1)
        matrixBuffer(normalizedTruncatedInd(in,1), normalizedTruncatedInd(in,2))=1;
    end
    
    for indDictSearch = 1:size(vertexDictionary,3)
        if(sum(sum(vertexDictionary(:,:,indDictSearch).*matrixBuffer)) == neighbourDepth );
            dictFlag = indDictSearch;
            break;
        end
    end
    
    vertexDictSymbol = 
    
    truncatedRegionBuffer = imageF4ContourPadded(contourIndex(1,1):contourIndex(1,1)+indexTruncate,...
                                                 contourIndex(1,2):contourIndex(1,2)+indexTruncate);
 
    for indexNeigbour = 1:neigbourDepth
        imageF4Contour(contourF4(indexTrace+index-1,1),contourF4(indexTrace+index-1,2))= traceScalar;
    end
    flag =flag+1;

end




  