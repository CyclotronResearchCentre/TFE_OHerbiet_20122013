[profile_fname,profile_pname] = uigetfile('*.tsv', 'Please enter the profile file');
 if(profile_fname ~= 0)
     profile_filename = sprintf('%s%s',profile_pname,profile_fname);
 end                       
                        
    fid_profile = fopen(profile_filename,'r');
    
    data = textscan(fid_profile, '%f %f', 512, 'headerlines', 13);
    Xaxis = data{:,1};
    Yaxis = data{:,2};
    
    figure(1);
    plot(Xaxis,Yaxis)
    
    x = zeros(1,1);
    y = zeros(1,1);
    j = 1;
    
    for i = 155:173     %233 - 268 - 300  (118-134)
        x(j,1) = Xaxis(i,1);
        y(j,1) = Yaxis(i,1);
        j = j + 1;
    end
    
    figure(2);
    plot(x,y)
   
    %% calcul de la distance à mi-hauteur
    
    width = fwhm(x,y)
  
    %% estimation d'un pôlynome
    
    N = 10;
    P = polyfit(x,y, N);
    y2 = polyval(P,x);
    
    figure(3);
    hold on
    plot(x,y)
    plot(x,y2,'r')
    hold off