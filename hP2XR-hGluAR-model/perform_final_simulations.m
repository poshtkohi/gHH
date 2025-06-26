%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function perform_final_simulations()
    %----- Prepare the Environment -------------------------%
    cleanup_environment();
    %----- Receptor Selection ------------------------------%    
    %receptor_name = "hp2x7";
    %receptor_name = "hp2x6";
    %receptor_name = "hp2x5";
    %receptor_name = "hp2x4";
    receptor_name = "hp2x3";
    %receptor_name = "hp2x2";
    %receptor_name = "hp2x1";
    %receptor_name = "hglua1";
    opt = model_fitting_configurations(receptor_name);
    opt_final = model_final_param_configurations(receptor_name);
    % Define the ATP concentrations to plot
    %ATP_levels = [0.1 ;0.3 ; 1 ; 3; 50; 100]; % hP2X1: Define ATP levels
    %ATP_levels = [0.2; 0.5; 2; 3; 10; 50; 100; 150;]; % hP2X1: Define ATP levels
    %ATP_levels = [3; 5; 6; 7; 10; 20; 40; 100; 300; 400];
    %--------------hP2X1--------------%
    %{
    ATP_levels = [0.1; 0.3; 0.5; 1; 4; 10; 50; 100; 120];
    ATP_levels = [10];
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 6;
    method = "pchip";
    %}
    %--------------hP2X2--------------%
    %{
    ATP_levels = [1; 5; 10; 20; 50; 100; 200; 250; 300;];
    %ATP_levels = [10];
    t1 = 2; t2 = 30; t_max = 40;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X3--------------%
    %%{
    ATP_levels = [0.1; 0.3; 1; 3; 10; 50; 80; 100];
    %ATP_levels = [0.9];
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 3; t_max = 5;
    method = "linear";
    %%}
    %--------------hP2X4--------------%
    %{
    %ATP_levels = [0.5; 1; 3; 10; 30; 50; 100; 150; 300; 500;];
    ATP_levels = [10];
    t1 = 2; t2 = 30; t_max = 50;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X5--------------%
    %{
    ATP_levels = [0.5; 1; 3; 5; 10; 30; 90; 100;];
    %ATP_levels = [10]; 
    t1 = 2; t2 = 28; t_max = 50;
    %t1 = 1; t2 = 4; t_max = 20;
    method = "pchip";
    %}
    %--------------hP2X6--------------%
    %{
    ATP_levels = [1; 5; 10; 30; 50; 100;];
    ATP_levels = [30];
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 4; t_max = 8;
    %method = "pchip";
    %}
    %--------------hP2X7--------------%
    %{
    ATP_levels = [0.01; 0.02; 0.05; 0.1; 0.2; 0.5; 0.8; 1;];  % Low Levels of ATP
    ATP_levels = [1.5; 2; 3; 4; 5; 6; 7; 10;];  % High Levels of ATP
    ATP_levels = [1];
    t1 = 2; t2 = 100; t_max = 120;
    %t1 = 1; t2 = 4; t_max = 8;
    method = "linear";
    opt.comparison = false;
    %}
    %--------------hglua1--------------%
    %{
    %ATP_levels = [0.05; 0.1; 0.2; 0.5; 1; 2; 5; 10];%; 3; 5; 10;];
    ATP_levels = [10];
    t1 = 2; t2 = 30; t_max = 35;
    %t1 = 1; t2 = 6; t_max = 9;
    method = "linear";
    %}
    

    %ATP_levels = [0.01; 0.02; 0.05; 0.1; 0.5; 1];
    %ATP_levels = [1.5; 2; 3 ; 4; 5; 6 ; 8; 10; 100];

    num_data_points = 100000;
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
    my_opt.sa_mode = false;
    
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
    % --------------------------------------------------%
    x0 = [0; 0; 1; 1;]; % Initial conditions
    odeopt = odeset;%('RelTol', 1e-8, 'AbsTol', 1e-8);%, 'InitialStep', 1e-2, 'MaxStep', 1e-3);
    tint = linspace(0, t_max, num_data_points)';
    tspan = [0; t_max];
    
    min_I = 0;
    
    figure;
    hold on;

    % Define colors
    plot_colors = lines(numel(ATP_levels));

    % Array to store handles for each plot for legend
    hSim = gobjects(numel(ATP_levels), 1); % Handles for simulated data

    for i = 1:length(ATP_levels)
        my_opt.A = ATP_levels(i);
        my_opt.Am = my_opt.A; 
        my_opt.t1 = t1;
        my_opt.t2 = t2;
        %my_opt.params = opt_final.params(i, :);
        
        % Simulate the model
        sol = ode15s(@(t, x, opt)(ode_gHH(t, x, my_opt)), tspan, x0, odeopt, my_opt);
        X = deval(sol, tint);

        m1 = X(1, :)';
        m2 = X(2, :)';
        h1 = X(3, :)';
        h2 = X(4, :)';
        h3 = 1;

        % Calculate the currents
        simulated_current = total_gHH_current(m1, m2, h1, h2, h3, my_opt);
        
        current_min_I = min(simulated_current);
        if(current_min_I < min_I)
            min_I = current_min_I;
        end
        
        % Plotting the simulated currents
        %'MarkerIndices', 1:opt.steps:length(opt.tint)
        hSim(i) = plot(tint, simulated_current, '-', 'MarkerIndices', 1:steps:length(tint), 'LineWidth', LineWidth  ,'Color' , plot_colors(i,:), 'DisplayName', [sprintf('%s = ', opt.agonist_name) num2str(ATP_levels(i)) opt_final.agonist_unit_latex ', Sim.']);
    end
    
    mm = min_I;
    plot([my_opt.t1 my_opt.t2], [mm/3 mm/3], '--k' , 'LineWidth', 0.05);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/3, opt_final.agonist_name, 'FontWeight', 'bold', 'FontSize', 14); 

    xlabel(sprintf('Time (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue');
    ylabel(sprintf('Current (%s)', opt_final.current_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    %title('Fitted and Experimental Currents for Multiple ATP Levels');
    %legend(hExp, 'Location', 'best');
    legend(hSim, 'Location', 'best');
    ylim([min(simulated_current) 0]);
    
    hold off;
    
    plot_state_variables(ATP_levels, opt_final, my_opt);
end
%-------------------------------------------------------%
% Plot model state variables for a specefic agonist level
function plot_state_variables(ATP_levels, opt_final, my_opt)
    
    which_level = 1;
    my_opt.A = ATP_levels(which_level);
    my_opt.Am = my_opt.A;
    my_opt.receptor_name = opt_final.receptor_name;
    my_opt.fitting_mode = false;
    t_max = 60; %
    tspan = [0 t_max];
    LineWidth = 2.5;
    
    my_opt.params = opt_final.params(which_level, :);
    
    tint = linspace(0, t_max, 100000)';
    
    x0 = [0; 0; 1; 1;]; % Initial conditions
    tol = 1e-7;
    odeopt = odeset;%('RelTol', tol, 'AbsTol', tol, 'InitialStep', 1e-1, 'MaxStep', 1e-2);
    
    sol = ode15s(@(t, x, opt)(ode_gHH(t, x, my_opt)), tspan, x0, odeopt, my_opt);
        
    X = deval(sol, tint);

    m1 = X(1, :)';
    m2 = X(2, :)';
    h1 = X(3, :)';
    h2 = X(4, :)';
    
    str = {'m_1', 'm_2', 'h_1', 'h_2'};

    if mod(my_opt.A, 1) == 0
        ATP_str = sprintf('%s=%d%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);  % Treat as integer
    elseif my_opt.A < 0.1
        ATP_str = sprintf('%s=%1.2f%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);
    else
        ATP_str = sprintf('%s=%1.1f%s', opt_final.agonist_name, my_opt.A, opt_final.agonist_unit_latex);
    end
    
    figure('Name', sprintf('State variables for %s at A=%f%s', opt_final.receptor_name, my_opt.A, opt_final.agonist_unit));
    %---- m1 ----%
    subplot(2, 2, 1);
    mm = max(m1);
    hold on
    plot(tint, m1, '-', 'LineWidth', LineWidth , 'Color', 'magenta'); xlabel(sprintf('t (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue'); ylabel(str(1), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '--k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str, 'FontWeight', 'bold', 'FontSize', 12); 
    xlim([0 t_max]);
    %xlim([0 10]);
    %xlim([0 5]);
    hold off
    %---- m2 ----%
    subplot(2, 2, 2);
    mm = max(m2);
    hold on
    plot(tint, m2, 'LineWidth', LineWidth , 'Color', 'red'); xlabel(sprintf('t (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue'); ylabel(str(2), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '--k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str, 'FontWeight', 'bold', 'FontSize', 12); 
    xlim([0 t_max]);
    %xlim([0 10]);
    %xlim([0 5]);
    hold off
    %---- h1 ----%
    subplot(2, 2, 3);
    mm = max(h1) + min(h1);
    hold on
    plot(tint, h1,  'LineWidth', LineWidth , 'Color', 'black'); xlabel(sprintf('t (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue'); ylabel(str(3), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '--k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str, 'FontWeight', 'bold', 'FontSize', 12);
    xlim([0 t_max]);
    %xlim([0 300]);
    %xlim([0 15]);
    hold off
    %---- h2 ----%
    subplot(2, 2, 4);
    mm = max(h2) + min(h2);
    hold on
    ss = 1;
    plot(tint/ss, h2,  'LineWidth', LineWidth , 'Color', 'green'); xlabel(sprintf('t (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue'); ylabel(str(4), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    %plot(tint/ss, h2); xlabel('t (m)'); ylabel(str(4));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '--k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1/ss)/2, mm/2 - 0.05 * mm/2, ATP_str, 'FontWeight', 'bold', 'FontSize', 12);
    xlim([0 t_max]);
    %xlim([0 50]);
    %xlim([0 10]);
    %xlim([0 200]);
    hold off
    %drawnow update;
end
%-------------------------------------------------------%
