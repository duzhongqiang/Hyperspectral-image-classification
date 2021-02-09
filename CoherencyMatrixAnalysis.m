function [T H alpha] = CoherencyMatrixAnalysis(data)%, options)
%  Authors         : Saurabh Prasad
%  Developed       : 04/08/2009
%  Reference       : 
%                  http://www.ccrs.nrcan.gc.ca/glossary/index_e.php?id=3146
%  modified        : 
%
% Synopsis:
%  CoherencyMatrix(data)
%  CoherencyMatrix(data, options)
%
% Description:
%  CoherencyMatrixAnalysis(data) estimates the coherency matrix, 
%    the Entropy and alpha values for the SAR data which is 
%    num_pixels x num_pixels x num_channels, where num_bands
%    refers to the number of channels in the image.
%    It uses the Claude Decomposition to estimate alpha
%    It also assumes the following sequence of channels:
%      HH, VV, HV
%  
% Input:
%  data num_pixels by num_pixels by num_channels
% 
% Output:
%  T  a Coherency matrix
%     alpha
%     Entropy
%  
%  options [struct] Control parameters:   
%   Options will be added later (such as using only 3 out of 4 channels
%   etc.)
%
%**************************************************************************

% Estimating the Coherency Matrix, C
%
tmp = squeeze(data(:,1,:));
tmp = tmp(:);
S_HH = var(tmp);

tmp = squeeze(data(:,2,:));
tmp = tmp(:);
S_VV = var(tmp);

tmp = squeeze(data(:,3,:));
tmp = tmp(:);
S_HV = var(tmp);


% Reference:
%   http://www.ccrs.nrcan.gc.ca/resource/tutor/polarim/chapter2/01_e.php
K = [S_HH + S_VV, S_HH - S_VV, 2*S_HV ] / sqrt(2);

T = K'*K;

[V D] = eig(T);

for i = 1 : length(D)
    if D(i) == 0
        P(i) = 0;
    else
        P(i) = D(i)/sum(sum(D));
    end
end

% Strip out any zero probabilities
P2 = P(P > 0);

% Calculate entopy from probabilities
H = -log2(P2) * P2.';

% Calculate alpha_vector
alpha = 0;
for i = 1 : length(V)
    alpha_ith = acos(V(1,i));
    alpha = alpha + P(i) * alpha_ith;
end
