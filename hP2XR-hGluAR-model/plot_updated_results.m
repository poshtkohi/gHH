%----- Functions ---------------------------------------%
function plot_updated_results(opt, X_fitted)

    global rt_fig
    
    m1 = X_fitted(1, :)';
    m2 = X_fitted(2, :)';
    h1 = X_fitted(3, :)';
    h2 = X_fitted(4, :)';
    h3 = 1;%X_fitted(5, :)';
    current_fitted = total_gHH_current(m1, m2, h1, h2, h3, opt);
    
    experimental_current = opt.x_data;
    
    figure(rt_fig);
    clf(rt_fig, 'reset');
    
    %str = {'m_1', 'm_2', 'h_1', 'h_2', 'h_3', sprintf('I (%s)', opt.current_unit), 'error'};
    str = {'m_1', 'm_2', 'h_1', 'h_2', sprintf('I (%s)', opt.current_unit), 'error'};
    
    if mod(opt.A, 1) == 0
        ATP_str = sprintf('%s=%d%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);  % Treat as integer
    elseif opt.A < 0.1
        ATP_str = sprintf('%s=%1.2f%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);
    else
        ATP_str = sprintf('%s=%1.1f%s', opt.agonist_name, opt.A, opt.agonist_unit_latex);
    end
    %---- m1 ----%
    %{
    subplot(3, 2, 1);
    mm = max(m1);
    hold on
    plot(opt.tint, m1); xlabel('t (s)'); ylabel(str(1));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- m2 ----%
    subplot(3, 2, 2);
    mm = max(m2);
    hold on
    plot(opt.tint, m2); xlabel('t (s)'); ylabel(str(2));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.2 * mm/2, ATP_str); 
    hold off
    %---- h1 ----%
    subplot(3, 2, 3);
    mm = max(h1) + min(h1);
    hold on
    plot(opt.tint, h1); xlabel('t (s)'); ylabel(str(3));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str); 
    hold off
    %---- h2 ----%
    subplot(3, 2, 4);
    mm = max(h2) + min(h2);
    hold on
    plot(opt.tint, h2); xlabel('t (s)'); ylabel(str(4));
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str); 
    hold off
    %---- h3 ----%
    %subplot(3, 2, 5);
    %mm = max(h3) + min(h3);
    %hold on
    %plot(opt.tint, h3); xlabel('t (s)'); ylabel(str(5));
    %plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    %text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 - 0.05 * mm/2, ATP_str); 
    %hold off
    %---- I ----%
    subplot(3, 2, 5);
    %}
    mm = max(current_fitted) + min(current_fitted);
    hold on
    LineWidth = 0.75;
    plot(opt.tint, current_fitted, 'r--', 'MarkerIndices', 1:opt.steps:length(opt.tint), 'LineWidth', LineWidth);
    plot(opt.tint, experimental_current, '-ko', 'MarkerIndices', 1:opt.steps:length(opt.tint), 'LineWidth', LineWidth);
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 + 0.25 * mm/2, ATP_str); 
    xlabel(sprintf('t (%s)', opt.time_unit)); ylabel(str(5));
    legend('Fitted current', 'Experimental current', 'Location', 'southeast');
    hold off
    %---- e ----%
    %subplot(3, 2, 5);
    %hold on
    %error_history = error_history / max(error_history);
    %plot(error_history, 'LineWidth', LineWidth);
    %xlabel('iteration'); ylabel(str(5));
    %hold off;
    drawnow update;
end
%-------------------------------------------------------%