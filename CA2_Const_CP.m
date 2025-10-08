clc; close all; clear all;

%CA2 Constant CP full run

%C1
T1_test = 250;
P1_test = 0.5*10^5;
M1_test = 2;
[P2_test,T2_test] = inlet_rev_con_cp(T1_test,P1_test,M1_test)
[T2_var_test, P2_var_test] = inlet_rev_var_cp(T1_test,P1_test, M1_test)

%C2 - test case

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
Cp_con = 29.1970; %J/molK
v0 = sqrt(1.4*287*T0)*2 %

%Define 
pi_c = 20;

[P2,T2] = inlet_rev_con_cp(T0,P0,M0)


[T3_rev, W_rev] = comp_rev_low_ma_con_cp(pi_c, T2, Cp_con)
P3 = pi_c * P2

[phi,f] = comb_rev_low_mach_con_cp(T3_rev,T4, Cp_con)

pi_t = pi_c;
[T5_rev, W_rev] = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con)

P5 = P2

[P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5_rev, P0)

%we get specific thrust, ST, from lecture 7, considering f:
ST = (1+f)*v9 - v0

%Then we get thermal efficiency, propulsive efficiency, and overall
%efficiency
Qc = delta_h_con_cp(T4,T3_rev,Cp_con)/.029      %J/mol*(1mol/.029kg)
nth = ((1+f)*v9^2 - v0^2)/Qc

np = ST*v0*2/((1+f)*v9^2-v0^2) %Lecture 7

no = nth*np


