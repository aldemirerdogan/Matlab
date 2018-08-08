%% Vertex code for 2D images
% load imageTest
% x --> {x, x+1, x-1} --> {x, x+1, x-1, x-2, x+2 }
% x --> {y, y+1, y-1} --> {y, y+1, y-1, y-2, y+2 }
% there is a algebraic relationship between the vertex number and scanning
% path through the contour of the shape

%% new approach: 3 elements swapping
[imageCounter, contour ] = contour_image(imageTest,4);

% initialization
flag = 1;
traceScalar = 2;
secondDiff = 2;
neighbourDepth = 3;
scanningWindow = ones(neighbourDepth,neighbourDepth);
vertexVector = []; % zeros(size(contour,1)+neighbourDepth ,1);
previousClass = 0; % initialiaze class value

directionFlag = zeros(2,2);
P_Pattern = ones(neighbourDepth, neighbourDepth);  % PREVIOUS pattern
C_Pattern = zeros(neighbourDepth,neighbourDepth);  % CURRENT pattern
N_Pattern = zeros(neighbourDepth,neighbourDepth);  % NEXT pattern initialization

%%
for indexTrace=1:2:size(contour,1)
    % Determine current pattern
    C_contourIndex = contour(indexTrace:indexTrace+2,:); % CURRENT counter index array
    C_normalizedTruncatedInd = C_contourIndex - (min(C_contourIndex)-1);
    for in=1:size(C_contourIndex,1)
       C_Pattern(C_normalizedTruncatedInd(in,1), C_normalizedTruncatedInd(in,2))=1;
    end
    
     % Determine next pattern
    N_contourIndex = contour(indexTrace+2:indexTrace+4,:);
    N_normalizedTruncatedInd = N_contourIndex - (min(N_contourIndex)-1);
    for in=1:size(N_contourIndex,1)
       N_Pattern(N_normalizedTruncatedInd(in,1), N_normalizedTruncatedInd(in,2))=1; 
    end
    
    % determine the direction of the truncated piece
    % ---------------------------------------------------------------------------------------
    %    |           | : (0,+2)   |               | :(+1,+1)             |      |: (+1,-1)
    %    |           |            |_ : (-1,-1)    |_           (-1,+1): _|     _|
    %    | :(0,-2)   |                                                                 
    % ---------------------------------------------------------------------------------------
    % the movement direction of the truncated segments. Obtain shape of the concecutive pixels and direction flooding
    
    for indexDirectionFlag=1:secondDiff
        directionFlag(indexDirectionFlag,:) = [(C_contourIndex(2,indexDirectionFlag) - C_contourIndex(1,indexDirectionFlag))...
                                               (C_contourIndex(3,indexDirectionFlag) - C_contourIndex(2,indexDirectionFlag))];          
    end
    
    for indDictSearch = 1:6
      C_vertexDictionary = dictionarySymbol(indDictSearch, directionFlag);
      if(sum(sum((C_vertexDictionary.template.*C_Pattern)) == neighbourDepth ))
          % direction is another parameter of the symbol determination 
          C_Class = C_vertexDictionary.class;
          dictFlag = indDictSearch;
          break;
      end
    end
    
    for indDictSearch = 1:6
      N_vertexDictionary = dictionarySymbol(indDictSearch, directionFlag);
      if(sum(sum((N_vertexDictionary.template.* N_Pattern)) == neighbourDepth ))
          % direction is another parameter of the symbol determination 
          N_Class = N_vertexDictionary.class;
          dictFlag = indDictSearch;
          break;
      end
    end
       
    pattern = patternDictionary;
    
    if (sum(sum(C_Pattern-N_Pattern))==0 && (sum(sum(C_vertexDictionary.template - pattern(6).template)))==0) 
        if(P_Pattern == 1)
            if(directionFlag == pattern(6).direction(:,:,1))
               vertexVecBuffer = [1 3 1];
            else
               vertexVecBuffer = [1 2 1 3];
            end
            vertexVector = cat(2,vertexVector, vertexVecBuffer);
        elseif (sum(sum(C_Pattern-P_Pattern))==0)
              vertexVector = cat(2,vertexVector, [3 1 ]);
        elseif (P_Pattern == pattern(5).template )
            vertexVector = cat(2,vertexVector, [2 3 1 ]);
        elseif (P_Pattern == pattern(4).template )
            % vertexVector = cat(2,vertexVector, [3 1 ]);
        elseif (P_Pattern == pattern(3).template )
            vertexVector = cat(2,vertexVector, [1 1 3 ]);
        elseif (P_Pattern == pattern(2).template )
            vertexVector = cat(2,vertexVector, [2 1 3 ]);
        elseif (P_Pattern == pattern(1).template )
            vertexVector = cat(2,vertexVector, [3 1 ]);
        end
         
        
        
        
        
        elseif ( (sum(sum(C_vertexDictionary.template-pattern(6).template))) == 0 && ... 
              (sum(sum(N_Pattern-[0 1 0; 1 1 0; 0 0 0]))) == 0)
          
      
    end
   
         
    structResult = dictionarySymbol(dictFlag);
    vertexResult = structResult.symbol;
    vertexVector = cat(2,vertexVector, vertexResult );
    
    P_Pattern = C_Pattern;

    
end



  
