function [T3_rev, W_rev] = comp_rev_low_ma_var_cp(P2, pi_c, T2)
%Function to calculate T3 Reversible and W Reversible if given P2,
%P3, T2, pi_C
P3 = P2*pi_c;

%First, we can use subroutine 3a to get the temperature change as a function
%of pressure ratio and initial temperature.

T3_rev = isen_tf_var_cp(T2, P2, P3); 

%Then, we can use the subroutine 1 to find the reversible work of the
%compressor
W_rev = delta_h_var_cp(T2, T3_rev);
end