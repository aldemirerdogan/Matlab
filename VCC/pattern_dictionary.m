function [pattern] = pattern_dictionary(~)
    % 1st pattern and direction
    dictionary(1).class = 'a';
    dictionary(1).template = [ 1 0 0; 
                               1 0 0;
                               1 0 0];
    dictionary(1).direction(:,:,1) = [ 1  1;
                                      0  0]; 
    dictionary(1).direction(:,:,2) = [-1 -1;
                                       0  0]; 
    % 2nd pattern and direction
    dictionary(2).class = 'b';
    dictionary(2).template =[1 1 1;
                             0 0 0;
                             0 0 0];
    dictionary(2).direction(:,:,1) = [ 0  0;
                                       1  1]; 
    dictionary(2).direction(:,:,2) = [ 0  0;
                                      -1 -1]; 
    % 3rd pattern and direction
    dictionary(3).class = 'c';
    dictionary(3).template =[1 0 0;
                             1 1 0;
                             0 0 0];
    dictionary(3).direction(:,:,1) = [ 0 -1;
                                      -1  0]; 
    dictionary(3).direction(:,:,2) = [ 1  0; 
                                       0  1]; 
    % 4th pattern and direction                    
    dictionary(4).class = 'd';
    dictionary(4).template =[1 1 0;
                             0 1 0;
                             0 0 0];
                         
    dictionary(4).direction(:,:,1) = [ 0  1;
                                       1  0]; 
    dictionary(4).direction(:,:,2) = [-1  0;
                                       0 -1]; 
     % 5th pattern and direction                    
    dictionary(5).class = 'e';
    dictionary(5).template =[1 1 0;
                             1 0 0;
                             0 0 0];
    dictionary(5).direction(:,:,1) = [ 0  1;
                                      -1  0]; 
    dictionary(5).direction(:,:,2) = [-1  0;
                                       0  1]; 
     % 6th pattern and direction                    
    dictionary(6).class = 'f';
    dictionary(6).template =[0 1 0;
                             1 1 0;
                             0 0 0]; 
    dictionary(6).direction(:,:,1) = [ 0 -1;
                                       1  0]; 
    dictionary(6).direction(:,:,2) = [ 1  0;  
                                       0 -1]; 
    for i=1:6
        pattern(:,:,i) = dictionary(i);  %#ok<AGROW>
    end   
end
