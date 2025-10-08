function [phi,f] = comb_rev_low_mach_var_cp(T3,T4)
%After balancing the combustion reaction with dodecane, there are 176.12 mol of air. 
%   From this, we can use t, the equivalence ratio equation for lecture 12 
nair = 176.12; %mol
Qc = 2*(-82.8)-24*(-94)-26*(-57.8);
phi = nair*delta_h_var_cp(T3,T4)/(Qc*4184);

%To get the stoichiometric fuel area ratio...
C= 12.011;
H = 1.01;
O = 16;
N = 14.01;

m_fuelst =12*C + 26*H;
m_airst = 18.5*(2*O+(79/21)*2*N);

fst = m_fuelst/m_airst;
f = phi*fst;
end