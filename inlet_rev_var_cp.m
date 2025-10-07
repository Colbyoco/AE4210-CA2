function [outputArg1,outputArg2] = inlet_rev_var_cp()
%Function to get P2 and T2 based off Ambient P0, T0, and M0 with variable
%Cp

delta_h = delta_h_var_cp(T0, T2);
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

