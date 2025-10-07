function [P2,T2] = inlet_rev_con_cp(T1,P1,M1)
%Modeling an inlet diffuser (0-2) with initial inputs P0, T0, M)
%To get P2 and T2
gam = 1.4; %Constant Cp case

%Using Isentropic flow equations...
Pt = P1*(1+(gam-1)*M1^2/2)^gam/(gam-1);
Tt = T1*(1+(gam-1)*M1^2/2);

P2 = Pt;
T2 = Tt;
end

%soegbuiebi