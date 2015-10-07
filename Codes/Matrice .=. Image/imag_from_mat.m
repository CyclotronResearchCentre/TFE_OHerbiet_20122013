[my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
image = spm_vol(my_image);
A = spm_read_vols(image);

% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% B = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% C = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% D = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% E = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% F = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% G = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% H = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% I = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% J = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% K = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% L = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% M = spm_read_vols(image);
% 
% [my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
% image = spm_vol(my_image);
% N = spm_read_vols(image);


O = A ;%+ B + C + D + E + F + G + H + I + J + K + L + M + N ;


output = struct();
[pth,nam,ext] = fileparts(my_image);
output.fname = [pth '/' nam '_somme' ext(1:4)];
output.dim = [image.dim(1) image.dim(2) image.dim(3)];
output.mat = image.mat;
output.dt = [spm_type('uint8') 0];
output.descrip = 'NIFTI-1 Image';
output = spm_create_vol(output);
spm_write_vol(output,O);