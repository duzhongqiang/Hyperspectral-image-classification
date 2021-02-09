clear all; close all; clc

Data = imread('boat256.bmp');
 
% LBP feature extraction
r = 1;  nr = 8;
mapping = getmapping(nr,'u2'); 
tic
[F_P Img_P] = LBP_feature_global(double(Data), r, nr, mapping, 8);
toc

% Gabor feature extraction
tic
Feature_P = Gabor_feature_extraction(double(Data(:,:)), 1);  
toc
figure, imshow(Data, []); 
figure, imshow(Img_P, []);
figure, imshow(Feature_P(:,:,1), [])
figure, imshow(Feature_P(:,:,2), [])
figure, imshow(Feature_P(:,:,3), [])
figure, imshow(Feature_P(:,:,4), [])
figure, imshow(sum(Feature_P, 3), []);
