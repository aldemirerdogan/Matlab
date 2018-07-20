function  [scanned_matrix]= scan_form(image,select)
%% matrix to vector function
% input : matrix, image
% output: vector (1D)
% scan_form_2D(image,'parameter')
% parameter :   1--> spiral wise scan
%               2--> row wise scan
%               3--> column wise scan
%               4--> chevron wise scan
%               5--> zigzag wise scan
% Author: Erdogan Aldemir, July, 2017

    I = image ;
    % size of raw image
    [r_size,c_size] = size(I);
    switch select
    case 'spiral'
        % Inýtialize the input, row number must be less than colomn : m>=n
        if (c_size>r_size)
           I = I'; 
        end
        %% Example2 
        % I=imread('binaryLiver.png');
        % A= im2bw(I,0.1);
        % assign the input image
        % Initialize the variables
        I_vector = I(1,1:end-1);
        b_buffer = I;
        
        for i=1:(round(c_size/2))
            
            for j=90:90:270
                
                if(isscalar(I)==0 && sum(size(I)))
                        I_rotate = imrotate(I,j);
                        I_buffer = I_rotate(1,1:end-1);
                        I_vector = cat(2,I_vector,I_buffer);
                else
                        I_vector = cat(2,I_vector,b_buffer((round(r_size/2)),(round(r_size/2))));
                break
                end 
                
            end
            
            I = I(2:end-1,2:end-1);
            
            if(sum(size(I)~=0))
                I_vector = cat(2,I_vector,I(1,1:end-1));
            end
        %     if(sum(size(I))==0)
        %     I_vector_buffer = I(1,1);
        %     I_vector = cat(2,I_vector,I_vector_buffer);
        %     end
        end
        % Initialize scanned vector

        scanned_matrix = I_vector(1,1:(r_size*c_size));

        
 
%% Rowwise scan form
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    case 'row'
        
        I_vector = I(1,:);
        for i=2:r_size
            I_buffer = I(i,:);
            I_vector = cat(2,I_vector,I_buffer);
        end
        scanned_matrix = I_vector;
      
 %% Columnwise scan form 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   
    case 'column'
        clear I_vector
        I_vector = I(:,1)';
        for i=2:r_size
            I_buffer = I(:,i)';
            I_vector = cat(2,I_vector,I_buffer);
        end
        scanned_matrix = I_vector;
 
        
   case 'chevron'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        %% new scan form chevron
        % [1  17 16  4  5 13 12  8  9;
        % 18   2  3 15 14  6  7 11 10;
        % [19 35 34 22 23 31 30 26 27;
        %  36 20 21 33 32 24 25 29 28]
        % MATRIS
        % |---|---|---|---|---|---|---|---|---| 
        % | 1 | 17| 16| 4 | 5 | 13| 12| 8 | 9 |
        % |---|---|---|---|---|---|---|---|---|  
        % | 18| 2 | 3 | 15| 14| 6 | 7 | 11| 10|
        % |---|---|---|---|---|---|---|---|---|
        % | 19| 35| 34| 22| 23| 31| 30| 26| 27|
        % |---|---|---|---|---|---|---|---|---|
        % | 36| 20| 21| 33| 32| 24| 25| 29| 28|
        % |---|---|---|---|---|---|---|---|---|

        % vector: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36

        % image data is input


        
        data = image;
        [r_size,c_size] = size(data);
        % Initialize variables
        vector_final = [];
        counter = 0;
          
        if(mod(r_size,2)==1)
            counter = 1;
            buffer_chevron = data(end:end,:);
            data = data(1:end-1,:);
        end
        
        
        %% iteration of whole matrix
    
        [r_size,c_size] = size(data);
        
        for iter_new = 1:2:r_size
            % initialize vectors and variables for first elements
            vector = zeros(1,(c_size));
            vector_2 = zeros(1,(c_size));
            vector(1,1) = data(0+iter_new,1);  
            a_iter =2;
            % loop for first scan          
            for r_iter = 1:4:c_size
                % first loop iteration
                if(a_iter<=c_size)
                    for b_iter = 1:2
                        if(a_iter<=c_size)
                            vector(a_iter)=data(1+iter_new,a_iter);  % assign elements matrix to vector
                            a_iter = a_iter+1;
                        end
                    end
                end
                % second loop iteration
                if(a_iter<=c_size)
                    for b_iter = 1:2
                        if(a_iter<=c_size) 
                            vector(a_iter)=data(0+iter_new,a_iter); % assign elements matrix to vector
                            a_iter = a_iter+1;
                        end
                    end
                end
           end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

           % initialize vectors and variables 
           vector_2(1,1) = data(1+iter_new,1);  
           a_iter =2;

           % loop for first scan
           for r_iter = 1:4:c_size
                % first loop iteration
                 if(a_iter<=c_size)
                    for b_iter = 1:2
                          if(a_iter<=c_size)
                            vector_2(a_iter)=data(0+iter_new,a_iter); % assign elements matrix to vector
                            a_iter = a_iter+1;
                          end
                    end
                 end

                % second loop iteration
                 if(a_iter<=c_size)
                    for b_iter = 1:2
                         if(a_iter<=c_size)
                            vector_2(a_iter)=data(1+iter_new,a_iter);% assign elements matrix to vector
                            a_iter = a_iter+1;
                         end
                    end
                 end
           end

            % reverse the vectors to satisfy scan form of second scan iteration
            vector_22 = [];
            [~, c_vector_2] = size(vector_2);

            for iter_rev = 1:c_vector_2
                vector_22(1,c_vector_2) = vector_2(1,iter_rev);
                c_vector_2 = c_vector_2-1;
            end

            % concatenating vectors
            vector_buffer = [vector vector_22];
            vector_final = cat(2,vector_final,vector_buffer);

        end
        
        % assign the output
        if (counter == 1)
            vector_final = [vector_final  buffer_chevron ];            
        end
        
        scanned_matrix = vector_final;
        
         %% ZIGZAG SCANNING      
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   case 'zigzag'
            
        x = image; 
        r=1;
        c=1;
        [m,n]=size(x);
        counter=1;
        vector=zeros(1,m*n);

        while counter~=m*n
            if r==1 && c~=n
                vector(1,counter)=x(r,c);
                counter=counter+1;
                c=c+1;
                while c~=1 && r~=m
                    vector(1,counter)=x(r,c);
                    counter=counter+1;
                    r=r+1;
                    c=c-1;
                end
            elseif c==1 && r~=m
                vector(1,counter)=x(r,c);
                counter=counter+1;
                r=r+1;
                while r~=1 && c~=n
                    vector(1,counter)=x(r,c);
                    counter=counter+1;
                    r=r-1;
                    c=c+1;
                end
            elseif c==n
                vector(1,counter)=x(r,c);
                counter=counter+1;
                r=r+1;
                while r~=m && c~=1
                    vector(1,counter)=x(r,c);
                    counter=counter+1;
                    r=r+1;
                    c=c-1;
                end
            elseif r==m
                vector(1,counter)=x(r,c);
                counter=counter+1;
                c=c+1;
                while c~=n && r~=1
                    vector(1,counter)=x(r,c);
                    counter=counter+1;
                    r=r-1;
                    c=c+1;
                end
            end
        end

        vector(1,m*n)=x(m,n);   
        scanned_matrix = vector;
    end  
    
    
end