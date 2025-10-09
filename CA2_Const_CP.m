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
v0 = sqrt(1.4*287*T0)*M0; %

%Define pi_c range and tracker arrays
pi_c = 3:.1:40;
nth_list = zeros(1, 371);
np_list = zeros(1, 371);
no_list = zeros(1, 371);
ST_list = zeros(1, 371);
phi_list = zeros(1, 371);
nth_list_var = zeros(1, 371);
np_list_var = zeros(1, 371);
no_list_var = zeros(1, 371);
ST_list_var = zeros(1, 371);
phi_list_var = zeros(1, 371);
%Use for loop to get efficiencies, equivalence ratio, and specific thrust
%for every pi_c value
[P2,T2] = inlet_rev_con_cp(T0,P0,M0);
[T2_var, P2_var] = inlet_rev_var_cp(T0,P0, M0);
for i = 1:length(pi_c)

[T3_rev, W_rev_c] = comp_rev_low_ma_con_cp(pi_c(i), T2, Cp_con);
P3 = pi_c(i) * P2;

[phi_list(i) , f] = comb_rev_low_mach_con_cp(T3_rev,T4, Cp_con);

%To find pi_t, we create a function that returns Pi_t at which compressor
%work is equal to turbine work
pi_t_guess = pi_c(i)^.8;

work_balance = @(pi_t) work_error(pi_t, T4, Cp_con, W_rev_c);
options = optimset('Display', 'off', 'TolFun', 1e-8, 'TolX', 1e-8);
pi_t = fsolve(work_balance, pi_t_guess, options);

[T5_rev, ~] = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con);

P5 = P3/pi_t;
[P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5_rev, P0);

%we get specific thrust, ST, from lecture 7, considering f:
ST_list(i) = (1+f)*v9 - v0;

%Then we get thermal efficiency, propulsive efficiency, and overall
%efficiency
Qc = delta_h_con_cp(T4,T3_rev,Cp_con)/.029;     %J/mol*(1mol/.029kg)
nth_list(i) = ((1+f)*v9^2 - v0^2)/(2*Qc);

np_list(i) = ST_list(i)*v0*2/((1+f)*v9^2-v0^2); %Lecture 7

no_list(i) = nth_list(i)*np_list(i);

%we can do the same for variable Cp for the same range of Pi_c

[T3_rev_var, W_rev_c_var] = comp_rev_low_ma_var_cp(P2_var, pi_c(i), T2_var);

[phi_list_var(i),f] = comb_rev_low_mach_var_cp(T3_rev_var,T4);

P3_var = pi_c(i) * P2_var;
P4_var = P3_var;
pi_t_guess = pi_c(i)^.8;
work_balance = @(pi_t) work_error_var(pi_t, P4_var ,T4, W_rev_c_var);

pi_t = fsolve(work_balance, pi_t_guess);

P5_var = P4_var/pi_t;
[T5_rev_var,~] = turb_rev_low_ma_var_cp(pi_t,P4_var, T4);

[P9, T9, M9, v9] = nozzle_rev_var_cp(P5_var, T5_rev_var, P0);

ST_list_var(i) = (1+f)*v9 - v0;
%Then we get thermal efficiency, propulsive efficiency, and overall
%efficiency
Qc = delta_h_var_cp(T3_rev_var, T4)/.029;     %J/mol*(1mol/.029kg)
nth_list_var(i) = ((1+f)*v9^2 - v0^2)/(2*Qc);

np_list_var(i) = ST_list_var(i)*v0*2/((1+f)*v9^2-v0^2); %Lecture 7

no_list_var(i) = nth_list_var(i)*np_list_var(i);
end

%Plotting Specific Thrust
subplot(2,1,1)
plot(pi_c, ST_list,'r')
title('Specific Thrust at 16.2 km and M=2')
xlabel('Compressor Pressure Ratio')
ylabel('Specific Thrust, N/(kg/s)')
hold on
plot(pi_c, ST_list_var,'--','Color','red')
hold off
legend('Constant Cp', 'Variable Cp')

subplot(2,1,2)
plot(pi_c,no_list,'b')
hold on
plot(pi_c,nth_list,'r')
plot(pi_c,np_list,'g')
title('Efficiencies, solid - constant Cp, dotted - variable Cp')
xlabel('Compressor Pressure Ratio')
ylabel('Efficiencies')
axis([0 40 .2 1])
plot(pi_c,no_list_var,'--','Color','b')
plot(pi_c,nth_list_var,'--','Color','r')
plot(pi_c,np_list_var,'--','Color','g')
legend('overall efficiency','thermal efficiency','propulsive efficiency')

%C3 part 2 answer for variable and constant Cp
[ST_max_const, max_const_idx] = max(ST_list)
max_pi_const = pi_c(max_const_idx)
phi_const = phi_list(max_const_idx)

[ST_max_var, max_var_idx] = max(ST_list_var)
max_pi_var = pi_c(max_var_idx)
phi_var = phi_list(max_var_idx)


%For C3 part 3, we know the static conditions and pi_c = 15.5
T4 = 1450+273; %K
M0 = 0; 

%At 16.2 km altitude, from textbook appendix,
T0 = 298; %K
P0 = 101300; %Pa, interpolated from table
Cp_con = 29.1970; %J/molK
v0 = sqrt(1.4*287*T0)*M0; %

%Define pi_c
pi_c_conc = 15.5;

%Go through whole engine cycle
[P2,T2] = inlet_rev_con_cp(T0,P0,M0);

[T3_rev, W_rev_c] = comp_rev_low_ma_con_cp(pi_c_conc, T2, Cp_con);
P3 = pi_c_conc * P2;

[phi , f] = comb_rev_low_mach_con_cp(T3_rev,T4, Cp_con);

%To find pi_t, we create a function that returns Pi_t at which compressor
%work is equal to turbine work
pi_t_guess = pi_c_conc;

work_balance = @(pi_t) work_error(pi_t, T4, Cp_con, W_rev_c);
pi_t = fsolve(work_balance, pi_t_guess);

[T5_rev, W_rev_t] = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con);

P5 = P3/pi_t;
[P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5_rev, P0);

%we get specific thrust, ST, from lecture 7, considering f:
ST_conc = (1+f)*v9 - v0;

thrust_const = ST_conc * 186

const_err = (thrust_const - 139400)/139400

%for variable cp, C3 part 3

[T2_var, P2_var] = inlet_rev_var_cp(T0,P0, M0);

[T3_rev_var, W_rev_c_var] = comp_rev_low_ma_var_cp(P2_var, pi_c_conc, T2_var);

[phi,f] = comb_rev_low_mach_var_cp(T3_rev_var,T4);

P3_var = pi_c_conc * P2_var;
P4_var = P3_var;
pi_t_guess = pi_c_conc^.8;
work_balance = @(pi_t) work_error_var(pi_t, P4_var ,T4, W_rev_c_var);
pi_t = fsolve(work_balance, pi_t_guess);


P5_var = P4_var/pi_t;
[T5_rev_var,~] = turb_rev_low_ma_var_cp(pi_t,P4_var, T4);

[P9, T9, M9, v9] = nozzle_rev_var_cp(P5_var, T5_rev_var, P0);

ST_conc_var = (1+f)*v9 - v0;

thrust_var = ST_conc_var * 186

var_err = (thrust_var - 139400)/139400