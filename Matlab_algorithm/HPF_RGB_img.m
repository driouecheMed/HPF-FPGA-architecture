clear, close all

% Read RGB Image
img = imread ('football.jpg');
[width, height, channels] = size(img);
%imshow(img)
%title('ORIGINAL IMAGE');
%figure;

% Compute Laplacian Conv
% kernel = [0 1 0; 1 -4 1; 0 1 0];
% Red Channel
for i = 1 : (width - 2)
    for j = 1 : (height - 2)
            R(i, j) = img(i, j+1, 1) + img(i+1, j, 1) - 4*img(i+1, j+1, 1) + img(i+1, j+2, 1) + img(i+2, j+1, 1);
    end
end

% Green Channel
for i = 1 : (width - 2)
    for j = 1 : (height - 2)
            G(i, j) = img(i, j+1, 2) + img(i+1, j, 2) - 4*img(i+1, j+1, 2) + img(i+1, j+2, 2) + img(i+2, j+1, 2);
     end
end

% Bleu Channel
for i = 1 : (width - 2)
    for j = 1 : (height - 2)
            B(i, j) = img(i, j+1, 3) + img(i+1, j, 3) - 4*img(i+1, j+1, 3) + img(i+1, j+2, 3) + img(i+2, j+1, 3);
     end
end

output_img = cat(channels, R, G, B);
% size(output_img)
imshow(output_img)
