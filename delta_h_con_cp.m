function [delta_h_con_cp] = delta_h_con_cp(Tf,Ti,Cp_con)
%delta h function given constant cp.....
% From Lecture, we know.....
% h2 - h1 = Cp(T2-T1)

delta_h_con_cp = Cp_con*(Tf-Ti);

end