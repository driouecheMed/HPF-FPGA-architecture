clear, close all

% Read RGB Image
img = imread ('football.jpg');
[width, height, channels] = size(img);
% imshow(img)
% title('ORIGINAL IMAGE');
% figure;

% Convert to Gray Scale
img_gray = rgb2gray(img);
% size(img)
% imwrite(img_gray, 'football_gray.jpg');

% Compute Laplacian Conv
% kernel = [0 1 0; 1 -4 1; 0 1 0];
% output_img = zeros([width-2, height-2]);
for i = 1 : (width - 2)
    for j = 1 : (height - 2)
        output_img(i, j) = img_gray(i, j+1) + img_gray(i+1, j) - 4*img_gray(i+1, j+1) + img_gray(i+1, j+2) + img_gray(i+2, j+1);
    end
end
% size(output_img)
imshow(output_img)
