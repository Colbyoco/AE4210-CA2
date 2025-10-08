function [delta_T_cp_300K] = delta_T_con_cp(W_irrev, Cp_con)
%Simple Function to the get the *actual* change in temperature between T2
%and T3a
delta_T_cp_300K = W_irrev/Cp_con;
end