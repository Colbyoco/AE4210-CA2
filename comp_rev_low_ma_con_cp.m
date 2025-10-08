function [T3_rev, W_rev] = comp_rev_low_ma_con_cp(pi_c, T2, Cp_con)
%Function to calculate T3 Reversible and W Reversible if given P2,
%P3, T2, pi_C

%First, we can use subroutine 3a to get the temperature change as a function
%of pressure ratio and initial temperature.

T3_rev = isen_tf_con_cp(Cp_con, T2, pi_c); 

%Then, we can use the subroutine 1 to find the reversible work of the
%compressor
W_rev = delta_h_con_cp(T3_rev,T2,Cp_con);