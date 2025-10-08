function [isen_tf_con_cp] = isen_tf_con_cp(Cp_const, Ti, pi) 

%Assuming process is isentropic, ds = 0, and we can use T-P relations.

%We also need to find the gas constant for air, 

Ru = 8.3144;
isen_tf_con_cp = Ti * (pi)^(Ru/Cp_const);

end 