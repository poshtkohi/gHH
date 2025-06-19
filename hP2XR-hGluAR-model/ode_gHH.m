%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
% gHH: Generalised Hodgkin–Huxley Model
function [dxdt] = ode_gHH(t, x, opt)

    if t > opt.t1 && t < opt.t2
        A = opt.A;
        opt.Am = A;
    else
        A = 0;
    end
    
    if opt.fitting_mode == true
        alpha_m1 = opt.params(1);
        beta_m1 = opt.params(2);
        alpha_m2 = opt.params(3);
        beta_m2 = opt.params(4);
        alpha_h1 = opt.params(5);
        beta_h1 = opt.params(6);
        alpha_h2 = opt.params(7);
        beta_h2 = opt.params(8);
    else
        if opt.receptor_name == "hp2x6"
            alpha_m1 = opt.pp_param(1);
            beta_m1 = opt.pp_param(2);
            alpha_m2 = opt.pp_param(3);
            beta_m2 = opt.pp_param(4);
            alpha_h1 = opt.pp_param(5);
            beta_h1 = opt.pp_param(6);
            alpha_h2 = opt.pp_param(7);
            beta_h2 = opt.pp_param(8);
        else
            alpha_m1 = ppval(opt.pp_param{1}, opt.Am);
            beta_m1 = ppval(opt.pp_param{2}, opt.Am);
            alpha_m2 = ppval(opt.pp_param{3}, opt.Am);
            beta_m2 = ppval(opt.pp_param{4}, opt.Am);
            alpha_h1 = ppval(opt.pp_param{5}, opt.Am);
            beta_h1 = ppval(opt.pp_param{6}, opt.Am);
            alpha_h2 = ppval(opt.pp_param{7}, opt.Am);
            beta_h2 = ppval(opt.pp_param{8}, opt.Am);
        end
    end
    
    if opt.sa_mode == true
        alpha_m1 = alpha_m1 + alpha_m1 * opt.SA(1);
        beta_m1 = beta_m1 + beta_m1 * opt.SA(2);
        alpha_m2 = alpha_m2 + alpha_m2 * opt.SA(3);
        beta_m2 = beta_m2 + beta_m2 * opt.SA(4);
        alpha_h1 = alpha_h1 + alpha_h1 * opt.SA(5);
        beta_h1 = beta_h1 + beta_h1 * opt.SA(6);
        alpha_h2 = alpha_h2 + alpha_h2 * opt.SA(7);
        beta_h2 = beta_h2 + beta_h2 * opt.SA(8);
    end
    
    m1 = x(1);
    m2 = x(2);
    h1 = x(3);
    h2 = x(4);
    
    n3 = opt.n3;
    n4 = opt.n4;
    n5 = opt.n5;
    
    if opt.receptor_name == "hglua1"
        ss = 1;
        phi = exp(-A/ss);
    else
        phi = 0;
    end
    
    dm1dt = alpha_m1 * A * (1 - m1) - beta_m1 * (1 + phi) * m1;
    dm2dt = alpha_m2 * m1^n3 * (1 - m2) - beta_m2 * (1 + phi) * m2;
    dh1dt = alpha_h1 * (1 + phi) * (1 - h1) - beta_h1 * h1 * m1^n5;
    dh2dt = alpha_h2 * (1 + phi) * (1 - h2) - beta_h2 * h2 * m2 * m1^n4;
	
    dxdt(1) = dm1dt;
    dxdt(2) = dm2dt;
    dxdt(3) = dh1dt;
    dxdt(4) = dh2dt;
    
    dxdt = dxdt';
end
%-------------------------------------------------------%