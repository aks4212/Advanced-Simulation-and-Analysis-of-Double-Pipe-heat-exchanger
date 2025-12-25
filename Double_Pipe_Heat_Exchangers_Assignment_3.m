%% Assuming the following inlet conditions and Head Capacity Ratios

% Hot fluid inlet temperature, Th,in = 400 K
% Cold fluid inlet temperature, Tc,in = 300 K

% Heat capacity rates:
% Ch = 2 kW/K
% Cc = 1.5 kW/K

% Overall heat transfer coefficient × area per unit length:
% UA' = 0.5 kW/K·m

% Length of heat exchanger, L = 10 m


%% Simulating the Parallel Flow Temperature profile
Ch = 2;
Cc = 1.5;
UA = 0.5;
L = 10;

Th0 = 400;
Tc0 = 300;

% writing the system of ODEs
Temph = @(X, T)[
    -(UA/Ch)*(T(1) - T(2));
    (UA/Cc)*(T(1) - T(2))
    ];

% Solving the system using ODE45
[X, T_P] = ode45(Temph,[0 L],[Th0 Tc0]);

% Plotting 
figure(1);
plot(X, T_P(:,1), 'r', 'LineWidth', 2); 
hold on;
plot(X, T_P(:,2), 'b', 'LineWidth', 2);
xlabel("Length (m)")
ylabel('Temperature (K)')
legend('Hot Fluid', 'Cold Fluid')
title('Parallel Flow Heat Exchanger')
grid on


%% Simulating the Counter Flow Temperature profile
Ch = 2;
Cc = 1.5;
UA = 0.5;
L = 10;

Th0 = 400;
TcL = 300; % In counter case Cold fluid inlet is at x = L

% writing the system of ODEs
TempC = @(x, T)[
    -(UA/Ch)*(T(1) - T(2));
    -(UA/Cc)*(T(1) - T(2))
    ];

% Solving the system using ODE45
[x, T_C] = ode45(TempC,[0 L],[Th0 TcL]);

%Plotting
figure(2);
plot(x, T_C(:,1), 'r', 'LineWidth', 2); 
hold on;
plot(x, T_C(:,2), 'b', 'LineWidth', 2);
xlabel("Length (m)")
ylabel('Temperature (K)')
legend('Hot Fluid(->)', 'Cold Fluid(<-)')
title('Counter Flow Heat Exchanger')
grid on

%% Reboiler Case
% here Hot fluid temperature remains Constant
x = linspace(0,10,100);
Th_R = 400*ones(size(x));
Tc_R = 300 + 5*x;

figure(3)
plot(x,Th_R,'r','LineWidth',2)
hold on
plot(x,Tc_R,'b','LineWidth',2)
xlabel('Length (m)')
ylabel('Temperature (K)')
legend('Hot Fluid (Phase Change)','Cold Fluid')
title('Reboiler Temperature Profile')
grid on

%% Condenser Case
% here Cold fluid temperature remains Constant
x = linspace(0,10,100);
Tc_C = 320*ones(size(x));
Th_C = 400 - 6*x;

figure(4)
plot(x,Th_C,'r','LineWidth',2)
hold on
plot(x,Tc_C,'b','LineWidth',2)
xlabel('Length (m)')
ylabel('Temperature (K)')
legend('Hot Fluid','Cold Fluid (Phase Change)')
title('Condenser Temperature Profile')
grid on

