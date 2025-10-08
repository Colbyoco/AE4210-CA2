function [T5_rev,W_rev] = turb_rev_low_ma_var_cp(pi_t,P4, T4)
%Function to calculate T3 Reversible and W Reversible if given T1, P1, P2
P5 = P4/pi_t;

%First, we can use subroutine 3b to get the temperature change 
T5_rev = isen_tf_var_cp(T4, P4, P5);

%Then, we can use the subroutine 2 to find the reversible work of the
%turbine
W_rev = delta_h_var_cp(T4, T5_rev);
end