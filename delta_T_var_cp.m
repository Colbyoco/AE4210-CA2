function [delta_T] = delta_T_var_cp(T1,W_irrev)

% Calculate delta_t with initial T1

% Initial guess for T2 using average Cp
% Rough estimate: delta_T ≈ delta_h / Cp_avg (where Cp_avg ≈ 29 J/mol·K for air)
TB_guess = T1 + W_irrev/ 29;

% Use fsolve to find T2 where delta_h_var_cp(T1, T2) = delta_h_target
options = optimset('Display', 'off', 'TolFun', 1e-6, 'TolX', 1e-6);
TB_final = fsolve(@enthalpy_error, TB_guess, options);

delta_T = TB_final - T1;

    % Nested function: calculates error between calculated and required enthalpy change
    function error = enthalpy_error(TB_guess)
        % Calculate delta_h = hB - hA for this TB guess
        calculated_delta_h = delta_h_var_cp(T1, TB_guess);
        % Error is difference from compressor work (W_irrev = delta_h for compressor)
        error = calculated_delta_h - W_irrev;
    end

end
