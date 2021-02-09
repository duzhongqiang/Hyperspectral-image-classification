clear all; close all; clc

Data = imread('boat256.bmp');
Image = double(Data);

D = 1; a = 5; b = 5;   % spatial image size
[mat135,mat90,mat45,mat0] = GLCM(Image,D);
cf135 = GLCMFeatureExtraction(mat135, b, a, D, 135);
cf90 = GLCMFeatureExtraction(mat90, b, a, D, 90);
cf45 = GLCMFeatureExtraction(mat45, b, a, D, 45);
cf0 = GLCMFeatureExtraction(mat0, b, a, D, 0);
cf1 = [cf135(2), cf90(2), cf45(2), cf0(2), ...
       cf135(3), cf90(3), cf45(3), cf0(3), ...
       cf135(6), cf90(6), cf45(6), cf0(6)];
       