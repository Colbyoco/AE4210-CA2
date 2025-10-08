function [P9, T9, M9, v9] = nozzle_rev_con_cp(P5, T5, P0)
%Modeling Exhaust in the Nozzle from 5-9
%Outputs of P9, T9, M9
%Inputs of P5, T5, M5

R= 287;
gam = 1.4;

%P5 and T5 are stagnation temperatures
Pt5 = P5;
Tt5 = T5;
P9 = P0;

%Now solving for M9 using pressure equation
M9 = (((Pt5/P9)^((gam-1)/gam)-1)*(2/(gam-1)))^0.5;

%Rearranging Temperature equation to get T9
T9 = Tt5/(1+(gam-1)*M9^2/2);

%solving for speed of sound
a9=sqrt(gam*R*T9);
v9 = M9*a9;
end