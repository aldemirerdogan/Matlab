%% Vertex code for 2D images
% load imageTest
% x --> {x, x+1, x-1} --> {x, x+1, x-1, x-2, x+2 }
% x --> {y, y+1, y-1} --> {y, y+1, y-1, y-2, y+2 }
% there is a algebraic relationship between the vertex number and scanning
% path through the contour of the shape

%% new approach: 3x3 window swapping
% initialization
directionFlag = [0;0;0;0];
flag = 1;
traceScalar = 2;
neighbourDepth = 3;
scanningWindow = ones(neighbourDepth,neighbourDepth);
% imageF4ContourPadded = padarray(imageF4Contour,[1 1],0,'both'); % one pixel padding
vertexVector = zeros(size(contourF4,1)+neighbourDepth ,1);
previousClass = 0; % initialiaze class value

for indexTrace =1:2:size(contourF4,1)
    contourIndex = contourF4(indexTrace:indexTrace+2,:);
    normalizedMatrixBuffer = zeros(neighbourDepth,neighbourDepth);
    normalizedTruncatedInd = contourIndex - (min(contourIndex)-1);
    % determine the direction of the truncated piece
    % ------------------------------------------------------------------------------------------
    %    |           | : (0,+2)   |               | :(+1,+1)             |      |: (+1,-1)
    %    |           |            |_ : (-1,-1)    |_           (-1,+1): _|     _|
    %    | :(0,-2)   |                                                                 
    % ------------------------------------------------------------------------------------------
    for in=1:size(normalizedTruncatedInd,1)
        normalizedMatrixBuffer(normalizedTruncatedInd(in,1), normalizedTruncatedInd(in,2))=1;
    end
    
    for indDictSearch = 1:5
        vertexDictionary = dictionarySymbol(indDictSearch);
        if(sum(sum((vertexDictionary.template.*normalizedMatrixBuffer)) == neighbourDepth ))
            previousClass = vertexDictionary.class;
            dictFlag = indDictSearch;
        end
        break;
    end
    
    structResult = dictionarySymbol(dictFlag);
    vertexResult = structResult.symbol;
    vertexVector = cat(2,vertexVector, vertexResult );
end




  
