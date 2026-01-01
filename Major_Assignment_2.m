% Given data
Th_in = 120;
Tc_in = 30;
Ch = 4.5;
Cc = 3.0;
U = 0.3;
A = 6;

% Calculating Heat capacity rates
Cmin = min(Ch, Cc);
Cmax = max(Ch, Cc);
Cr = Cmin / Cmax;

% Number of Transfer Units (NTU) calculation
NTU = U * A / Cmax;

% Effectiveness using epsilon-NTU relation
eps_parallel = (1 - exp(-NTU*(1 + Cr))) / (1 + Cr);
eps_counter = (1 - exp(-NTU*(1 - Cr))) / (1 - Cr*exp(-NTU*(1 - Cr)));

% Heat transfer rate
Q_parallel = eps_parallel*Cmin*(Th_in - Tc_in);
Q_counter = eps_counter*Cmin*(Th_in - Tc_in);

% Outlet temparatures
Th_out_p = Th_in - Q_parallel / Ch;
Tc_out_p = Tc_in + Q_parallel / Cc;

Th_out_c = Th_in - Q_counter / Ch;
Tc_out_c = Tc_in + Q_counter / Cc;

% Displaying the results:-
fprintf('min heat capacity: %.3f\n', Cmin);
fprintf('max heat capacity: %.3f\n', Cmax);
fprintf('Number of transfer units(NTU): %.3f\n', NTU);

fprintf('Parallel Flow Effectiveness: %.3f\n', eps_parallel);
fprintf('Counter Flow Effectiveness: %.3f\n\n', eps_counter);

fprintf('Parallel Flow: Th_out = %.2f C, Tc_out = %.2f C\n', Th_out_p, Tc_out_p);
fprintf('Counter Flow: Th_out = %.2f C, Tc_out = %.2f C\n', Th_out_c, Tc_out_c);

%% Plot: epsilon vs Area(A)
A = linspace(2,10,50);
NTU = (U .*A)/Cmin;

eps_p = (1 - exp(-NTU .* (1 + Cr))) ./ (1 + Cr);
eps_c = (1 - exp(-NTU .* (1 - Cr))) ./ (1 - Cr .* exp(-NTU .* (1 - Cr)));

figure;
plot(A, eps_p, 'r', 'LineWidth', 2);
hold on;
plot(A, eps_c, 'b', 'LineWidth', 2);
xlabel('Heat Tranfer Area (m^2)');
ylabel('Effectiveness');
legend('Parallel Flow', 'Counter Flow');
grid on;
