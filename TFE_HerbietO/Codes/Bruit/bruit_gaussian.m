% =========================================================================

[my_image,status] = spm_select(Inf,'image','select your mask', [],pwd);
image = spm_vol(my_image);
P = spm_read_vols(image);
udat = uint8(0);
udat = P;

% =========================================================================


udat = imnoise(udat,'gaussian', 0 , 1);



% ------------------------save image-------------------------------
output = struct();
[pth,nam,ext] = fileparts(my_image);
output.fname = [pth '/' nam '_bruit' ext(1:4)];
output.dim = [image.dim(1) image.dim(2) image.dim(3)];
output.mat = image.mat;
output.dt = [spm_type('uint8') 0];
output.descrip = 'NIFTI-1 Image';
output = spm_create_vol(output);
spm_write_vol(output,udat);
% -----------------------------------------------------------------