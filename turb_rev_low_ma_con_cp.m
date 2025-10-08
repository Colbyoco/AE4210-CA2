function W_rev = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con)
%Function to calculate T3 Reversible and W Reversible if given P2,
%P3, T2, pi_t

%First, we can use subroutine 3a to get the temperature change as a function
%of pressure ratio and initial temperature.

T5_rev = isen_tf_con_cp(Cp_con, T4, 1/pi_t); 

%Then, we can use the subroutine 1 to find the reversible work of the
%turbine
W_rev = delta_h_con_cp(T5_rev,T4,Cp_con);


end

