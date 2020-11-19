clear, close all

% Read RGB Image
img = imread ('legumes.png');
[width, height, channels] = size(img);

% Convert to Gray Scale
img_gray = rgb2gray(img);
% size(img)

% Add padding with zeros
p_img_gray = double(zeros([width + 2, height + 2]));
p_img_gray(2 : width+1, 2 : height+1) = double(img_gray);

% Compute Laplacian Conv (of p_img_gray)
% kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];

output_img = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        output_img(i-1, j-1) = -p_img_gray(i-1, j-1) - p_img_gray(i-1, j) - p_img_gray(i-1, j+1) - p_img_gray(i, j-1) + (8 * p_img_gray(i, j)) - p_img_gray(i, j+1) - p_img_gray(i+1, j-1) - p_img_gray(i+1, j) - p_img_gray(i+1, j+1);
    end
end

% size(output_img)
imshow(output_img)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using pre-defined functions

% kernel = [0 1 0; 1 -4 1; 0 1 0];
% kernel = -1 * ones(3);
% kernel(2,2) = 8;
% result = uint8(filter2(kernel, img_gray, 'same'));
% sharp = imsubtract(img_gray, result);
% imshow(result)
 