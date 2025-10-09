function error = work_error(pi_t, T4, Cp_con, W_comp)
    % Get turbine work
    [~, W_turb] = turb_rev_low_ma_con_cp(pi_t, T4, Cp_con);
    
    % Work balance: Turbine work (on 1+f flow) = Compressor work (on 1 flow)
    % W_turb * (1+f) = W_comp
    error = W_turb + W_comp;
end