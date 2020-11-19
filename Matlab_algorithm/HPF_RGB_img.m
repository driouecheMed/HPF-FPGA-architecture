clear, close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read RGB Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% img = imread ('vegetables.jpg');
img = imread('RGB.png');

[width, height, channels] = size(img);
img = double(img);
%imshow(img)
%title('ORIGINAL IMAGE');
%figure;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add padding with zeros for each layer (R, G, B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p_img_R = double(zeros([width + 2, height + 2]));
p_img_R(2 : width+1, 2 : height+1) = double(img(:,:,1));

p_img_G = double(zeros([width + 2, height + 2]));
p_img_G(2 : width+1, 2 : height+1) = double(img(:,:,2));

p_img_B = double(zeros([width + 2, height + 2]));
p_img_B(2 : width+1, 2 : height+1) = double(img(:,:,3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Laplacian Conv
% kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Red Channel
R = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        R(i-1, j-1) = -p_img_R(i-1, j-1) - p_img_R(i-1, j) - p_img_R(i-1, j+1) - p_img_R(i, j-1) + (8 * p_img_R(i, j)) - p_img_R(i, j+1) - p_img_R(i+1, j-1) - p_img_R(i+1, j) - p_img_R(i+1, j+1);
    end
end

% Green Channel
G = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        G(i-1, j-1) = -p_img_G(i-1, j-1) - p_img_G(i-1, j) - p_img_G(i-1, j+1) - p_img_G(i, j-1) + (8 * p_img_G(i, j)) - p_img_G(i, j+1) - p_img_G(i+1, j-1) - p_img_G(i+1, j) - p_img_G(i+1, j+1);
     end
end

% Bleu Channel
B = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        B(i-1, j-1) = -p_img_B(i-1, j-1) - p_img_B(i-1, j) - p_img_B(i-1, j+1) - p_img_B(i, j-1) + (8 * p_img_B(i, j)) - p_img_B(i, j+1) - p_img_B(i+1, j-1) - p_img_B(i+1, j) - p_img_B(i+1, j+1);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Displaying
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_img = cat(channels, R, G, B);
% size(output_img)
subplot(3,3,2);
imshow(img);
title('HPF RGB Result');

subplot(3,3,4);
imshow(R);
title('HPF Red Layer Result');

subplot(3,3,5);
imshow(G);
title('HPF Green Layer Result');

subplot(3,3,6);
imshow(B);
title('HPF Bleu Layer Result');

subplot(3,3,7);
imshow(output_img);
title('HPF RGB Result');
