function [class] = patternDictionary(index)
    dictionary(1).class = 'a';
    dictionary(1).template = [ 1 0 0; 
                               1 0 0;
                               1 0 0];
                           
    dictionary(2).class = 'b';
    dictionary(2).template =[1 1 1;
                             0 0 0;
                             0 0 0];
                         
    dictionary(3).class = 'c';
    dictionary(3).template =[1 0 0;
                             1 1 0;
                             0 0 0];
                         
    dictionary(4).class = 'd';
    dictionary(4).template =[1 1 0;
                             0 1 0;
                             0 0 0];
                         
    dictionary(5).class = 'e';
    dictionary(5).template =[1 1 0;
                             1 0 0;
                             0 0 0];
                         
    dictionary(6).class = 'f';
    dictionary(6).template =[0 1 0;
                             1 1 0;
                             0 0 0];
    class = dictionary(index);          
end