clear;
close all;
clc;

%% loda data and process 
load AVIRIS_Indian_image
[m n d] = size(z);  % origial 3-D data


Datas = reshape(z, m*n, d);
Datas = Datas./max(Datas(:));  % normalization
%% PCA 
[coeff, SCORE, latent]  = pca(Datas);
base = 220;
pcaData = SCORE(:,1:base);            %取前k个主成分
pcaData = reshape(pcaData, m, n, base);


x = [1:220];
for iii = 1: m
for ii =1:n
    y = pcaData(iii,ii,:);
    y = reshape(y,1, 220);
    
    plot(x, y);
    hold on;
end
end