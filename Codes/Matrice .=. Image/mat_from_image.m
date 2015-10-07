[my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
image = spm_vol(my_image);
A = spm_read_vols(image);