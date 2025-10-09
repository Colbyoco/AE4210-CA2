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

%Define pi_c range and tracker arrays
pi_c = 3:.1:40;
nth_list = zeros(1, 371)
np_list = zeros(1, 371)
no_list = zeros(1, 371)
ST_list = zeros(1, 371)
phi_list = zeros(1, 371)
T3_rev_list = zeros(1, 371)
%Use for loop to get efficiencies, equivalence ratio, and specific thrust
%for every pi_c value
[P2,T2] = inlet_rev_con_cp(T0,P0,M0)

for i = 1:length(pi_c)


[T3_rev_list(i), ~] = comp_rev_low_ma_con_cp(pi_c(i), T2, Cp_con);
P3 = pi_c(i) * P2;

[phi_list(i) , f] = comb_rev_low_mach_con_cp(T3_rev_list(i),T4, Cp_con);

pi_t = pi_c(i);
[T5_rev, W_rev] = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con);

P5 = P2;

[P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5_rev, P0);

%we get specific thrust, ST, from lecture 7, considering f:
ST_list(i) = v9 - v0;

%Then we get thermal efficiency, propulsive efficiency, and overall
%efficiency
Qc_list(i) = delta_h_con_cp(T4,T3_rev_list(i),Cp_con)/.029;      %J/mol*(1mol/.029kg)
nth_list(i) = ((1+f)*v9^2 - v0^2)/Qc_list(i);

np_list(i) = ST_list(i)*v0*2/((1+f)*v9^2-v0^2); %Lecture 7

no_list(i) = nth_list(i)*np_list(i);
end

%we can repeat the same process for variable Cp





subplot(2,1,1)
plot(pi_c, ST_list)
title('Specific Thrust at 16.2 km and M=2')
xlabel('Compressor Pressure Ratio')
ylabel('Specific Thrust, N/(kg/s)')

subplot(2,1,2)
plot(pi_c,no_list)
hold on
plot(pi_c,nth_list)
plot(pi_c,np_list)

figure;
plot(pi_c, phi_list)

figure;
plot(pi_c, T3_rev_list)