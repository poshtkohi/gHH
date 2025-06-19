%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function perform_simulation_for_fitting(opt, X)

    global simulation_fig
    figure(simulation_fig);
    clf(simulation_fig, 'reset');
    %tspan = [0; 220];
    %tspan = [0; 20];
    %tspan = [0; 250];
    my_opt = opt;   
    my_opt.A = opt.A;

    %{
    my_opt.t1 = 2;
    %my_opt.t2 = 4; tspan = [0; 10];
    %my_opt.t2 = 8; tspan = [0; 30];
    %my_opt.t2 = 12; tspan = [0; 20];
    %my_opt.t2 = 0.1 + 87.5*1e-3; tspan = [0;0.3];
    %my_opt.t2 = 0.1 + 25; tspan = [0;50];
    my_opt.t2 = 2.5; tspan = [0; 10];
    %my_opt.t2 = 139; tspan = [0; 150];
    %my_opt.t2 = 268; tspan = [0; 400];
    %my_opt.t2 = 4; tspan = [0; 120]; lim = 10;
    %my_opt.t2 = 40; tspan = [0; 40 + 200]; %lim = 65;
    %my_opt.t2 = opt.t2; tspan = [0; 20]; %lim = 65;
    %my_opt.t2 = 187; tspan = [0; 250]; %lim = 65;
    %my_opt.t2 = 22; tspan = [0; 30];
    %my_opt.t2 = 22; tspan = [0; 22 + 60 *1];
    %}
    
    %%{
    my_opt.t1 = opt.t1;
    my_opt.t2 = opt.t2;
    tspan = [0 opt.duration];
    %tspan = [0 50];
    %tspan = [0 20];
    %%}
    
    tint = linspace(tspan(1), tspan(2), opt.num_data_points)';
    %tint1 = linspace(0, my_opt.t1, 10)';
    %tint2 = linspace(my_opt.t1, my_opt.t2, 1000)';
    %tint3 = linspace(my_opt.t2, tspan(2), 1000)';
    %tint = [tint1; tint2; tint3];

    
    %%my_opt.odeopt = opt.odeopt;%odeset('RelTol', 1e-7, 'AbsTol', 1e-7);% 'InitialStep', 1e-2, 'MaxStep', 1e-3);
    my_opt.odeopt = odeset;%('RelTol', 1e-8, 'AbsTol', 1e-8, 'InitialStep', 1e-1, 'MaxStep', 1e-2);
    %my_opt.odeopt = odeset('InitialStep', 1e-2, 'MaxStep', 1e-2);
    
    sol = ode15s(@(t, x, opt)(ode_gHH(t, x, my_opt)), tspan, my_opt.x0, my_opt.odeopt, my_opt);
    X = deval(sol, tint);

    m1 = X(1, :)';
    m2 = X(2, :)';
    h1 = X(3, :)';
    h2 = X(4, :)';
    h3 = 1;%X(5, :)';

    simulated_current = total_gHH_current(m1, m2, h1, h2, h3, my_opt);

    %str = {'m_1', 'm_2', 'h_1', 'h_2', 'h_3', sprintf('I (%s)', my_opt.current_unit)};
    str = {'m_1', 'm_2', 'h_1', 'h_2', sprintf('I (%s)', my_opt.current_unit)};

    if mod(opt.A, 1) == 0
        ATP_str = sprintf('%s=%d%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);  % Treat as integer
    elseif opt.A < 0.1
        ATP_str = sprintf('%s=%1.2f%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);
    else
        ATP_str = sprintf('%s=%1.1f%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);
    end
    %---- m1 ----%
    subplot(3, 2, 1);
    mm = max(m1);
    hold on
    plot(tint, m1); xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(1));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- m2 ----%
    subplot(3, 2, 2);
    mm = max(m2);
    hold on
    plot(tint, m2); xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(2));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- h1 ----%
    subplot(3, 2, 3);
    mm = max(h1) + min(h1);
    hold on
    plot(tint, h1); xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(3));
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str);
    hold off
    %---- h2 ----%
    subplot(3, 2, 4);
    mm = max(h2) + min(h2);
    hold on
    ss = 1;
    plot(tint/ss, h2); xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(4));
    %plot(tint/ss, h2); xlabel('t (m)'); ylabel(str(4));
    plot([my_opt.t1/ss my_opt.t2/ss], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1/ss + (my_opt.t2/ss - my_opt.t1/ss)/2, mm/2 - 0.05 * mm/2, ATP_str);
    hold off
    %---- h3 ----%
    %subplot(3, 2, 5);
    %mm = max(h3) + min(h3);
    %hold on
    %plot(tint, h3); xlabel('t (s)'); ylabel(str(5));
    %plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    %text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str);
    %hold off
    %---- I ----%
    subplot(3, 2, 5);
    mm = max(simulated_current) + min(simulated_current);
    hold on
    plot(tint, simulated_current);
    plot([my_opt.t1 my_opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(my_opt.t1 + (my_opt.t2 - my_opt.t1)/2, mm/2 + 0.25 * mm/2, ATP_str);
    xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(5));
    %xlim([0 lim]);
    hold off
    
    drawnow update;
end
%-------------------------------------------------------%