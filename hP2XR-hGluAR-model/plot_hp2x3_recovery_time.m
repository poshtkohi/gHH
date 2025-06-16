%----- Functions ---------------------------------------%
function plot_hp2x3_recovery_time()
    cleanup_environment();
    % Define ATP concentrations (in μM) and corresponding recovery times (in s)
    %ATP_conc =    [0.1, 0.3, 0.8, 1,   1.5,  2,  3,  5,  10, 30, 50, 80, 100];
    %tau_recover = [10,  28,  64,  180, 88,   60, 55, 54, 27, 25, 18, 14, 13];
    
    ATP_conc =    [0.1, 0.3, 1,   1.5,   10,    30,  100];
    tau_recover = [15,  40,  300, 365,   480,   480, 480];

    % Generate finer ATP concentration values for interpolation
    ATP_fine = logspace(log10(min(ATP_conc)), log10(max(ATP_conc)), 100);

    % Perform interpolation
    pp = pchip(ATP_conc, tau_recover, ATP_fine);

    % Plot results
    figure;
    semilogx(ATP_conc, tau_recover, 'bo', 'MarkerSize', 8, 'LineWidth', 2); % Original data
    hold on;
    semilogx(ATP_fine, pp, 'r-', 'LineWidth', 2); % Interpolated curve in red
    hold off;

    % Labels and title with bold font
    xlabel('\bf ATP Concentration (μM)', 'FontSize', 12);
    ylabel('\bf Recovery Time (s)', 'FontSize', 12);
    %title('\bf Full Recovery Time of hP2X_3 Receptor vs. ATP Concentration', 'FontSize', 14);
    grid on;
    legend({'Original Data', 'Interpolated'}, 'Location', 'Northeast');
end
%-------------------------------------------------------%
