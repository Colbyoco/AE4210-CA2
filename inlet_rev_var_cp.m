
function [T2, P2] = inlet_rev_var_cp(T1,P1, M1)
%Function to get P2 and T2 based off Ambient P0, T0, and M0 with variable
%Cp

%First, creating an initialized T2 guess for the fsolve..
R = 287; 
gam_c = 1.4; 
a1 = sqrt(gam_c*R*T1);
u1 = M1*a1;

T2_guess = T1*(1+(gam_c-1)*M1^2/2);
delta_h_needed = u1^2/2;

%use the guess for solve T2
options = optimset('Display', 'off', 'TolFun', 1e-8, 'TolX', 1e-8);
T2 = fsolve(@(T) delta_h_var_cp(T1, T)/0.029 - delta_h_needed, T2_guess, options);

%For the P2 Guess, we want to guess P2 until the isentropic tf matches T2
P2_guess = P1*(T2/T1)^(gam_c/(gam_c-1));

options = optimset('Display', 'off', 'TolFun', 1e-8, 'TolX', 1e-8);
P2 = fsolve(@(P) isen_tf_var_cp(T1,P1, P) - T2, P2_guess, options);
end

