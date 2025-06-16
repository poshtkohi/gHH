%----- Functions ---------------------------------------%
function initial_simulation_for_fitting(fig, opt)
    figure(fig);
    %clf(fig, 'reset');
    
    opt.params = [1000 ; 10; 1000; 10; 1; 10];
    sol = ode15s(@(t, x, opt)(ode_gHH(t, x, opt)), opt.tspan, opt.x0, opt.odeopt, opt);
    [x, x_prime] = deval(sol, opt.tint);
    
    m1 = x(1, :)';
    m2 = x(2, :)';
    h = x(3, :)';
    dm1dt = x_prime(1, :)';
    dm2dt = x_prime(2, :)';
    dhdt = x_prime(3, :)';
    simulated_current = total_gHH_current(m1, m2, h, opt);
    [simulated_current_prime, grad] = total_gHH_current_prime(m1, m2, h, dm1dt, dm2dt, dhdt, opt);
    
    str = {'m_1', 'm_2', 'h', sprintf('I (%s)', opt.current_unit), sprintf('$$\\frac{dI}{dt}$$ (%s/s)', opt.current_unit)};
    subplot(2, 2, 1);
    mm = max(m1);
    hold on
    plot(opt.tint, m1); xlabel('t (s)'); ylabel(str(1));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.2 * mm/2, sprintf('A=%d%s', opt.A, opt.agonist_unit_latex)); 
    hold off
    subplot(2, 2, 2);
    mm = max(m2);
    hold on
    plot(opt.tint, m2); xlabel('t (s)'); ylabel(str(2));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.2 * mm/2, sprintf('A=%d%s', opt.A, opt.agonist_unit_latex)); 
    hold off
    subplot(2, 2, 3);
    mm = max(h) + min(h);
    hold on
    plot(opt.tint, h); xlabel('t (s)'); ylabel(str(3));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.05 * mm/2, sprintf('A=%d%s', opt.A, opt.agonist_unit_latex)); 
    hold off
    subplot(2, 2, 4);
    mm = max(simulated_current) + min(simulated_current);
    hold on
    plot(opt.tint, simulated_current);
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 + 0.25 * mm/2, sprintf('A=%d%s', opt.A, opt.agonist_unit_latex)); 
    xlabel('t (s)'); ylabel(str(4));
    hold off
%{    
    stepFunction = @(x) double(x >= 0);
    ATP = @(t) (stepFunction(t - opt.t1) - stepFunction(t - opt.t2));
    A = ATP(opt.tint) * opt.A;
    
    figure
    plot(opt.tint, A); xlabel('t (s)');
    ATP(0.1)
%}
end
%-------------------------------------------------------%