function symbol = dictionarySymbol(index)
    % Define vertex dictionary elements as structural data type

    DIRECTION(:,:,1,1)=[ 1  1;  0  0 ];
    DIRECTION(:,:,1,2)=[ 1  1;  0  0 ];
    DIRECTION(:,:,1,2)=[-1 -1;  0  0 ];
    DIRECTION(:,:,2,1)=[ 0  0;  1  1 ];
    DIRECTION(:,:,2,2)=[ 0  0; -1 -1 ];
    DIRECTION(:,:,3,2)=[ 0 -1; -1  0 ];
    DIRECTION(:,:,3,1)=[ 1  0;  0  1 ];
    DIRECTION(:,:,4,1)=[ 0  1;  1  0 ];
    DIRECTION(:,:,4,2)=[-1  0;  0 -1 ];
    DIRECTION(:,:,5,2)=[ 0  1; -1  0 ];
    DIRECTION(:,:,5,1)=[-1  0;  0  1 ];
    DIRECTION(:,:,6,1)=[ 0 -1;  1  0 ];
    DIRECTION(:,:,6,2)=[ 1  0;  0 -1 ];  %#ok<NASGU>

    
    dictionary(1).class = 'a';
    dictionary(1).symbol = '?';
    dictionary(1).template = [ 1 0 0; 1 0 0; 1 0 0];
    % dictionary(1).direction = 
    
    dictionary(2).class = 'b';
    dictionary(2).symbol = '?';
    dictionary(2).template =[1 1 1; 0 0 0; 0 0 0];
    
    dictionary(2).class = 'c';
    dictionary(2).symbol = '?';
    dictionary(2).template =[1 0 0; 1 1 0; 0 0 0];

    dictionary(3).class = 'd';
    dictionary(3).symbol = '?';
    dictionary(3).template =[1 1 0; 0 1 0; 0 0 0];

    dictionary(4).class = 'e';
    dictionary(4).symbol = '?';
    dictionary(4).template =[1 1 0; 1 0 0; 0 0 0];

    dictionary(5).class = 'f';
    dictionary(5).symbol = '?';
    dictionary(5).template =[0 1 0; 1 1 0; 0 0 0];
    
    symbol = dictionary(index);
end
