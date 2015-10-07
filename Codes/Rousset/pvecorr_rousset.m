function pvecorr_rousset()

[my_images,status] = spm_select(Inf,'image','Select your images', [],pwd);


[mask_images,status] = spm_select(Inf,'image','Select your images binary images', [],pwd);


    % Isotropic Sigma
    sigma = [0.673; 0.673; 0.673];
    %sigma = [0.3; 0.3; 0.3];
    pixelspacing=[0.2 0.2 0.2];
    amoyen = [];
    
for ima = 1:size(my_images,1)
    
    image = spm_vol(my_images(ima,:));
    A = spm_read_vols(image);
    imag{ima} = A;
    % convolve simulated image
    %simg = gauss3filter(A, sigma, pixelspacing);
    ssimg{ima} = A; %simg; %A
    %amoyen = [amoyen; mean(simg(find(A>0)))];
end

for im = 1:size(mask_images,1)

    % working on Mask images
    mask = spm_vol(mask_images(im,:));
    M = spm_read_vols(mask);
    
    % keep a copy of the binary mask
    iminput{im} = M;
    
    % covolve binary mask
    imconv = gauss3filter(M, sigma, pixelspacing);
    
    % keep a copy of the binary convolved image
    %rsf = spm_vol(RSF_images(im,:));
    %R = spm_read_vols(rsf);
    imoutput{im} = imconv;
    
end

% matrice GTM

W = zeros(size(iminput,2),size(iminput,2));

for i=1:size(imoutput,2)
    for j=1:size(iminput,2)
        if(i==j)
            indexMask =0;wij = 0;
            indexMask = find(iminput{i}>0);
            wij = sum(imoutput{j}(indexMask))/sum(iminput{i}(indexMask));            
        end
        if(i~=j)
            indexMask = 0;
            w=0;wij=0;
            indexMask = find(iminput{j}>0);
            w = sum(imoutput{i}(indexMask));
            wij = w/size(indexMask,1);
        end
        W(i,j) = wij;
    end
        
end

%calcul de amoyen (1re colonne) et de "standard deviation" (2me colonne) et
%de la correction de l'effet de colume partiel (3me colonne)



for i = 1 : size(my_images,1)
    act = zeros(size(iminput,2),2);
    for k = 1 : size(iminput,2)
        indexMask =0;
        am = 0;
        amo=0;
        indexMask = find(iminput{k}>0);
        am = sum(ssimg{i}(indexMask));
        amo = am/size(indexMask,1);
        act(k,1) = amo;
        %act(k,2) = std(imag{i}(indexMask));
    end
    act(:,2) = inv(W')*act(:,1);
    activity{i} = act;  
end

%--------------------------------------------------------------------------
%ecrire dans un fichier txt l'activite dans chaque region

fid = fopen('activity.txt', 'w');
fprintf(fid,'VOIs\t');
for i = 1:size(mask_images,1)
    [pth,nam,ext] = fileparts(mask_images(i,:));
    fprintf(fid,'%s\t',nam(3:end));
end

for i = 1:size(my_images,1)
    %[pth,nam,ext] = fileparts(my_images(i,:))
    fprintf(fid,'\n%s\t',['frame' num2str(i)]);
    for j= 1:size(mask_images,1)
        acti = activity{i}(:,1)';
        fprintf(fid,'%g\t',acti(j));
    end
end
status = fclose(fid);

%ecrire dans un fichier txt l'activite corrigee dans chaque region

fid = fopen('Corrected_activity.txt', 'w');
fprintf(fid,'VOIs\t');
for i = 1:size(mask_images,1)
    [pth,nam,ext] = fileparts(mask_images(i,:));
    fprintf(fid,'%s\t',nam(3:end));
end

for i = 1:size(my_images,1)
    %[pth,nam,ext] = fileparts(my_images(i,:))
    fprintf(fid,'\n%s\t',['frame' num2str(i)]);
    for j= 1:size(mask_images,1)
        acti = activity{i}(:,2)';
        fprintf(fid,'%g\t',acti(j));
    end
end

status = fclose(fid);

return