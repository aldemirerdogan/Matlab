function [] = contour_image(inputImage, connectivity)
% Extracting 4 or 8 connectivity boundary of a image
inputImage = inputImage (:,:,1);
inputImage = logical(inputImage);

%% Contour extracting
% Index of the first noZero pixel
[r,c] = nonZeroIndex(inputImage);
contourF4 = bwtraceboundary(inputImage, [r c],'W', connectivity, Inf, 'counterclockwise'); % 4 connectivity index of the contour

imageF4Contour = zeros(size(inputImage,1),size(inputImage,2));
sizeContourF4 = size(contourF4,1);

% reconstruct the image in contourized form
for index=1:sizeContourF4
    imageF4Contour(contourF4(index,1),contourF4(index,2))=1;
end
imshow(imageF4Contour);
% hold on; plot(contourF4(:,2),contourF4(:,1),'g','LineWidth',2);

end
