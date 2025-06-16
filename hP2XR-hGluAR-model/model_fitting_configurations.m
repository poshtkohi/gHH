%----- Functions ---------------------------------------%
function [opt] = model_fitting_configurations(receptor_name)

    opt.receptor_name = receptor_name;
    opt.num_of_parameters = 9;
    opt.x0 = [0; 0; 1; 1;]; % Initial conditions
    opt.params = ones(opt.num_of_parameters, 1) * 1; % Initial guess of parameters [alpha_m1; beta_m1; alpha_m_2; beta_m_2; alpha_h; beta_h]
    %opt.params =  htrandn(0, 1, opt.num_of_parameters, 1, 32);
    opt.odeopt = odeset;%('Jacobian', @(t, x, opt)jacobian_gHH(t, x, opt));%, 'RelTol', 1e-12, 'AbsTol', 1e-12, 'InitialStep', 1e-3, 'MaxStep', 1e-2);
    %opt.odeopt = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);%, 'InitialStep', 1e-3, 'MaxStep', 1e-3);
    opt.ScaleProblem = 'none';
    opt.sa_mode = false;

    switch receptor_name
        case 'hp2x7'
            opt.A = 3;%[0.01; 0.1; 1; 3 ; 5; 10]; % mM
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'mM';
            opt.agonist_unit_latex = 'mM';

            if opt.A <= 1
                opt.t1 = 6.5175;
                opt.t2 = 18.6323;
            else
                opt.t1 = 1.8095;%1.3576;
                opt.t2 = 11.7832;
            end
            %opt.odeopt = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);%, 'InitialStep', 1e-3, 'MaxStep', 1e-3);
            opt.time_unit = 's';
            opt.current_unit = 'nA';
            opt.n1 = 4;
            opt.n2 = 2;
            opt.n22 = 1;
            opt.n3 = 2;
            opt.n4 = 1;
            opt.n5 = 1;
            I_max = 10;
            opt.gm = I_max * (2^opt.n1);
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 200;
            opt.steps = 10;
            
            % Local optimisation settions
            opt.tol_local = 1e-9; % 1e-9, 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            opt.ScaleProblem = 'Jacobian';
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 99999;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case 'hp2x2'
            opt.A = 300;%[3; 10 ; 30; 100; 300];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = '\muM';
            if opt.A == 3
                opt.params(1) = 1 / 1;
                opt.t1 = 0.4595; opt.t2 = 2.9459;
                %opt.ub(5:6) = 0;
            elseif opt.A == 10
                opt.params(1) = 1 / 1;
                opt.t1 = 0.4595; opt.t2 = 2.9444;
            elseif opt.A == 30
                opt.params(1) = 1 / 1;
                opt.t1 = 0.4595; opt.t2 = 2.9444;
            elseif opt.A == 100
                opt.params(1) = 1 / 1;
                opt.t1 = 0.4595; opt.t2 = 2.9444;
            elseif opt.A == 300
                opt.params(1) = 1 / 1;
                opt.t1 = 0.4595; opt.t2 = 2.9444;
            end
            opt.time_unit = 's';
            opt.current_unit = '\muA';
            opt.n1 = 1;
            opt.n2 = 3;
            opt.n22 = 1;
            opt.n33 = 3;
            opt.n3 = 1;
            opt.n4 = 1;
            opt.n5 = 3;
            I_max = 4.2533; % Calculated from ATP=300uM
            opt.gm = I_max * 2;
            opt.params(9) = opt.gm;
            opt.gm = 10.67029040;
            opt.sigma = 0.5;
            opt.num_data_points = 200;
            opt.steps = 50;
            opt.odeopt = odeset;%('RelTol', 1e-7, 'AbsTol', 1e-7);%, 'InitialStep', 1e-3, 'MaxStep', 1e-3);
                       
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 99999999;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case 'hp2x4'
            opt.A = 500;%[0.5 ;1 ;5 ;10 ;50 ;100 ; 500];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = '\muM';
            if opt.A == 0.5
                opt.t1 = 11.2876; opt.t2 = 20.7948;
                opt.params(1) = 1 / 100;
            elseif opt.A == 1
                opt.t1 = 11.5109; opt.t2 = 21.27;
                opt.params(1) = 1 / 100;
            elseif opt.A == 5
                opt.t1 = 10.6812; opt.t2 = 22.56;
                opt.params(1) = 1 / 5;
            elseif opt.A == 10
                opt.t1 = 10.4439; opt.t2 = 20.64;
                opt.params(1) = 1 / 100;
            elseif opt.A == 50
                opt.t1 = 11.2956; opt.t2 = 22.06;
                opt.params(1) = 1 / 10;
            elseif opt.A == 100
                opt.t1 = 10.8075; opt.t2 = 20.96;
                opt.params(1) = 1 / 100;
            elseif opt.A == 500
                opt.t1 = 10.3568; opt.t2 = 20.1861;
                opt.params(1) = 1 / 100;
            end
            %my_tol = 1e-6;
            %opt.odeopt = odeset;%('RelTol', my_tol, 'AbsTol', my_tol);%, 'InitialStep', 1e-1, 'MaxStep', 1e-1);
            %opt.use_hybrid = true;

            opt.time_unit = 's';
            opt.current_unit = '\muA';
            
            opt.n1 = 5;
            opt.n2 = 4;
            opt.n22 = 1;
            opt.n3 = 3;
            opt.n4 = 1;
            opt.n5 = 1; 
            I_max = 7.2632; % Calculated from ATP=500uM
            opt.gm = I_max * 2^opt.n1 * 2^opt.n2;
            opt.gm = 217;
            opt.lb = zeros(opt.num_of_parameters, 1);
                
            opt.sigma = 0.5;%0.1;%0.25;%0.25;%0.25;%;0.5;%1e-3;
            opt.num_data_points = 200;
            opt.steps = 10;
            
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 99999;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = false;
        case 'hp2x5'
            opt.A = 30;%[1 ;3 ; 10 ; 30; 100];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = 'µM';
            
            if opt.A == 1
                opt.t1 = 1.3161;
                opt.t2 = opt.t1 + 4.1228;
            elseif opt.A == 3
                opt.t1 = 0.9651;
                %opt.t2 = 5.729;
                %opt.t2 = 4.9134;
                opt.t2 = opt.t1 + 5.0877;
            elseif opt.A == 10
                opt.t1 = 1.3162;
                %opt.t2 = 6.4055;
                opt.t2 = opt.t1 + 5.0877;
            elseif opt.A == 30
                opt.t1 = 2.0179; opt.t2 = opt.t1 + 4.7368;
            elseif opt.A == 100
                opt.t1 = 1.6667;
                opt.t2 = opt.t1 + 4.1228;
            end
            
            opt.time_unit = 's';
            opt.current_unit = 'nA';
            opt.n1 = 3;
            opt.n2 = 3;
            opt.n22 = 3;
            opt.n3 = 2;
            opt.n4 = 2;
            opt.n5 = 2;
            I_max = 2.0321;
            opt.gm = I_max * 2^opt.n1;
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 200;
            opt.steps = 10;
            
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 1;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case 'hp2x1'
            opt.A = 100; % [0.1 ;0.3 ; 1 ; 3; 100];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = '\muM';
            
            opt.t1 = 0.4632;
            if opt.A == 1
                opt.t2 = 3.1787;
            else
                opt.t2 = 3.2632;
            end
            %opt.t2 = opt.t1 + 2.9053;
            
            opt.time_unit = 's';
            opt.current_unit = '\muA';
            opt.n1 = 1;
            opt.n2 = 2;
            opt.n22 = 1;
            opt.n3 = 2;
            opt.n4 = 1;
            opt.n5 = 1;
            I_max = 8.194;
            opt.gm = I_max * 2^opt.n2;
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 1000;
            opt.steps = 50;
            
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.ScaleProblem = 'none';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 9999;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case 'hp2x6'
            opt.A = 30; % [30];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = '\muM';

            opt.t1 = 0.5116;
            opt.t2 = opt.t1 + 1;
            
            opt.time_unit = 's';
            opt.current_unit = 'nA';
            opt.current_unit = '\muA';
            opt.n1 = 5;
            opt.n2 = 2;
            opt.n22 = 2;
            opt.n3 = 1;
            opt.n4 = 1;
            opt.n5 = 1;
            I_max = 1.25;
            opt.gm = I_max * 2^opt.n1;
            opt.params(9) = opt.gm;
            opt.gm = 16.25548881;
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 200;
            opt.steps = 10;
            
            %my_tol = 1e-5;
            %opt.odeopt = odeset;%('RelTol', my_tol, 'AbsTol', my_tol);%, 'InitialStep', 1e-1, 'MaxStep', 1e-1);
            
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.ScaleProblem = 'none';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 1;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case "hp2x3"
            opt.A = 1; % [0.1 ;0.3 ; 1 ; 3; 30; 100];
            opt.agonist_name = 'ATP';
            opt.agonist_unit = 'uM';
            opt.agonist_unit_latex = '\muM';

            if opt.A == 0.1
                opt.t1 = 0.2022;
                opt.t2 = 2.0225;
            elseif opt.A == 0.3
                opt.t1 = 0.2247;
                opt.t2 = 2.0897;
            elseif opt.A == 1
                opt.t1 = 0.2017;
                opt.t2 = 2.1063;
            elseif opt.A == 3
                opt.t1 = 0.2472;
                opt.t2 = 2.0897;
            elseif opt.A == 30
                opt.t1 = 1.2787;
                opt.t2 = 3.2604;
            elseif opt.A == 100
                opt.t1 = 0.1167;
                opt.t2 = 0.5410;
            end
            
            opt.time_unit = 's';
            opt.current_unit = 'nA';
            opt.n1 = 1; %6
            opt.n2 = 4; %1
            opt.n22 = 1; %2
            opt.n33 = 1;
            opt.n3 = 3; %2
            opt.n4 = 1; %1
            opt.n5 = 1; %1
            I_max = 6.1577; % Use the first current form
            opt.gm = I_max * 2^opt.n2;% * 2^opt.n2;
            %opt.params(9) = opt.gm;
            %opt.gm = 100;
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 200;
            opt.steps = 10;
            
            %my_tol = 1e-5;
            opt.odeopt = odeset;%('RelTol', my_tol, 'AbsTol', my_tol);%, 'InitialStep', 1e-1, 'MaxStep', 1e-1);
            
            lb_min = 0.01;
            opt.lb(5) = lb_min;
            opt.lb(7) = lb_min;
                 
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            if opt.A < 1
            else
            end
            %opt.ScaleProblem = 'Jacobian';
            opt.ScaleProblem = 'none';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 999999;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        case 'hglua1'
            opt.A = 0.1; % [0.1; 1 ;10];
            opt.agonist_name = 'Glu';
            opt.agonist_unit = 'mM';
            opt.agonist_unit_latex = 'mM';

            opt.t1 = 2.2689;
            opt.t2 = 25.3781;
            
            if opt.A == 0.1
                opt.params(1) = 10;
            elseif opt.A == 1
                opt.params(1) = 1;
            else
                opt.params(1) = 1 / 10;
            end
            
            opt.time_unit = 'ms';
            opt.current_unit = 'pA';
            opt.n1 = 3;
            opt.n2 = 4;
            opt.n22 = 3;
            opt.n33 = 4;
            opt.n3 = 2;
            opt.n4 = 1;
            opt.n5 = 1;
            I_max = 40.87;
            opt.gm = I_max;
            opt.params(9) = opt.gm;
            opt.gm =  161.49602236;
            opt.sigma = 0.5;
            opt.lb = zeros(opt.num_of_parameters, 1);
            opt.ub = ones(opt.num_of_parameters, 1) * Inf;
            opt.num_data_points = 200;
            opt.steps = 20;            
            
            % Local optimisation settions
            opt.tol_local = 1e-8; % 1e-8
            opt.max_nls_iterations = 128; % 1024, 128
            opt.ScaleProblem = 'Jacobian';
            %opt.ScaleProblem = 'none';
            %opt.mode = "trust-region-reflective";
            %opt.mode = "levenberg-marquardt";
            % Initial optimisation settions to find the initial guess
            opt.max_initial_iterations = 0; % 200, 0
            % Global optmisation settions
            opt.tol_global = 1e-8;
            opt.max_iterations = 1;% 1, 2^32;
            opt.normalised_htrandn = false;
            opt.local_mixed = true;
        otherwise
            opt = 'Unknowm receptor name';
    end
end
%-------------------------------------------------------%