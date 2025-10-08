function [P9, T9, M9, v9] = nozzle_rev_var_cp(P5, T5, P0)
%Modeling Exhaust in the Nozzle from 5-9 for Variable Cp
%Outputs of P9, T9, M9
%Inputs of P5, T5, M5
R = 287;
%P5 and T5 are stagnation temperatures
Pt5 = P5;
Tt5 = T5;
P9 = P0; %Given

%We know from 5-9, the entire thing is isentropic, so we can use func
T9 = isen_tf_var_cp(Tt5, Pt5, P9);

%To get M9, we need to find the velocity at 9
v9 = sqrt(2*delta_h_var_cp(T9, Tt5));

%also variable cp based on delta_h
dT = 1;  % Small temperature increment [K]
delta_h_dT = delta_h_var_cp(T9, T9 + dT);  % For Cp calculation
Cp9 = delta_h_dT / dT;  % Cp at T9 [J/(kg·K)]
Cv9 = Cp9 - R;  % Cv at T9
gamma9 = Cp9 / Cv9;  % Specific heat ratio at T9

a9=sqrt(gamma9*R*T9);
M9 = v9/a9;
end
