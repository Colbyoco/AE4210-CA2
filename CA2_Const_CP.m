%CA2 Constant CP full run

%C1
T1_test = 250;
P1_test = 0.5*10^5;
M1_test = 2;
[P2_test,T2_test] = inlet_rev_con_cp(T1_test,P1_test,M1_test)
[T2_var_test, P2_var_test] = inlet_rev_var_cp(T1_test,P1_test, M1_test)

%C2 - test case
% P5 = 100000;
% T5 = 500;
% P0 = 10000;
T5_test = 1000;
P5_test = 500000;
P0_test = 100000;

[P9_test, T9_test, M9_test, v9_test] = nozzle_rev_con_cp(P5_test, T5_test, P0_test)
[P9_var_test, T9_var_test, M9_var_test, v9_var_test] = nozzle_rev_var_cp(P5_test, T5_test, P0_test)

%C3
%Define known turbojet parameters
T4 = 1450+273; %K
M0 = 2; 

%At 16.2 km altitude, from textbook appendix,
T0 = 216.6; %K
P0 = (7565-10350)/(18-16)*.2 + 10350; %Pa, interpolated from table

pi_c = 20;

[P2,T2] = inlet_rev_con_cp(T0,P0,M0)



