function [C_class] = dictionarySymbol(index, directionFlag)
    % Define vertex dictionary elements as structural data type
    
    % direction flags
    DIRECTION(:,:,1,1)=[ 1  1;
                         0  0]; % 1-a
    DIRECTION(:,:,1,2)=[-1 -1;
                         0  0]; % 1-b
    DIRECTION(:,:,2,1)=[ 0  0;
                         1  1]; % 2-a
    DIRECTION(:,:,2,2)=[ 0  0;
                        -1 -1]; % 2-b
    DIRECTION(:,:,3,2)=[ 0 -1;
                        -1  0]; % 3-a
    DIRECTION(:,:,3,1)=[ 1  0; 
                         0  1]; % 3-b
    DIRECTION(:,:,4,1)=[ 0  1;
                         1  0]; % 4-a
    DIRECTION(:,:,4,2)=[-1  0;
                         0 -1]; % 4-b
    DIRECTION(:,:,5,2)=[ 0  1;
                        -1  0]; % 5-a
    DIRECTION(:,:,5,1)=[-1  0;
                         0  1]; % 5-b
    DIRECTION(:,:,6,1)=[ 0 -1;
                         1  0]; % 6-a
    DIRECTION(:,:,6,2)=[ 1  0;  
                         0 -1]; % 6-b

    
    dictionary(1).class = 'a';
    if (directionFlag == DIRECTION(:,:,1,1) || directionFlag == DIRECTION(:,:,1,2) ) 
        dictionary(1).direction= directionFlag;        
    end
    dictionary(1).template = [ 1 0 0; 
                               1 0 0;
                               1 0 0];
                           
    dictionary(2).class = 'b';
    if (directionFlag == DIRECTION(:,:,2,1) || directionFlag == DIRECTION(:,:,2,2) ) 
        dictionary(2).direction= directionFlag;        
    end
    dictionary(2).template =[1 1 1;
                             0 0 0;
                             0 0 0];
                         
    dictionary(3).class = 'c';
    if (directionFlag == DIRECTION(:,:,3,1) || directionFlag == DIRECTION(:,:,3,2) ) 
        dictionary(3).direction= directionFlag;        
    end
    dictionary(3).template =[1 0 0;
                             1 1 0;
                             0 0 0];
                         
    dictionary(4).class = 'd';
    if (directionFlag == DIRECTION(:,:,4,1) || directionFlag == DIRECTION(:,:,4,2) ) 
        dictionary(4).direction= directionFlag;        
    end
    dictionary(4).template =[1 1 0;
                             0 1 0;
                             0 0 0];
                         
    dictionary(5).class = 'e';
    if (directionFlag == DIRECTION(:,:,5,1) || directionFlag == DIRECTION(:,:,5,2) ) 
        dictionary(5).direction= directionFlag;        
    end
    dictionary(5).template =[1 1 0;
                             1 0 0;
                             0 0 0];
                         
    dictionary(6).class = 'f';
    if (directionFlag == DIRECTION(:,:,6,1) || directionFlag == DIRECTION(:,:,6,2) ) 
        dictionary(6).direction= directionFlag;        
    end
    dictionary(6).template =[0 1 0;
                             1 1 0;
                             0 0 0];
  
    C_class = dictionary(index);
    
end
