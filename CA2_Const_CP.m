%CA2 Constant CP full run

%C1
T1 = 250;
P1 = 0.5*10^5;
M1 = 2;
[P2,T2] = inlet_rev_con_cp(T1,P1,M1)
[T2_var, P2_var] = inlet_rev_var_cp(T1,P1, M1)

%C2 - test case
% P5 = 100000;
% T5 = 500;
% P0 = 10000;
T5 = 1000;
P5 = 500000;
P0 = 100000;

[P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5, P0)
[P9_var, T9_var, M9_var, v9_var] = nozzle_rev_var_cp(P5, T5, P0)

% %C3
% %Define known turbojet parameters
% T4 = 1450+273; %K
% M0 = 2;, v9
% gam = 1.4;
% R = 287; %J/kgK
% %At 16.2 km altitude, from textbook appendix,
% T0 = 216.6; %K
% P0 = (7565-10350)/(18-16)*.2 + 10350; %Pa, interpolated from table
% 
% %Define Speed of Sound
% a0 = sqrt(gam*R*T0); %m/s
% 
% %Using equations from lecture 24 example,
% tau_r = 1 + (gam-1)/2*M0^2;
% pi_r = tau_r^(gam/(gam-1));
% tau_l = T4/T0;
% 
% pi_c = 20;
% 
% T_ma = a0*sqrt(2/(gam-1)*(tau_l*(1-1/(tau_r*pi_c) ^ ((gam-1)/gam)) - tau_r*(pi_c^((gam-1)/gam) -1)))-M0;