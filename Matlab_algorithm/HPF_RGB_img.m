clear, close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read RGB Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = imread('RGB.png');
[width, height, channels] = size(img);
img = double(img);

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
HPF_Red = uint8(zeros([width, height]));
sharped_Red = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        HPF_Red(i-1, j-1) = -p_img_R(i-1, j-1) - p_img_R(i-1, j) - p_img_R(i-1, j+1) - p_img_R(i, j-1) + (8 * p_img_R(i, j)) - p_img_R(i, j+1) - p_img_R(i+1, j-1) - p_img_R(i+1, j) - p_img_R(i+1, j+1);
        sharped_Red(i-1, j-1) = p_img_R(i, j) - HPF_Red(i-1, j-1);
    end
end

% Green Channel
HPF_Green = uint8(zeros([width, height]));
sharped_Green = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        HPF_Green(i-1, j-1) = -p_img_G(i-1, j-1) - p_img_G(i-1, j) - p_img_G(i-1, j+1) - p_img_G(i, j-1) + (8 * p_img_G(i, j)) - p_img_G(i, j+1) - p_img_G(i+1, j-1) - p_img_G(i+1, j) - p_img_G(i+1, j+1);
        sharped_Green(i-1, j-1) = p_img_G(i, j) - HPF_Green(i-1, j-1);
     end
end

% Bleu Channel
HPF_Blue = uint8(zeros([width, height]));
sharped_Blue = uint8(zeros([width, height]));
for i = 2 : (width + 1)
    for j = 2 : (height + 1)
        HPF_Blue(i-1, j-1) = -p_img_B(i-1, j-1) - p_img_B(i-1, j) - p_img_B(i-1, j+1) - p_img_B(i, j-1) + (8 * p_img_B(i, j)) - p_img_B(i, j+1) - p_img_B(i+1, j-1) - p_img_B(i+1, j) - p_img_B(i+1, j+1);
        sharped_Blue(i-1, j-1) = p_img_B(i, j) - HPF_Blue(i-1, j-1);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Displaying
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HPF_result_img = cat(channels, HPF_Red, HPF_Green, HPF_Blue);
% size(HPF_result_img)
sharped_result_img = cat(channels, sharped_Red, sharped_Green, sharped_Blue);
% size(HPF_result_img)

subplot(3,3,2);
img = uint8(img);
imshow(img);
title('Original Image');

subplot(3,3,4);
imshow(HPF_Red);
title('HPF Red Layer Result');

subplot(3,3,5);
imshow(HPF_Green);
title('HPF Green Layer Result');

subplot(3,3,6);
imshow(HPF_Blue);
title('HPF Bleu Layer Result');

subplot(3,3,7);
imshow(HPF_result_img);
title('HPF RGB Result');

subplot(3,3,9);
imshow(sharped_result_img);
title('Sharped RGB Image');
