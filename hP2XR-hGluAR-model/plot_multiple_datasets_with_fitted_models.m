%----- Functions ---------------------------------------%
function plot_multiple_datasets_with_fitted_models()
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
    % Define the ATP concentrations to plot
    ATP_levels = opt_final.A; % Define ATP levels
    num_data_points = 10000;
    steps = 1;
    
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
        for i = 1:(opt.num_of_parameters-1)
            params = opt_final.params(:, i);
            % Smoothing the data
            %%mode = 'linearinterp'; % 'linearinterp', 'smoothingspline', 'cubicinterp'
            %%smoother_param{i} = fit(opt_final.A, params, mode);
            %tint = linspace(opt_final.A(1), opt_final.A(end), 400)';
            %experimental_current = smoother(tint);
            method = 'pchip';
            pp = interp1(opt_final.A, params,method, 'pp');
            pp_param{i} = pp;
        end
        %%my_opt.smoother_param = smoother_param;
        my_opt.pp_param = pp_param;
    end
    
    x0 = [0; 0; 1; 1;]; % Initial conditions
    odeopt = odeset;%('RelTol', 1e-6, 'AbsTol', 1e-6, 'InitialStep', 1e-2, 'MaxStep', 1e-3);
    
    min_I = 0;
    
    figure;
    hold on;

    % Define colors
    plot_colors = lines(numel(ATP_levels));

    % Array to store handles for each plot for legend
    hExp = gobjects(numel(ATP_levels), 1); % Handles for experimental data
    hSim = gobjects(numel(ATP_levels), 1); % Handles for simulated data

    %for i = 1:3
    %for i = 4:6
    %for i = 1:4
    %for i = 5:5
    for i = 1:length(ATP_levels)
        my_opt.A = ATP_levels(i);
        my_opt.Am = my_opt.A; 
        [my_opt.t1, my_opt.t2] = handle_atp_times(receptor_name, my_opt.A);
        my_opt.params = opt_final.params(i, :);
        % Load the experimental data        
        if my_opt.A < 1 && my_opt.A >= 0.1
            d = load(sprintf('data/%s/%s-%1.1f%s.dat', receptor_name, receptor_name, my_opt.A, opt_final.agonist_unit));
        elseif my_opt.A < 0.1
            d = load(sprintf('data/%s/%s-%1.2f%s.dat', receptor_name, receptor_name, my_opt.A, opt_final.agonist_unit));
        else
            d = load(sprintf('data/%s/%s-%d%s.dat', receptor_name, receptor_name, my_opt.A, opt_final.agonist_unit));
        end
        
        t = d(:, 1);
        experimental_current = d(:, 2);
        tspan = [0; t(end)];

        if receptor_name == "hp2x3"
            method = 'linear';
            pp = interp1(t, experimental_current, method, 'pp');
            tint = linspace(0, t(end), num_data_points)';
            experimental_current = ppval(pp, tint);
        else
            % Smoothing the data
            mode = 'linearinterp'; % 'linearinterp', 'smoothingspline', 'cubicinterp'
            smoother = fit(t, experimental_current, mode);
            tint = linspace(0, t(end), num_data_points)';
            experimental_current = smoother(tint);
        end
        
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
                
        % Plotting the experimental and simulated currents
        % Plot experimental data
        % 0.1 ;0.3 ; 1 ; 3; 100
        %if my_opt.A == 100
        %{
        my_opt.A
        chi(zeros(12, 1), my_opt.A, receptor_name, 1)
        chi(zeros(12, 1), my_opt.A, receptor_name, 2)
        chi(zeros(12, 1), my_opt.A, receptor_name, 3)
        chi(zeros(12, 1), my_opt.A, receptor_name, 4)
        chi(zeros(12, 1), my_opt.A, receptor_name, 5)
        chi(zeros(12, 1), my_opt.A, receptor_name, 6)
        chi(zeros(12, 1), my_opt.A, receptor_name, 7)
        chi(zeros(12, 1), my_opt.A, receptor_name, 8)
        %}
        hExp(i) = plot(tint, experimental_current, 'x', 'MarkerIndices', 1:200:length(tint), 'LineWidth', 1, 'Color', plot_colors(i,:), 'DisplayName', [sprintf('%s = ', opt.agonist_name) num2str(ATP_levels(i)) opt_final.agonist_unit_latex ', Exp.']);
        % This is just a placeholder
        hSim(i) = plot(tint, simulated_current, '--', 'MarkerIndices', 1:50:length(tint), 'LineWidth', 2.5, 'DisplayName', [sprintf('%s = ', opt.agonist_name) num2str(ATP_levels(i)) opt_final.agonist_unit_latex ', Fitted']);
        %end
        % Adding text annotation for ATP concentration

    end
    
    mm = min_I;
    plot([my_opt.t1 my_opt.t2], [mm/3 mm/3], '--k' , 'LineWidth', 0.05);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/3, opt.agonist_name, 'FontWeight', 'bold', 'FontSize', 14, 'Color', [1, 0, 0]); 

    xlabel(sprintf('Time (%s)', opt_final.time_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'blue');
    ylabel(sprintf('Current (%s)', opt_final.current_unit), 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.6, 0.4, 0.2]);
    %title('Fitted and Experimental Currents for Multiple ATP Levels');
    %legend(hExp, 'Location', 'best');
    legend([hExp; hSim], 'Location', 'best');
    %legend([hExp(1:3); hSim(1:3)], 'Location', 'best');
    %legend([hExp(4:6); hSim(4:6)], 'Location', 'best');
    %legend([hExp(1:4); hSim(1:4)], 'Location', 'best');
    %legend([hExp(5:5); hSim(5:5)], 'Location', 'best');
    ylim([min(simulated_current) 0]);
    hold off;
    
    %plot_state_variables(opt_final, my_opt);
end
%-------------------------------------------------------%
% Plot model state variables for a specefic agonist level
function plot_state_variables(opt_final, my_opt)
    
    which_level = 2;
    my_opt.A = opt_final.A(which_level);
    my_opt.Am = my_opt.A;
    my_opt.receptor_name = opt_final.receptor_name;
    my_opt.fitting_mode = true;
    [my_opt.t1, my_opt.t2] = handle_atp_times(opt_final.receptor_name, my_opt.A);
    t_max = 20;
    tspan = [0 t_max];
    
    my_opt.params = opt_final.params(which_level, :);
    
    tint = linspace(0, t_max, 1000)';
    
    x0 = [0; 0; 1; 1;]; % Initial conditions
    odeopt = odeset;%('RelTol', 1e-12, 'AbsTol', 1e-12, 'InitialStep', 1e-2, 'MaxStep', 1e-3);
    
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
    plot(tint, m1); xlabel('t (s)'); ylabel(str(1));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- m2 ----%
    subplot(2, 2, 2);
    mm = max(m2);
    hold on
    plot(tint, m2); xlabel('t (s)'); ylabel(str(2));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- h1 ----%
    subplot(2, 2, 3);
    mm = max(h1) + min(h1);
    hold on
    plot(tint, h1); xlabel('t (s)'); ylabel(str(3));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str);
    hold off
    %---- h2 ----%
    subplot(2, 2, 4);
    mm = max(h2) + min(h2);
    hold on
    ss = 1;
    plot(tint/ss, h2); xlabel('t (s)'); ylabel(str(4));
    %plot(tint/ss, h2); xlabel('t (m)'); ylabel(str(4));
    plot([my_opt.t1/ss my_opt.t2/ss], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1/ss + (my_opt.t2/ss - my_opt.t1/ss)/2, mm/2 - 0.05 * mm/2, ATP_str);
    hold off
    %drawnow update;
end
%-------------------------------------------------------%
function [t1, t2] = handle_atp_times(receptor_name, A)
    switch receptor_name
        case 'hp2x7'
            if A <= 1
                t1 = 6.5175;
                t2 = 18.6323;
            else
                t1 = 1.8095;
                t2 = 11.7832;
            end
        case 'hp2x2'
            if A == 3
                t1 = 0.4595;
                t2 = 2.9459;
            else
                t1 = 0.4595;
                t2 = 2.9444;
            end
        case 'hp2x4'
            if A == 0.5
                t1 = 11.2876;
                t2 = 20.7948;
            elseif A == 1
                t1 = 11.5109;
                t2 = 21.27;
            elseif A == 5
                t1 = 10.6812;
                t2 = 22.56;
            elseif A == 10
                t1 = 10.4439;
                t2 = 20.64;
            elseif A == 50
                t1 = 11.2956;
                t2 = 22.06;
            elseif A == 100
                t1 = 10.8075;
                t2 = 20.96;
            elseif A == 500
                t1 = 10.3568;
                t2 = 20.1861;
            end
        case 'hp2x5'
            if A == 1
                t1 = 1.3161;
                t2 = t1 + 4.1228;
            elseif A == 3
                t1 = 0.9651;
                t2 = t1 + 5.0877;
            elseif A == 10
                t1 = 1.3162;
                t2 = t1 + 5.0877;
            elseif A == 30
                t1 = 2.0179;
                t2 = t1 + 4.7368;
            elseif A == 100
                t1 = 1.6667;
                t2 = t1 + 4.1228;
            end
        case 'hp2x1'
            t1 = 0.4632;
            if A == 1
                t2 = 3.1787;
            else
                t2 = 3.2632;
            end
        case 'hp2x6'
            t1 = 0.5116;
            t2 = t1 + 1;
        case 'hp2x3'
            if A == 0.1
                t1 = 0.2022;
                t2 = 2.0225;
            elseif A == 0.3
                t1 = 0.2247;
                t2 = 2.0897;
            elseif A == 1
                t1 = 0.2017;
                t2 = 2.1063;
            elseif A == 3
                t1 = 0.2472;
                t2 = 2.0897;
            elseif A == 30
                t1 = 1.2787;
                %t2 = 3.0984;
                t2 = t1 + 2;
            elseif A == 100
                t1 = 0.1167;
                t2 = 0.5410;
            end
        case 'hglua1'
            t1 = 2.2689;
            t2 = 25.3781;
        otherwise
            opt = 'Default Case';
    end
end
%-------------------------------------------------------%