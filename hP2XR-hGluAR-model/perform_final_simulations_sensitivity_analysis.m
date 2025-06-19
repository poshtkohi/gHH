%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function perform_final_simulations_sensitivity_analysis()
    %----- Prepare the Environment -------------------------%
    cleanup_environment();
    %----- Receptor Selection ------------------------------%
    receptor_name = "hp2x7";
    %receptor_name = "hp2x6";
    %receptor_name = "hp2x5";
    %receptor_name = "hp2x4";
    %receptor_name = "hp2x3";
    %receptor_name = "hp2x2";
    %receptor_name = "hp2x1";
    %receptor_name = "hglua1";
    opt = model_fitting_configurations(receptor_name);
    opt_final = model_final_param_configurations(receptor_name);
    %--------------hP2X1--------------%
    %%{
    ATP = 3;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 6;
    method = "pchip";
    %%}
    %--------------hP2X2--------------%
    %{
    ATP = 3;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X3--------------%
    %{
    ATP = 3;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 3; t_max = 5;
    method = "linear";
    %}
    %--------------hP2X4--------------%
    %{
    ATP = 50;
    t1 = 2; t2 = 30; t_max = 45;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X5--------------%
    %{
    ATP = 30; 
    t1 = 2; t2 = 30; t_max = 45;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X6--------------%
    %{
    ATP = 30;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 8;
    %method = "pchip";
    %}
    %--------------hP2X7--------------%
    %{
    ATP = 3;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 8;
    method = "linear";
    opt.comparison = false;
    %}
    %--------------hglua1--------------%
    %{
    ATP = 10;
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 6; t_max = 9;
    method = "linear";
    %}
    
    %s = 1e-3; %dp = 0.1%
    %s = 1e-2; %dp = 1%
    s = 10e-2; %dp = 10%

    num_data_points = 1000;
    steps = 1;
    LineWidth = 1;
    
    %opt_final.params(1, :)
    if receptor_name == "hp2x2" || receptor_name == "hglua1"
        my_opt.n33 = opt.n33;
    end
    my_opt.n22 = opt.n22;
    my_opt.n1 = opt.n1;
    my_opt.n2 = opt.n2;
    my_opt.n3 = opt.n3;
    my_opt.n4 = opt.n4;
    my_opt.n5 = opt.n5;
    my_opt.gm = opt.gm;
    %my_opt.fitting_mode = true;
    my_opt.fitting_mode = false;
    my_opt.receptor_name = receptor_name;
    my_opt.sa_mode = true;
    
    % ----- Create interpolated parameters ----------- %
    % Initialize a cell array
    %%smoother_param = cell(opt.num_of_parameters); % numFits is the number of fits you plan to perform
    if receptor_name == "hp2x6"
        my_opt.pp_param = opt_final.params;
    else
        pp_param = cell(opt.num_of_parameters - 1); % numFits is the number of fits you plan to perform
        for i = 1:(opt.num_of_parameters - 1)
            params = opt_final.params(:, i);
            % Smoothing the data
            %%mode = 'linearinterp'; % 'linearinterp', 'smoothingspline', 'cubicinterp'
            %%smoother_param{i} = fit(opt_final.A, params, mode);
            %tint = linspace(opt_final.A(1), opt_final.A(end), 400)';
            %experimental_current = smoother(tint);
            %https://uk.mathworks.com/help/matlab/ref/double.interp1.html#btwp6lt-1-method
            %method = 'linear';
            %method = "pchip";
            pp = interp1(opt_final.A, params, method, 'pp');
            pp_param{i} = pp;
        end
        %%my_opt.smoother_param = smoother_param;
        my_opt.pp_param = pp_param;
    end
    
    %--------------SA--------------%
    % Sensitivity analysis (SA)
    my_opt.SA = zeros(8, 1);        
    if receptor_name == "hp2x6"
        p(1) = my_opt.pp_param(1);
        p(2) = my_opt.pp_param(2);
        p(3) = my_opt.pp_param(3);
        p(4) = my_opt.pp_param(4);
        p(5) = my_opt.pp_param(5);
        p(6) = my_opt.pp_param(6);
        p(7) = my_opt.pp_param(7);
        p(8) = my_opt.pp_param(8);
    else
        p(1) = ppval(my_opt.pp_param{1}, ATP);
        p(2) = ppval(my_opt.pp_param{2}, ATP);
        p(3) = ppval(my_opt.pp_param{3}, ATP);
        p(4) = ppval(my_opt.pp_param{4}, ATP);
        p(5) = ppval(my_opt.pp_param{5}, ATP);
        p(6) = ppval(my_opt.pp_param{6}, ATP);
        p(7) = ppval(my_opt.pp_param{7}, ATP);
        p(8) = ppval(my_opt.pp_param{8}, ATP);
    end
    %opt.p
    % --------------------------------------------------%
    x0 = [0; 0; 1; 1;]; % Initial conditions
    odeopt = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);%, 'InitialStep', 1e-2, 'MaxStep', 1e-3);
    %odeopt = odeset;%('InitialStep', 1e-3, 'MaxStep', 1e-3);%('RelTol', 1e-16, 'AbsTol', 1e-16);
    tint = linspace(0, t_max, num_data_points)';
    tspan = [0; t_max];
    my_opt.A = ATP;
    my_opt.Am = my_opt.A; 
    my_opt.t1 = t1;
    my_opt.t2 = t2;
    
    m = length(my_opt.SA);
    for i=1:1:m
        my_opt.SA(i) = s;
        sol_SA(i) = ode15s(@(t, x, opt)(ode_gHH(t, x, my_opt)), tspan, x0, odeopt, my_opt);
        my_opt.SA(i) = 0;
        sol(i) = ode15s(@(t, x, opt)(ode_gHH(t, x, my_opt)), tspan, x0, odeopt, my_opt);
        %i
    end
    
    for i=1:1:m
        
        X_SA = deval(sol_SA(i), tint);
        m1 = X_SA(1, :)';
        m2 = X_SA(2, :)';
        h1 = X_SA(3, :)';
        h2 = X_SA(4, :)';
        h3 = 1;
        simulated_current_SA = total_gHH_current(m1, m2, h1, h2, h3, my_opt);
        
        X = deval(sol(i), tint);
        m1 = X(1, :)';
        m2 = X(2, :)';
        h1 = X(3, :)';
        h2 = X(4, :)';
        h3 = 1;
        simulated_current = total_gHH_current(m1, m2, h1, h2, h3, my_opt);
        
        opt.SA(i) = s;
            
        dp = p(i) * opt.SA(i);
        opt.SA(i) = 0;
        for j=1:1:length(simulated_current)
            SA(i, j) = (p(i)/(min(simulated_current))) * (simulated_current_SA(j) - simulated_current(j)) / dp;
            %SAA(i, j) = (simulated_current_SA(j) - simulated_current(j)) / dp/(simulated_current(j) + 0.1);
        end
        %i
    end
    
    fig1 = figure('Name', sprintf('Sensitivity analysis of the %s', receptor_name));
    fig1.WindowStyle = 'docked';
    Markers = {'+', 'o', '*', 'x', 'v', 'd', '^', 's', '>', '<', 'M', '-', '-+', '-o', '-*', '-x', '-v', 'y', '-z'};
    if mod(my_opt.A, 1) == 0
        ATP_str = sprintf('%s=%d%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);  % Treat as integer
    elseif my_opt.A < 0.1
        ATP_str = sprintf('%s=%1.2f%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);
    else
        ATP_str = sprintf('%s=%1.1f%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);
    end
    hold on;
    steps = 50;
    for i=1:1:m
        plot(tint, SA(i, :) * 0.5, strcat('-', Markers{i}), 'MarkerIndices', 1:steps:length(tint));
        %plot(tint, SA(i, :), strcat('-', Markers{i}), 'MarkerIndices', 1:steps:length(tint));
        %plot(tint, SA(i, :));
        % Remove NaN values from SA and corresponding time points
    end
    plot([t1 t2], [-0.2 -0.2], '--k' , 'LineWidth', 2);
	text(t1 + (t2 - t1)/2, -0.18, ATP_str, 'FontWeight', 'bold', 'FontSize', 12);
    %plot(tint, simulated_current_SA - simulated_current, 'MarkerIndices', 1:steps:length(tint));
    hold off
   
    legend('$${\alpha}_{m_1}$$', '$${\beta}_{m_1}$$', '$${\alpha}_{m_2}$$', '$${\beta}_{m_2}$$', '$${\alpha}_{h_1}$$', '$${\beta}_{h_1}$$', '$${\alpha}_{h_2}$$', '$${\beta}_{h_2}$$', 'Interpreter', 'latex');
    %title('\color{magenta}Cytosolic Ca^{2+} concentration');
    %title('Whole-Cell current');
    % Format perturbation: Remove ".0" if no decimal part
    if mod(s * 100, 1) == 0
        title_str = sprintf('Whole-Cell Current (%.0f%% Perturbation)', s * 100);
    else
        title_str = sprintf('Whole-Cell Current (%.1f%% Perturbation)', s * 100);
    end
    title(title_str);
    xlabel(sprintf('Time (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue');
    ylabel('Relative sensitivity', 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    %xlim([0 t_max]);
    %xlim([0 40]);
    if receptor_name == "hglua1"
        ylim([-0.4 0.8]);
    end
    %plot(tint, simulated_current);
    %simulated_current
end
%-------------------------------------------------------%