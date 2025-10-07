%CA2 Constant CP full run

%C1
%[P2,T2] = inlet_rev_con_cp(T1,P1,M1)

%C3
%Define known turbojet parameters
T4 = 1450+273; %K
M0 = 2;
%At 16.2 km altitude, from textbook appendix,
T0 = 216.6; %K
P0 = (7565-10350)/(18-16)*.2 + 10350; %Pa, interpolated from table

