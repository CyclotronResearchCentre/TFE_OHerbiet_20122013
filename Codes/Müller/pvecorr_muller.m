[my_images,status] = spm_select(Inf,'image','Select your images', [],pwd);

[mask_images,status] = spm_select(Inf,'image','Select your binary images', [],pwd);


for ima = 1 : size(my_images,1)
    image = spm_vol(my_images(ima,:));
    A = spm_read_vols(image);
    imag{ima} = A;
end

for i = 1 : size(mask_images,1)
    mask_im = spm_vol(mask_images(i,:));
    voi = spm_read_vols(mask_im);
    region{i} = voi;
end


for i = 1 : size(my_images,1)
    act = zeros(size(mask_images,1),1);
    for k = 1 : size(mask_images,1)
        indexMask = find(region{k}>0);
        am = sum(imag{i}(indexMask));
        amo = am/size(indexMask,1);
        act(k,1) = amo;
    end
    activity{i} = act;
end

fid = fopen('Corrected_activity_Muller.txt', 'w');
fprintf(fid,'VOIs\t');
for i = 1:size(mask_images,1)
    [pth,nam,ext] = fileparts(mask_images(i,:));
    fprintf(fid,'%s\t',nam(3:end));
end

for i = 1:size(my_images,1)
    fprintf(fid,'\n%s\t',['frame' num2str(i)]);
    for j= 1:size(mask_images,1)
        acti = activity{i}(:,1)';
        fprintf(fid,'%g\t',acti(j));
    end
end

status = fclose(fid);