function [mat135,mat90,mat45,mat0] = GLCM(Image,D)
% 
% This function calculates the Gray Level Co-Occurence Matrix (GLCM) for
% a used provided distance, D.
%
% [mata,matb,matc,matd] = co_mat(Image,D)
%         Image: input image
%         D    : distance
%         mat135  : co-occurrence matrix direction 135 degrees
%         mat90   : co-occurrence matrix direction 90 degrees
%         mat45   : co-occurrence matrix direction 45 degrees
%         mat0    : co-occurrence matrix direction 0 degree
% Modified April 10, 2009 (Saurabh Prasad)

% Finding the size of the image.
[m,n] = size(Image);
Image = double(Image);
D = round(D);

if (D==0 || D >= m || D >= n)
    disp('invalid input for distance');
    return;
end

% Max Gray scale.
%mx = 256; % <<--- Debug value
mx = max(max(Image))+1 ;
Image = Image + 1;

% Initialize the matrices.
mat1 = zeros(mx);
mat2 = zeros(mx);
mat3 = zeros(mx);
mat4 = zeros(mx);

%135 degrees
for r = 1+D:m,
    for c = 1+D:n,
		row = Image(r,c);
		col = Image(r-D,c-D);
        mat1(row,col) = mat1(row,col) + 1;
    end
end
for r = 1:mx
    for c = r:mx
        if (r==c)
            mat1(r,c) = 2 * mat1(r,c);
        else
            mat1(c,r) = mat1(r,c) + mat1(c,r);
            mat1(r,c) = mat1(c,r);
        end
    end
end

%90 degrees
for r = 1+D:m,
    for c = 1:n,
		row = Image(r,c);
		col = Image(r-D,c);
    	mat2(row,col) = mat2(row,col) + 1;            
    end
end
for r = 1:mx
    for c = r:mx
        if (r==c)
            mat2(r,c) = 2 * mat2(r,c);
        else
            mat2(c,r) = mat2(r,c) + mat2(c,r);            
            mat2(r,c) = mat2(c,r);
        end
    end
end

%45 degrees
for r = 1+D:m,
    for c = 1:n-D,
		row = Image(r,c);
		col = Image(r-D,c+D);
        mat3(row,col) = mat3(row,col) + 1;            
    end
end
for r = 1:mx
    for c = r:mx
        if (r==c)
            mat3(r,c) = 2 * mat3(r,c);
        else
            mat3(c,r) = mat3(r,c) + mat3(c,r);            
            mat3(r,c) = mat3(c,r);
        end
    end
end

%0 degrees
for r=1:m,
    for c=1:n-D,
		row = Image(r,c);
		col = Image(r,c+D);
   		mat4(row,col) = mat4(row,col) + 1;            
    end
end
for r = 1:mx
    for c = r:mx
        if (r==c)
            mat4(r,c) = 2 * mat4(r,c);
        else
            mat4(c,r) = mat4(r,c) + mat4(c,r);            
            mat4(r,c) = mat4(c,r);
        end
    end
end

 % Output the co-occurrence matrices.

   mat135 = mat1;
   clear mat1
   mat90 = mat2;
   clear mat2
   mat45 = mat3;
   clear mat3
   mat0 = mat4;
   clear mat4
   
% Used in atr project 
   %    if (nargout==1)
%    mat135 = mat1+mat2+mat3+mat4;
% else
%    mat135 = mat1;
%    mat90 = mat2;
%    mat45 = mat3;
%    mat0 = mat4;
% end
