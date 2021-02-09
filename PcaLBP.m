clear all; close all; clc


%% loda data and process 
load AVIRIS_Indian_image
[m n d] = size(z);  % origial 3-D data


%% process
iii = 0;
for ii = 2:d
%     H = fspecial('average',[3,3]);%3*3均值滤波
%     z(:,:,ii) = imfilter(z(:,:,ii),H);
%     z(:,:,ii) = medfilt2(z(:,:,ii),[3,3]);
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
base = 10;
pcaData = SCORE(:,1:base);            %取前k个主成分
pcaData = reshape(pcaData, m, n, base);

%% Feature extraction
%gabor
gabor_num=5;
r = 1;  nr = 8;
mapping = getmapping(nr,'u2'); 
img=[];
for ii = 1:base
    Data = pcaData(:,:,ii); 
    [F_P, Img_P] = LBP_feature_global(double(Data), r, nr, mapping, 13); 
    img=cat(3,img,F_P);
end

finalimg = reshape(img, m*n, base*59);
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
    rand('seed', 3); % randly select data
    index_i = randperm(length(tmp)); 
    DataTrain = [DataTrain; finalimg(tmp(index_i(1:CTrain(ii))), :)];
    label(1:trainum,1) = ii;
    LabelTrain = cat(1, LabelTrain, label);
end
save Data

