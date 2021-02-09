function cf = GLCMFeatureExtraction(cooccur, nx, ny, D, ang)
% ______________________________________________________________________________________
% 
% function cf = GLCMFeatureExtraction(cooccur, nx, ny,D,ang)
% This function calculates and returns features extracted from the GLCM
% Matrices.
% The output is a row vector comprising of concatenated features in the 
% following order energy, inertia, entropy, 
% homogentity(inverse difference moment), and correlation.
% 
% INPUT:
%   cooccur : cooccurrence matrix for a particular direction and distance D
%   ang : direction for which the cooccurrence matrix is calculated
%   nx  : number of columns  of the image for which cooccurence is
%         calculated
%   ny  : number of rows of the image for which cooccurence is
%         calculated
%   D   : distance
% 
% OUTPUT:
% 
%     cf : row vector and order of features are, from first to last:
%
%          energy 
%          correlation
%          variance
%          homogeneity (inverse difference moment) 
%          entropy 
%          inertia
% Modified April 10, 2009 (Saurabh Prasad)
%
% ______________________________________________________________________________________


% Initialization.
msiz = size(cooccur);
energy = 0;
% contrast =0;
homogen = 0;
variance = 0;
entropy = 0;
inertia = 0;
R = 0; % normalizing factor (R instead of counter) 
corr = 0;

switch ang
    case 135 
        R = 2 * (nx-D) * (ny-D);
    case 90  
        R = 2 * nx * (ny-D);
    case 45  
        R = 2 * (nx-D) * (ny-D);
    case 0   
        R = 2 * (nx-D) * ny;
    otherwise
        disp('valid only for angles: 0, 45, 90, 135');
end
cooccur_norm= cooccur/R;
clear cooccur

% Calculation of px and py. 
px = sum(cooccur_norm');
py = sum(cooccur_norm);

% Computing mean and standard deviation of px and py.
mu_x = mean(px);
mu_y = mean(py);
sd_x = std(px);
sd_y = std(py);
mu = mean2(cooccur_norm);

% Calculating the 5 features: energy, inertia, entropy, homogentity (inverse diffeence moment) and correlation.
for i = 1: msiz(1),
  for j = 1: msiz(2),
    energy = energy + cooccur_norm(i,j).^2; 
    inertia = inertia + ((i-j)^2)*cooccur_norm(i,j);
    variance = variance + ((i-mu)^2)*cooccur_norm(i,j);
    cn = cooccur_norm(i,j);
    if (cn == 0)
      cn = 1;
    end
    entropy = entropy - cooccur_norm(i,j)*log(cn);
    homogen = homogen + cooccur_norm(i,j)/(1+((i-j)^2));
    corr = corr + (i*j*cooccur_norm(i,j));
  end
end
corr = (corr -mu_x*mu_y)/ (sd_x*sd_y);

% % contrast
% for n = 1:4060
%     c = 0;
%     for i = 1: msiz(1),
%         for j = 1: msiz(2),
%             if abs(i-j)==n
%                 c =  c + cooccur_norm(i,j);
%             end
%         end
%     end
%     contrast =  contrast + (n^2)*c;
% end


% Output the parameters.

%cf = [ energy contrast corr  variance homogen entropy inertia ];
cf = [ energy corr  variance homogen entropy inertia ];

