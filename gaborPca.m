%% 8类
clear all; close all; clc


%% loda data and process 
load AVIRIS_Indian_image
[m n d] = size(z);  % origial 3-D data


%% preprocess
iii = 0;
for ii = 2:d
%     H = fspecial('average',[3,3]);%3*3均值滤波
%     zs(:,:,ii) = imfilter(z(:,:,ii),H);
%     zs(:,:,ii) = medfilt2(z(:,:,ii),[3,3]);
    r = corr2(z(:,:,ii), z(:,:,ii-1));
    if r > 0.9
        iii = iii + 1;
        zs(:,:,iii) = z(:,:,ii);
    end

end

Datas = reshape(zs, m*n, iii);
Datas = Datas./max(Datas(:));  % normalization

%% PCA 
[coeff, SCORE, latent]  = pca(Datas);
base = 3;
pcaData = SCORE(:,1:base);            %取前k个主成分
pcaData = reshape(pcaData, m, n, base);

%% Feature extraction
%gabor

img=[];
for ii = 1:base
%     imgmid = [];
    Data = pcaData(:,:,ii); 
    Feature_P = Gabor_feature_extraction(double(Data(:,:)), 1);
%     Img_P = sum(Feature_P, 3);
%     imgmid = cat(3, imgmid, Feature_P(:,:,1))
    img=cat(3,img,Feature_P);
end

finalimg = reshape(img, m*n, base*8);
% finalimg = pcaData;
% load ground truth map and class name
load  eight_class_groudtruth_map
[m, n] = size(map);
labelimg = reshape(map, m*n, 1);
 
no_class = max(map(:)); % number of classes
trainum = 200;
CTrain = ones(1, no_class+1) * trainum; % 50 samples for each class
DataTrain = [];
LabelTrain = [];
for ii = 1: no_class
    tmp  = find(map==ii);
    rand('seed', 2); % randly select data
    index_i = randperm(length(tmp)); 
    DataTrain = [DataTrain; finalimg(tmp(index_i(1:CTrain(ii))), :)];
    label(1:trainum,1) = ii;
    LabelTrain = cat(1, LabelTrain, label);
end
save Data

