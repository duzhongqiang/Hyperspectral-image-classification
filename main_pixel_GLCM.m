clear all; close all; clc

Data = imread('boat256.bmp');
Data = double(Data);
[m n] = size(Data);
X = zeros(m+4, n+4);
X(3:m+2, 3:n+2) = Data;
X(1:2, :) = X(3:4, :);
X(:, 1:2) = X(:, 3:4);
X(:, n+3:n+4) = X(:, n+1:n+2);
X(m+3:m+4, :) = X(m+1:m+2, :);

for i = 3: m+2
    for j = 3: n+2
        cf = [];
        a = 5; b = 5;   % spatial image size
        Image = X(i-2:i+2, j-2:j+2);
        D = 1;
        [mat135,mat90,mat45,mat0] = GLCM(Image,D);
        cf135 = GLCMFeatureExtraction(mat135, b, a, D, 135);
        cf90 = GLCMFeatureExtraction(mat90, b, a, D, 90);
        cf45 = GLCMFeatureExtraction(mat45, b, a, D, 45);
        cf0 = GLCMFeatureExtraction(mat0, b, a, D, 0);
        cf1 = [cf135(2), cf90(2), cf45(2), cf0(2), ...
               cf135(3), cf90(3), cf45(3), cf0(3), ...
               cf135(6), cf90(6), cf45(6), cf0(6)];
        Feature_X(i-2, j-2, :) = cf1;
    end
    disp(i)
end
toc