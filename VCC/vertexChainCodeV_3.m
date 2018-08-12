
% Construc a test image
imagetest = [0 0 0 0 0 0;
             0 1 1 1 1 0;
             0 1 0 0 1 0;
             0 1 0 0 1 0;
             0 1 1 1 1 0;
             0 0 0 0 1 0];
imagetest = logical(imagetest);
[imageCounter, contour ] = contour_image(imagetest,4);         
[m, n] = size(imagetest);
     
% Initialize the struct array
vals = ([]);
for i  = 1 : m
    for j = 1 : n
        vals(i, j).kd = 0;
        vals(i, j).gd = 0;
        vals(i, j).kb = 0;
        vals(i, j).gb = 0;
    end
end

% Read the image and construct the output
for i = 2 : m - 1
    for j = 2 : n - 1
        if(imagetest(i,j)==1)
            vals(i, j).kd = imagetest(i - 1, j) + imagetest(i - 1, j - 1) + ...
                            imagetest(i, j - 1) + 1;
            vals(i, j).kb = imagetest(i - 1, j) + imagetest(i - 1, j + 1) + ...
                            imagetest(i, j + 1) + 1;
            vals(i, j).gb = imagetest(i, j + 1) + imagetest(i + 1, j + 1) + ...
                            imagetest(i + 1, j) + 1;
            vals(i, j).gd = imagetest(i, j - 1) + imagetest(i + 1, j - 1) + ...
                            imagetest(i + 1, j) + 1;
        end
    end
end

vertexVector = [];

for index = 1: size(contour,1)
    fieldValue = vals(contour(index,1),contour(index,2));
    vertexVector = cat(2,vertexVector,fieldValue.kd);
    
end
