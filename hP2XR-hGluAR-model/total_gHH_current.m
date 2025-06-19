%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function i_m = total_gHH_current(m1, m2, h1, h2, h3, opt)
    n1 = opt.n1;
    n2 = opt.n2;
    n22 = opt.n22;
    gm = opt.gm;
    %gm = opt.params(9);
    if opt.receptor_name == "hp2x1"
        i_m =  - gm * (m1.^n1 .* m2.^n22) .* ((h1 + h2)/2).^n2;
    elseif opt.receptor_name == "hp2x4"
        i_m = - gm * ((m1 + m2)/2).^n1 .* ((h1 + h2)/2).^n2;
    elseif opt.receptor_name == "hp2x2"
        n33 = opt.n33;
        i_m =  - gm * ((m1.^n1 .* h1.^n2 + m2.^n22 .* h2.^n33)/2);
    elseif opt.receptor_name == "hglua1"
        n33 = opt.n33;
        i_m =  - gm * m1.^n1 .* m2.^n2 .* h1.^n22 .* h2.^n33;
    elseif opt.receptor_name == "hp2x3"
        i_m =  - gm * (m1.^n1 .* m2.^n22) .* ((h1 + h2)/2).^n2;
    elseif opt.receptor_name == "hp2x6"
        i_m = - gm * ((m1 + m2)/2).^n1 .* h1.^n2 .* h2.^n22;
    else
        i_m =  - gm * ((m1 + m2)/2).^n1 .* h1.^n2 .* h2.^n22;
    end
end
%-------------------------------------------------------%