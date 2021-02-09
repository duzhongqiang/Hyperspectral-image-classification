clear all; close all; clc


% selected 8 class Indian Pine data of AVIRIS sensor
load AVIRIS_Indian_image
[m n d] = size(z);  % origial 3-D data
Data = reshape(z, m*n, d);
Data = Data./max(Data(:));  % normalization


% load ground truth map and class name
load  eight_class_groudtruth_map
 
% save Labelled Data and the labels
no_class = max(map(:)); % number of classes
CTrain = ones(1, no_class) * 50; % 50 samples for each class
DataTrain = [];
for i = 1: no_class
    tmp  = find(map==i);
    rand('seed', 2); % randly select data
    index_i = randperm(length(tmp));  
    DataTrain = [DataTrain; Data(tmp(index_i(1:CTrain(i))), :)];
end
  
