%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Prepare the Environment -------------------------%
cleanup_environment();
warning('off', 'all');
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
%----- Read data set -----------------------------------%
if opt.A < 1 && opt.A >= 0.1
   d = load(sprintf('data/%s/%s-%1.1f%s.dat', receptor_name, receptor_name, opt.A, opt.agonist_unit));
elseif opt.A < 0.1
    d = load(sprintf('data/%s/%s-%1.2f%s.dat', receptor_name, receptor_name, opt.A, opt.agonist_unit));
else
    d = load(sprintf('data/%s/%s-%d%s.dat', receptor_name, receptor_name, opt.A, opt.agonist_unit));
end
t = d(:, 1);
experimental_current = d(:, 2);
opt.duration = t(length(t));
tint = t;
%----- Smoothing the data sets -------------------------%
if receptor_name == "hp2x4" || receptor_name == "hp2x2"
    %%{
    method = 'pchip';
    pp = interp1(t, experimental_current, method, 'pp');
    tint = linspace(0, t(length(t)), opt.num_data_points)';
    experimental_current = ppval(pp, tint);
else
    mode = 'linearinterp'; % linearinterp, smoothingspline, cubicinterp
    smoother = fit(t, experimental_current, mode);
    tint = linspace(0, t(length(t)), opt.num_data_points)';
    experimental_current = smoother(tint);
    t = d(:, 1);
end

x_data = experimental_current;
opt.x_data = x_data;
%opt.x_data_prime = x_data_prime;
%slopes'
%----- Draw Experimental Data --------------------------%
%%{
fig_experimental = figure('Name', sprintf('%s experimental data for A=%d%s', receptor_name, opt.A, opt.agonist_unit));
fig_experimental.WindowStyle = 'docked';
draw_experimental_data(fig_experimental, opt, x_data, tint);
%return
%%}
%----- Create real-time figure -------------------------%
global rt_fig simulation_fig
rt_fig = figure('Name', 'Real-time fitted curves');
rt_fig.WindowState = 'maximized';
rt_fig.Units = 'normalized';
rt_fig.OuterPosition = [0 0 1 1];
rt_fig.WindowStyle = 'docked';
%rt_fig.Units = 'normalized';
%rt_fig.Position = [0, 0.1, 0.48, 0.8]; % Adjust to place it on the left side

simulation_fig = figure('Name', sprintf('%s simulation for A=%d%s', receptor_name, opt.A, opt.agonist_unit));
simulation_fig.WindowState = 'maximized';
simulation_fig.Units = 'normalized';
simulation_fig.OuterPosition = [0 0 1 1];
simulation_fig.WindowStyle = 'docked';
%simulation_fig.Units = 'normalized';
%simulation_fig.Position = [0.5, 0.1, 0.48, 0.8]; % Adjust to place it on the right side
%----- Setup Initial Conditions & Simulation -----------%
opt.tspan = [0; tint(length(tint))];
opt.tint = tint;
opt.fitting_mode = true;
%fig_initial_simulation = figure('Name', sprintf('%s simulation for A=%d%s', receptor_name, opt.A, opt.agonist_unit));
%fig_initial_simulation.WindowStyle = 'docked';
%initial_simulation_for_fitting(fig_initial_simulation, opt);
%return
%----- Create the optimiser settings -------------------%
tol_initial = 1e-8;
function_tolerance = opt.tol_local;
step_tolerance = opt.tol_local;
function_tolerance_initial = tol_initial;
step_tolerance_initial = tol_initial;
max_function_evaluations = 1e6;
max_initial_iterations = opt.max_initial_iterations;
max_initial_nls_iterations = 128;
max_iterations = opt.max_iterations;%2^32;
max_nls_iterations = opt.max_nls_iterations; % 128
display = 'none'; % iter, none
archive_capacity = 1000;
archive = zeros(archive_capacity, opt.num_of_parameters + 1);
archive_end = 0;
best_error = inf;
global X_current_fitted counter
counter = 0;
%x0 = true_initial_conditions;
%lb = zeros(opt.num_of_parameters, 1); %ones(opt.num_of_parameters, 1);
%ub = ones(opt.num_of_parameters, 1) * inf;
lb = opt.lb;
ub = opt.ub;
initial_params = opt.params;%ones(opt.num_of_parameters, 1) * 10;
best_params = initial_params;
sigma = ones(opt.num_of_parameters, 1) * 0;
%initial_params = [1; 1 ; 1];
precision = 32; % specify precision: 8-, 16-, and 32-bit
num_of_out_of_bound_tries = 1000;
use_archive = true;
use_path = true;
use_crossover = false;
crossover_rate = 0.9;
tournament_size = 5;%max(5, opt.num_of_parameters);%5;

%----- Generate initial guess for parameters -----------%
print_copyright();
% Genarte the initial guess
%%{
iteration_initial = 1;
archive_initial = zeros(max_initial_iterations, opt.num_of_parameters + 1 + length(sigma) * 0);
archive_end_initial = 0;
best_sigma = sigma;
if max_initial_iterations > 1
    disp('Generating initial guesses ...');
    disp(' ');
    for iteration=1:1:max_initial_iterations
        %random_params = htrandn(lb, ub, opt.num_of_parameters, 1, precision);
        %ub_ini = ones(opt.num_of_parameters, 1);
        %ub_ini(5) = ub(5);
        random_params = htrandn(lb, 1, opt.num_of_parameters, 1, precision);
        %random_params = max(random_params, lb);  % Apply lower bounds
        %x = random_increasing_normal_function(random_params, precision);
        %random_params = opt.lb + (opt.ub - opt.lb) .* x;
        mode = 'trust-region-reflective';
        options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', display, 'SpecifyObjectiveGradient', false, 'MaxIterations', max_initial_nls_iterations, 'FunctionTolerance', function_tolerance_initial, 'MaxFunctionEvaluations', max_function_evaluations, 'StepTolerance', step_tolerance_initial);       
        [opt_params, resnorm, residual, exitflag, output] = lsqnonlin(@(params) gHH_fit_customised(params, opt), random_params, lb, ub, options);
        current_error = resnorm;

        %error_history(iteration) = current_error;

        %%plot_updated_results(opt, X_current_fitted);
        %%opt.params = opt_params;
        %%perform_simulation_for_fitting(opt);
        %pause(2);

        if current_error < best_error
            best_params = opt_params;
            best_error = current_error;
            opt.params = best_params;
            plot_updated_results(opt, X_current_fitted);
            perform_simulation_for_fitting(opt);

            %%{
            if use_archive == true
                if archive_end == archive_capacity
                    archive(1, :) = [];
                    %archive(trandi(1, archive_end - 1, 1, 1, precision), :) = [];
                    %archive(randi([1, archive_end - 1]), :) = [];
                    archive_end = archive_end - 1;
                end

                archive_end = archive_end + 1;
                %archive(archive_end, 1:opt.num_of_parameters) = opt_params';
                archive(archive_end, :) = [opt_params' current_error];
            end
            %%}
        end

        fprintf('Iteration %4d: Current Error = %10.10f, Best Error = %10.10f, Optimised Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], Best Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], mode=%s, iterations=%d\n', iteration, current_error, best_error, opt_params(1), opt_params(2), opt_params(3), opt_params(4), opt_params(5), opt_params(6), opt_params(7), opt_params(8), best_params(1), best_params(2), best_params(3), best_params(4), best_params(5), best_params(6), best_params(7), best_params(8), mode, output.iterations);
        iteration_initial = iteration_initial + 1;
    end

    % Choose the best initial guess
    current_norm = inf;
    best_norm = inf;
    %best_error = inf;
else
    %best_params = htrandn(lb, ub, num_of_parameters, 1, 1, precision);
end
%disp(best_sigma);
%disp(best_params');
%return
%%}
%----- Optimising the parameters -------------%
disp(' ');
disp('Running the optimisation ... ');
disp(' ');
disp('Initial guess =');
disp(' ');
disp(best_params');
disp('Initial sigma =');
disp(' ');
disp(sigma');
max_nls_iterations_internal = max_nls_iterations;
sigma_internal = ones(opt.num_of_parameters, 1) .* sigma;
perturbation_scale = sigma_internal;
error_history = [];
if max_initial_iterations < 1
    best_error = inf;
    current_error = inf;
end
previous_error = inf;
previous_params = best_params;
%archive = zeros(archive_capacity, num_of_parameters);
sigma_global = sigma;
%x_best_fitted_prime = x_data_prime;

for iteration=1:1:max_iterations
    % Generate random parameters using custom hardware RNG
    %random_params = trandn(num_of_parameters, 1, precision, hyperbolic_mode_trng, trandn_is_scaled_to_one);

    %%{
    if archive_end > 2 && use_archive == true
        
        n_selections = 3;
        indices = tournament_selection(archive, archive_end, tournament_size, n_selections, precision);
        a1 = archive(indices(1), 1:opt.num_of_parameters)';
        a2 = archive(indices(2), 1:opt.num_of_parameters)';
        a3 = archive(indices(3), 1:opt.num_of_parameters)';
        % Apply differential evolution-like crossover using the archive
        F = 0.8;
        mutant = a1 + F * (a2 - a3);
        mutant = max(min(mutant, ub), lb); % Ensure within bounds
        M = [best_params'; mutant';];
        orthogonal_vector = null(M);  % Q will now contain orthogonal vectors derived from a1, a2, a3
        [m, n] = size(orthogonal_vector);
        orthogonal_params = orthogonal_vector(:, htrandi(1, n, 1, 1, precision));
    else
        orthogonal_params = ones(opt.num_of_parameters, 1);
    end

    for i = 1:num_of_out_of_bound_tries
       % Generate a new set of random parameters
        %random_signs = 2 * trandi(0, 1, num_of_parameters, 3, precision) - 1;
        random_params = htrandn(0, 1, opt.num_of_parameters, 1, precision);
        if use_path == true
            x = random_increasing_normal_function(random_params, precision);
        else
            x = random_params;
        end

        if opt.normalised_htrandn == true
            x = 2 * x - 1;  % [-1 1]
        else
            x = 8 * x - 4; % [-4 4]
        end
       
        perturbation = orthogonal_params .* x;
        % Apply the perturbation to the best parameters
        biased_params =  best_params .* (1 + sigma_internal .* perturbation);

        % Check if the new parameters are within bounds
        if all(biased_params >= lb) && all(biased_params <= ub)
            % Parameters are valid, exit the loop
            break;
        else
            % If bounds violated, adjust out-of-bound parameters
            %biased_params = max(min(biased_params, ub), lb);
            continue;
        end
    end

    if use_crossover == true
        r = htrandn(0, 1, opt.num_of_parameters, 1, precision);
        for j = 1:opt.num_of_parameters
            if r(j) > crossover_rate
                biased_params(j) = best_params(j); % Keep original parameter                
            end
        end
    end

    % Logical index for values that are out of bounds
    out_of_bounds = (biased_params < lb) | (biased_params > ub);
    % Replace out-of-bounds elements with best_params
    %biased_params(out_of_bounds) = best_params(out_of_bounds) * (1 + trand(precision) * 0.01);
    % Check if any elements are out of bounds
    if any(out_of_bounds)
        % Display the out-of-bounds elements
        %disp(out_of_bounds);
        % Replace out-of-bounds elements with modified best_params values
        biased_params(out_of_bounds) = best_params(out_of_bounds) .* (1 + htrand(precision) * 0.01);
    end

    if opt.local_mixed == true
        try
            mode = 'levenberg-marquardt';
            ScaleProblem = opt.ScaleProblem;
            %ScaleProblem = 'none';
            options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', 'ScaleProblem', ScaleProblem, 'Display', display, 'SpecifyObjectiveGradient', false, 'MaxIterations', max_nls_iterations_internal, 'FunctionTolerance', function_tolerance, 'MaxFunctionEvaluations', max_function_evaluations, 'StepTolerance', step_tolerance);       
            [opt_params, resnorm, residual, exitflag, output] = lsqnonlin(@(params) gHH_fit_customised(params, opt), biased_params, [], [], options);
            %opt_params'
            if any(opt_params < lb) || any(opt_params > ub)
                mode = 'trust-region-reflective-tried-out-of-bound';
                options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', display, 'SpecifyObjectiveGradient', false, 'MaxIterations', max_nls_iterations_internal, 'FunctionTolerance', function_tolerance, 'MaxFunctionEvaluations', max_function_evaluations, 'StepTolerance', step_tolerance);       
                [opt_params, resnorm, residual, exitflag, output] = lsqnonlin(@(params) gHH_fit_customised(params, opt), biased_params, lb, ub, options);
            end
        catch ME
            mode = 'trust-region-reflective-tried-exception';
            options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', display, 'SpecifyObjectiveGradient', false, 'MaxIterations', max_nls_iterations_internal, 'FunctionTolerance', function_tolerance, 'MaxFunctionEvaluations', max_function_evaluations, 'StepTolerance', step_tolerance);       
            [opt_params, resnorm, residual, exitflag, output] = lsqnonlin(@(params) gHH_fit_customised(params, opt), biased_params, lb, ub, options);
        end
    else
        mode = 'trust-region-reflective';

        options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective', 'Display', display, 'SpecifyObjectiveGradient', false, 'MaxIterations', max_nls_iterations_internal, 'FunctionTolerance', function_tolerance, 'MaxFunctionEvaluations', max_function_evaluations, 'StepTolerance', step_tolerance);       
        [opt_params, resnorm, residual, exitflag, output] = lsqnonlin(@(params) gHH_fit_customised(params, opt), biased_params, lb, ub, options);
    end

    try
    catch ME
        fprintf('Error during optimisation: %s\n', ME.message);
        continue;  % Skip to the next iteration if there's an error
    end

    current_error = resnorm;

    %error_history(iteration) = current_error;

    max_iterations = max_iterations + 1;
    % Update the best parameters if the current error is lower
    if current_error < best_error
        best_params = opt_params;
        best_error = current_error;

        opt.params = best_params;
        plot_updated_results(opt, X_current_fitted);
        perform_simulation_for_fitting(opt, X_current_fitted);
    end
     % Check if the error is below the threshold for termination
    error_threshold = opt.tol_global;
    if best_error < error_threshold
        fprintf('Optimisation converged in %d iterations.\n', max_iterations);
        break;
    end
    
    if use_archive == true
        % Determine if new solution should be stored in the archive
        if isempty(archive) || current_error < max(archive(:, end)) || is_significantly_different(archive, opt_params)
            % Add new solution to archive if space is available or replace the worst if the archive is full
            if archive_end < archive_capacity
                archive_end = archive_end + 1;
                archive(archive_end, :) = [opt_params' current_error];
                %archive(archive_end, :)
            else
                [~, idx] = max(archive(:, end));
                archive(idx, :) = [opt_params' current_error];
            end

            % Optionally prune or reorder the archive based on error or diversity
            [archive, archive_end] = prune_or_reorder_archive(archive, archive_capacity, archive_end);
            %archive(archive_end, :)
        end
    end
    
    step = ones(opt.num_of_parameters, 1) .* opt.sigma;
    if use_path == true
        sigma_internal = random_increasing_normal_function(step, precision);
    else
        sigma_internal = step;
    end

    % Print the current status
    %fprintf('Iteration %4d: Current Error = %10.10f, Best Error = %10.10f, Biased Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], Optimised Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], Best Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], mode=%s, iterations=%d\n', iteration, current_error, best_error, biased_params(1), biased_params(2), biased_params(3), biased_params(4), biased_params(5), biased_params(6), biased_params(7), biased_params(8), opt_params(1), opt_params(2), opt_params(3), opt_params(4), opt_params(5), opt_params(6), opt_params(7), opt_params(8), best_params(1), best_params(2), best_params(3), best_params(4), best_params(5), best_params(6), best_params(7), best_params(8), mode, output.iterations);
    fprintf('Iteration %4d: Current Error = %10.10f, Best Error = %10.10f, Biased Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], Optimised Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], Best Params = [%.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f %.8f], mode=%s, iterations=%d\n', iteration, current_error, best_error, biased_params(1), biased_params(2), biased_params(3), biased_params(4), biased_params(5), biased_params(6), biased_params(7), biased_params(8), biased_params(9), opt_params(1), opt_params(2), opt_params(3), opt_params(4), opt_params(5), opt_params(6), opt_params(7), opt_params(8), opt_params(9), best_params(1), best_params(2), best_params(3), best_params(4), best_params(5), best_params(6), best_params(7), best_params(8), best_params(9), mode, output.iterations);

    %fprintf('Iteration %4d: Current Error = %10.4f, Best Error = %10.4f, Biased Params = [%.8f %.8f %.8f], Optimised Params = [%.8f %.8f %.8f], Best Params = [%.8f %.8f %.8f], internal_sigma=(%.8f,%.8f,%.8f), sigma=(%.4f,%.4f,%.4f), acceleration=(%.4f,%.4f,%.4f), speed=(%.4f,%.4f,%.4f), d_xyz=%.4f, mode=%s, iterations=%d, archive_end=%d, i=%d\n', iteration, current_error, best_error, biased_params(1), biased_params(2), biased_params(3), opt_params(1), opt_params(2), opt_params(3), best_params(1), best_params(2), best_params(3), sigma_internal(1), sigma_internal(2), sigma_internal(3), sigma(1), sigma(2), sigma(3), acceleration(1), acceleration(2), acceleration(3), speed(1), speed(2), speed(3), d_xyz, mode, output.iterations, archive_end, i);
    previous_error = current_error;
    previous_params = opt_params;

    %disp('hello');
    %pause
end

% Output the best parameters found
fprintf('Best Parameters Found:\n');
disp(best_params');
fprintf('Best Error Achieved: %f\n', best_error);

if iteration == max_iterations
    fprintf('Max iterations reached without convergence.\n');
end

%----- Functions ---------------------------------------%
function [residuals, gradients] = gHH_fit_customised(params, opt)

    global X_current_fitted
    
    opt.params = params;
    
    try
        sol = ode15s(@(t, x, opt)(ode_gHH(t, x, opt)), opt.tspan, opt.x0, opt.odeopt, opt);
    catch
        sol = ode23s(@(t, x, opt)(ode_gHH(t, x, opt)), opt.tspan, opt.x0, opt.odeopt, opt);
    end
    %%}
    X = deval(sol, opt.tint);
    m1 = X(1, :)';
    m2 = X(2, :)';
    h1 = X(3, :)';
    h2 = X(4, :)';
    h3 = 1;%X(5, :)';
    simulated_current = total_gHH_current(m1, m2, h1, h2, h3, opt);
        
    x_fitted = simulated_current;
    x_data = opt.x_data;
    X_current_fitted = X;

    residuals = x_fitted - x_data;
    gradients = [];
end
%-------------------------------------------------------%
function print_copyright()
    disp(' ');
    disp('    eXtrerme Scale Parameter Estimation Framework for Non-linear Systems - XSPEF v1.0.1');
    fprintf('    Copyright (c) 2023-%d by Alireza Poshtkohi,\n', year(datetime('now')));
    disp('    ALL RIGHTS RESERVED');
    disp(' ');
end
%-------------------------------------------------------%
function is_diff = is_significantly_different(archive, params, threshold)
    % Handle default value for threshold if not provided
    if nargin < 3
        threshold = 0.1;
    end
    % Calculate distances or difference measure from the archive
    diffs = sum(abs(archive(:, 1:end-1) - params'), 2);
    % Check if new parameters are significantly different
    is_diff = all(diffs > threshold);
end
%-------------------------------------------------------%
function [archive, archive_end] = prune_or_reorder_archive(archive, archive_capacity, archive_end)
    % Prune or reorder the archive based on existing valid entries up to 'archive_end'.
    
    % Check if the current number of valid entries is more than zero and does not exceed the capacity.
    if archive_end > 0
        % Extract only the valid portion of the archive
        valid_archive = archive(1:archive_end, :);
        
        % Sort the valid entries by the error value in the last column in ascending order
        [~, idx] = sort(valid_archive(:, end), 'ascend');
        
        % Update the archive with sorted valid entries
        archive(1:archive_end, :) = valid_archive(idx, :);
        
        % If the valid entries exceed the capacity, prune them
        if archive_end > archive_capacity
            % Reduce 'archive_end' to 'archive_capacity' and prune the excess
            archive_end = archive_capacity;
            archive = archive(1:archive_capacity, :); % Keep only the top entries within the capacity
        end
    end
    % If 'archive_end' is zero, no action is needed as the archive is empty or invalid.
end
%-------------------------------------------------------%
function selected_indices = tournament_selection(archive, archive_end, tournament_size, n_selections, precision)
    % Initialize the array to store the indices of selected solutions
    selected_indices = zeros(n_selections, 1);
    
    % Keep track of chosen indices to avoid repetition
    chosen_set = false(archive_end, 1);
    
    % Counter for how many selections have been made
    selection_count = 0;
    
    % Keep running tournaments until the required number of selections is made
    while selection_count < n_selections
        % Ensure tournament size does not exceed the number of available, unchosen solutions
        available_indices = find(~chosen_set);
        effective_tournament_size = min(tournament_size, numel(available_indices));
        
        if effective_tournament_size == 0
            warning('Not enough unique entries to fulfill the request for multiple selections.');
            break;
        end
        
        % Select random indices from the unchosen set
        rand_indices = available_indices(custom_randperm1(numel(available_indices), effective_tournament_size, precision));
        
        % Retrieve the error or fitness values for the tournament participants
        tournament_errors = archive(rand_indices, end);
        
        % Find the index of the best solution in this tournament
        [~, best_idx] = min(tournament_errors);
        best_tournament_index = rand_indices(best_idx);
        
        % Add the best index to the selected indices if not already chosen
        if ~chosen_set(best_tournament_index)
            selection_count = selection_count + 1;
            selected_indices(selection_count) = best_tournament_index;
            chosen_set(best_tournament_index) = true;  % Mark as chosen
        end
    end
    
    % Trim output to the actual number of selections made
    selected_indices = selected_indices(1:selection_count);
end
%-------------------------------------------------------%
function perm = custom_randperm1(n, k, precision)
    % CUSTOM_RANDPERM Generates a random permutation of k unique integers from 1 to n
    % using a customized hardware random number generator (HRNG).
    
    % Error handling if k is greater than n
    if k > n
        error('k must be less than or equal to n.');
    end

    % Initialize the array of integers from 1 to n
    perm = 1:n;

    % Only perform the shuffle up to the k-th element
    for i = 1:k
        % Generate a random index from i to n using hrandi
        j = htrandi(i, n, 1, 1, precision);

        % Swap the elements at indices i and j
        temp = perm(i);
        perm(i) = perm(j);
        perm(j) = temp;
    end

    % Return only the first k elements
    perm = perm(1:k);
end
%-------------------------------------------------------%