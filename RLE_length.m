function [rle_stream, rle_bpp] = RLE_length(data)

% Initialize scanned vector
b_buffer = data;
I_buffer = data;
L = length(I_buffer);
index=1;
rle(index)=1;

%% 2. RUN: Calculate the frequency of the pixels of scanned vector
for i=1:L-1
    if I_buffer(i)==I_buffer(i+1) % Current pixel is same colour with next pixel ?
        rle(index)=rle(index)+1;  % run the same colour
    else                          % increase the index
        index=index+1;
        rle(index)=1;
    end
end
%% RLE, code stream of the compressed data
% obtained the full code with number of 1s and 0s for binary input
% RLE = zeros(1,2*length(rle));
% j=1;
% i=1;
% for k=1:floor(length(rle)/2)
%             RLE(i)=0;
%             RLE(i+1) = rle(j);
%             RLE(i+2)=1;
%             RLE(i+3)=rle(j+1);
%             i=i+4;
%             j=j+2;
%         if(mod(length(RLE),4)==2)
%              RLE(end) = rle(end);
%         end
% end

%% code efficiency

if sum(size(size(b_buffer))) == 3  % gray level image

    % determine the class and size of the image
    [N,M] = size(b_buffer);
    I_class = class(b_buffer);

    % obtain the L according to bit depth
    switch I_class
        case 'logical'
            L_bit = 8;
        case 'double'
            L_bit = 8;
        case 'uint8'
            L_bit=8;
        case 'uint16'
            L_bit=16;
        otherwise
            disp('Uncategorized class of variable')
    end
else % not gray level image, display the ERROR message
   error_message = 'Input image is RGB image. Input must be gray level!!!';
    error(error_message);

end

rle_bpp = (length(2*rle)*L_bit)/(M*N);
rle_stream = rle;

end