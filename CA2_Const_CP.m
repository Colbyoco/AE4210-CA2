%CA2 Constant CP full run

%C1
%[P2,T2] = inlet_rev_con_cp(T1,P1,M1)

%C3
%Define known turbojet parameters
T4 = 1450+273; %K
M0 = 2;
gam = 1.4;
R = 287; %J/kgK
%At 16.2 km altitude, from textbook appendix,
T0 = 216.6; %K
P0 = (7565-10350)/(18-16)*.2 + 10350; %Pa, interpolated from table

%Define Speed of Sound
a0 = sqrt(gam*R*T0); %m/s

%Using equations from lecture 24 example,
tau_r = 1 + (gam-1)/2*M0^2
pi_r = tau_r^(gam/(gam-1))
tau_l = T4/T0

pi_c = 20;

T_ma = a0*sqrt(2/(gam-1)*(tau_l*(1-1/(tau_r*pi_c) ^ ((gam-1)/gam)) - tau_r*(pi_c^((gam-1)/gam) -1)))-M0