[my_image,status] = spm_select(Inf,'image','select your images', [],pwd);
image = spm_vol(my_image);
A = spm_read_vols(image);

m = size(A,1);
n = size(A,2);
p = size(A,3);
V_j = 0;

for g = 1 : 1 : p
    for i = 1 : 1 : m
        for j = 1 : 1 : n
            
            if A(i,j,g) ~= 0
                V_j = V_j + 1;
            else
                V_j = V_j + 0;
            end
        end
    end
end

vol = V_j*0.2*0.2*0.2