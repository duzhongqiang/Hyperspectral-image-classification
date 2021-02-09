function DataGabor = Gabor_feature_extraction(Data, BW)
% Mean feature extraction
% Data: mxnxD, W: Window size (even), Feature_P: mxnxD1
% P: number of PCs
%


[m n d] = size(Data);

lambda  = 50;
psi     = [0 pi/2];
gamma   = 1;
N       = 8;
DataGabor = zeros(m, n, N*d);
for i = 1: d
    img_in = Data(:, :, i);
    bw = BW;
    theta   = 0;
    for n=1:N
        gb = gabor_fn(bw,gamma,psi(1),lambda,theta)...
            + 1i * gabor_fn(bw,gamma,psi(2),lambda,theta);
        % gb is the n-th gabor filter
        DataGabor(:,:,(i-1)*N+n)=abs(imfilter(img_in, gb, 'symmetric'));
        % filter output to the n-th channel
        theta = theta + pi/N;
        % next orientation
    end
end