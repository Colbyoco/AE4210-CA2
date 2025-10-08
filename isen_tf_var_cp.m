function [isen_tf_var_cp] = isen_tf_var_cp(T1, P1, P2) 

%Assuming process is isentropic, ds = 0, and we need to solve for Tf
%iteratively

%Use equation found in lecture 5 which relates entropy change to
%temperature and pressure relations
N_500 = [28.98641, 1.853978, -9.647459, 16.63537, 0.000117, -8.671914, 226.4168, 0];
O_700 = [31.32234, -20.23531, 57.865644, -36.50624, -0.007374, -8.903471, 246.7945, 0];

N_2000 = [19.50583, 19.88705, -8.598535, 1.369784, 0.527601, -4.935202, 212.39, 0];
O_2000 = [30.03235, 8.772972, -3.988133, 0.788313, -0.741599, -11.32468, 236.1663, 0];

N_6000 = [35.51872, 1.128728, -0.196103, 0.014662, -4.553760, -18.97091, 224.9810, 0];
O_6000 = [20.91111, 10.72071, -2.020498, 0.146449, 9.245722, 5.337651, 237.6185, 0];

%Start with  Standard Entropy at T1 
t1 = T1/1000;
if t1 <= .500
    s1n = N_500(1)*log(t1) + N_500(2)*t1 + N_500(3)*t1^2/2 + N_500(4)*t1^3/3 - N_500(5)/(2*t1^2) + N_500(7);
elseif t1 <= 2
    s1n = N_2000(1)*log(t1) + N_2000(2)*t1 + N_2000(3)*t1^2/2 + N_2000(4)*t1^3/3 - N_2000(5)/(2*t1^2) + N_2000(7);
elseif t1 <= 6
    s1n = N_6000(1)*log(t1) + N_6000(2)*t1 + N_6000(3)*t1^2/2 + N_6000(4)*t1^3/3 - N_6000(5)/(2*t1^2) + N_6000(7);
end

if t1 < .700
    s1o = O_700(1)*log(t1) + O_700(2)*t1 + O_700(3)*t1^2/2 + O_700(4)*t1^3/3 - O_700(5)/(2*t1^2) + O_700(7);
elseif t1 < 2
    s1o = O_2000(1)*log(t1) + O_2000(2)*t1 + O_2000(3)*t1^2/2 + O_2000(4)*t1^3/3 - O_2000(5)/(2*t1^2) + O_2000(7);
elseif t1 < 6
    s1o = O_6000(1)*log(t1) + O_6000(2)*t1 + O_6000(3)*t1^2/2 + O_6000(4)*t1^3/3 - O_6000(5)/(2*t1^2) + O_6000(7);
end

%pressure of each gas 
Ru = 8.31446;
Pn1 = .79*P1;
Pn2 = .79*P2;
Po1 = .21*P1;
Po2 = .21*P2;

% Initial guess with ds = 0
T2_initial = T1 * (P2/P1)^(0.4/1.4);

% Use fsolve...
options = optimset('Display', 'off', 'TolFun', 1e-8, 'TolX', 1e-8);
isen_tf_var_cp = fsolve(@entropy_change_calc, T2_initial, options);

    function delta_s = entropy_change_calc(T2)
        t2 = T2/1000;
        
        % T2: entropy of n2
        if t2 <= 0.500
            s2n = N_500(1)*log(t2) + N_500(2)*t2 + N_500(3)*t2^2/2 + N_500(4)*t2^3/3 - N_500(5)/(2*t2^2) + N_500(7);
        elseif t2 <= 2
            s2n = N_2000(1)*log(t2) + N_2000(2)*t2 + N_2000(3)*t2^2/2 + N_2000(4)*t2^3/3 - N_2000(5)/(2*t2^2) + N_2000(7);
        else % t2 <= 6
            s2n = N_6000(1)*log(t2) + N_6000(2)*t2 + N_6000(3)*t2^2/2 + N_6000(4)*t2^3/3 - N_6000(5)/(2*t2^2) + N_6000(7);
        end
        
        % T2: entropy of O2
        if t2 <= 0.700
            s2o = O_700(1)*log(t2) + O_700(2)*t2 + O_700(3)*t2^2/2 + O_700(4)*t2^3/3 - O_700(5)/(2*t2^2) + O_700(7);
        elseif t2 <= 2
            s2o = O_2000(1)*log(t2) + O_2000(2)*t2 + O_2000(3)*t2^2/2 + O_2000(4)*t2^3/3 - O_2000(5)/(2*t2^2) + O_2000(7);
        else % t2 <= 6
            s2o = O_6000(1)*log(t2) + O_6000(2)*t2 + O_6000(3)*t2^2/2 + O_6000(4)*t2^3/3 - O_6000(5)/(2*t2^2) + O_6000(7);
        end
        
        % total entropy change
        delta_s = 0.79*(s2n - Ru*log(Pn2) - s1n + Ru*log(Pn1)) + ...
                  0.21*(s2o - Ru*log(Po2) - s1o + Ru*log(Po1));
    end

end