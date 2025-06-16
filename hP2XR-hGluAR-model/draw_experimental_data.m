%----- Functions ---------------------------------------%
function draw_experimental_data(fig, opt, experimental_current, t)
    figure(fig);
    %clf(fig, 'reset');
    hold on
    plot(t, experimental_current, 'r--', 'MarkerIndices', 1:opt.steps:length(t));
    %plot(d(:, 1), d(:, 2), '-ko', 'MarkerIndices', 1:opt.steps:length(d(:, 1)));
    %plot(t, slopes, 'b--*', 'MarkerIndices', 1:opt.steps:length(t));
    %plot(t, integratedData, '-.r*', 'MarkerIndices', 1:opt.steps:length(t));
    mm = min(experimental_current);    
    plot([opt.t1 opt.t2], [mm/2 mm/2], '-k' , 'LineWidth', 2);
    text(opt.t1 + (opt.t2 - opt.t1)/2, mm/2 + 0.05 * mm/2, sprintf('A=%d%s', opt.A, opt.agonist_unit_latex));   
    hold off
    %legend(sprintf('I at A=%d%s', opt.A, opt.agonist_unit_latex), 'Splined', 'Slopes', 'Integrated slopes', 'FontWeight', 'bold');
    legend(sprintf('I at A=%d%s', opt.A, opt.agonist_unit_latex), 'FontWeight', 'bold');
    xlabel(sprintf('t (%s)', opt.time_unit));
    ylabel(sprintf('I (%s)', opt.current_unit));
end
%-------------------------------------------------------%