clear;
close all;
clc;
load newData
y = reshape(y_pred, 145, 145);
% pcolor(y)
gca=pcolor(y);
title('原始标签');
set(gca, 'LineStyle','none');
colormap(jet)

figure;
load eight_class_groudtruth_map
gca=pcolor(map);
title('分类结果');
set(gca, 'LineStyle','none');
colormap(jet)