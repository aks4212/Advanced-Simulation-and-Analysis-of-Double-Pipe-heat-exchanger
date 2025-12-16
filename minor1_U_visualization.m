clear;
clc;
close all;

% Defining Given Geometry and Material Constants 

Di = 0.020;         
Do = 0.040;        
Ratio_Do_Di = Do / Di; 

k_wall = 385;       

R_wall_prime = (Do * log(Ratio_Do_Di)) / (2 * k_wall);

% Defining Parameter Ranges and Grid Generation 

hi_range = linspace(200, 2000, 50);   
ho_range = linspace(100, 1500, 50);   
Rf_range = linspace(0, 5e-4, 100);     

% Creating the 3D grid for hi, ho, and Rf [cite: 37]
[hi, ho, Rf] = meshgrid(hi_range, ho_range, Rf_range);

% Computing Overall Heat Transfer Coefficient (Uo) 

inv_Uo = (Ratio_Do_Di ./ hi) + R_wall_prime + (1 ./ ho) + Rf;
Uo = 1 ./ inv_Uo;

% Generating 3D Surface Plot for Fixed Rf 
Rf_fixed = (Rf_range(1) + Rf_range(end)) / 2; 
[~, Rf_index] = min(abs(Rf_range - Rf_fixed)); 

Uo_slice = Uo(:,:,Rf_index);

figure(1);
surf(hi_range, ho_range, Uo_slice, 'EdgeColor', 'none');
colormap jet; 
colorbar;
view(3); 

xlabel('$h_i$ [W/m$^2$ K]', 'Interpreter', 'latex');  
ylabel('$h_o$ [W/m$^2$ K]', 'Interpreter', 'latex');  
zlabel('$U_o$ [W/m$^2$ K]', 'Interpreter', 'latex');  
title(sprintf('Overall Heat Transfer Coefficient U_o vs h_i and h_o at a fixed Rf'));
grid on;


% Generating 2D Plot for Average Uo vs Rf 

Avg_Uo = squeeze(mean(mean(Uo, 1), 2));

figure(2);
plot(Rf_range, Avg_Uo, 'b-');

xlabel('$R_f$ [m$^2$ K/W]', 'Interpreter', 'latex');
ylabel('Average $U_o$ [W/m$^2$ K]', 'Interpreter', 'latex'); 
title('Average Overall Heat Transfer Coefficient vs Fouling Resistance');
grid on;

