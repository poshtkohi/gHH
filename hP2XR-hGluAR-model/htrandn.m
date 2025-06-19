%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function random_values = htrandn(minVal, maxVal, n, m, precision)

    p = rand(n, m);
    random_values = minVal + (maxVal - minVal) .* p;
end
%-------------------------------------------------------%