%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function y = random_decreasing_normal_function(x, precision)
    
    n = length(x);
    y = zeros(n, 1);
    
    which_path = htrandi(1, 60, n, 1, precision);

    for i=1:1:n
        if which_path(i) == 1
            y(i) = 1 - x(i)^2;
        elseif which_path(i) == 2
            y(i) = (1 - x(i))^2;
        elseif which_path(i) == 3
            y(i) = 1 - x(i)^3;
        elseif which_path(i) == 4
            y(i) = (1 - x(i))^3;
        elseif which_path(i) == 5
            y(i) = 1 - x(i)^4;
        elseif which_path(i) == 6
            y(i) = (1 - x(i))^4;
        elseif which_path(i) == 7
            y(i) = 1 - x(i)^5;
        elseif which_path(i) == 8
            y(i) = (1 - x(i))^5;
        elseif which_path(i) == 9
            y(i) = (1 - x(i))^6;
        elseif which_path(i) == 10
            y(i) = 1 - x(i)^6;
        elseif which_path(i) == 11
            y(i) = 1 - sqrt(x(i));
        elseif which_path(i) == 12
            y(i) = (1 - sqrt(x(i)))^2;
        elseif which_path(i) == 13
            y(i) = (1 - sqrt(x(i)))^3;
        elseif which_path(i) == 14
            a = log(2);
            y(i) = (a - log(1 + x(i))) / a;
        elseif which_path(i) == 15
            a = log(2);
            y(i) = (a - log(1 + x(i)^2)) / a;
        elseif which_path(i) == 16
            a = log(2);
            y(i) = (a - log(1 + x(i)^3)) / a;
        elseif which_path(i) == 17
            a = log(2);
            y(i) = ((a - log(1 + x(i))) / a)^2;
        elseif which_path(i) == 18
            a = log(2);
            y(i) = (a - log(sqrt(1 + 3 * x(i)))) / a;
        elseif which_path(i) == 19
            a = log(2);
            y(i) = (a - log(sqrt(1 + 3 * x(i)^2))) / a;
        elseif which_path(i) == 20
            a = log(2);
            y(i) = 2 * log(sqrt(2 - x(i))) / a;
        elseif which_path(i) == 21
            a = log(2);
            y(i) = 2 * log(sqrt(2 - x(i)^2)) / a;
        elseif which_path(i) == 22
            a = log(2);
            y(i) = 2 * log(sqrt(2 - x(i)^3)) / a;
        elseif which_path(i) == 23
            a = sinh(1);
            y(i) = ((a - sinh(x(i))) / a);
        elseif which_path(i) == 24
            a = sinh(1);
            y(i) = ((a - sinh(x(i)^2)) / a);
        elseif which_path(i) == 25
            a = sinh(1);
            y(i) = ((a - sinh(x(i)^3)) / a);
        elseif which_path(i) == 26
            a = sinh(1);
            y(i) = ((a - sinh(sqrt(x(i)))) / a);
        elseif which_path(i) == 27
            a = sinh(1);
            y(i) = sinh(sqrt(1 - x(i))) / a;
        elseif which_path(i) == 28
            a = tanh(1);
            y(i) = (a - tanh(x(i))) / a;
        elseif which_path(i) == 29
            a = tanh(1);
            y(i) = (a - tanh(x(i)^2)) / a;
        elseif which_path(i) == 30
            a = tanh(1);
            y(i) = (a - tanh(sqrt(x(i)))) / a;
        elseif which_path(i) == 31
            a = tanh(1);
            y(i) = tanh(sqrt(1 - x(i))) / a;
        elseif which_path(i) == 32
            a = tanh(1);
            y(i) = tanh(sqrt(1 - x(i)^2)) / a;
        elseif which_path(i) == 33
            a = acos(0);
            y(i) = acos(x(i)) / a;
        elseif which_path(i) == 34
            a = acos(0)^2;
            y(i) = acos(x(i))^2 / a;
        elseif which_path(i) == 35
            a = acos(0);
            y(i) = acos(x(i)^2) / a;
        elseif which_path(i) == 36
            a = acos(0);
            y(i) = acos(x(i)^3) / a;
        elseif which_path(i) == 37
            a = acos(0);
            y(i) = acos(sqrt(x(i))) / a;
        elseif which_path(i) == 38
            y(i) = sqrt(1 - x(i)^2);
        elseif which_path(i) == 39
            y(i) = sqrt(1 - x(i)^2) / (1 + x(i));
        elseif which_path(i) == 40
            y(i) = (1 - x(i)^2) / (1 + x(i)^2);
        elseif which_path(i) == 41
            y(i) = (1 - x(i)^3) / (1 + x(i)^3);
        elseif which_path(i) == 42
            y(i) = (1 - x(i)) / (1 + x(i));
        elseif which_path(i) == 43
            y(i) = cos(pi / 2 * x(i));
        elseif which_path(i) == 44
            y(i) = cos(pi / 2 * x(i))^2;
        elseif which_path(i) == 45
            y(i) = cos(pi / 2 * x(i)^2);
        elseif which_path(i) == 46
            y(i) = cos(pi / 2 * x(i)^3);
        elseif which_path(i) == 47
            y(i) = cos(pi / 2 * sqrt(x(i)));
        elseif which_path(i) == 48
            y(i) = cos(pi / 2 * x(i)) / (1 + sin(pi / 2 * x(i)));
        elseif which_path(i) == 49
            y(i) = (1 - x(i)) * cosh(x(i));
        elseif which_path(i) == 50
            y(i) = (1 - x(i)) * cosh(x(i)) / (1 + sinh(x(i)));
        elseif which_path(i) == 51
            y(i) = (1 - x(i)) * cos(x(i));
        elseif which_path(i) == 52
            y(i) = (1 - x(i)) * exp(x(i));
        elseif which_path(i) == 53
            y(i) = (1 - x(i)) * acos(x(i)) / acos(0);
        elseif which_path(i) == 54
            x(i) = sin(pi / 2 * x(i));
            y(i) = (1 - x(i)) / (1 + x(i));
        elseif which_path(i) == 55
            x(i) = sin(pi / 2 * x(i));
            y(i) = (1 - x(i)) / (1 + x(i));
        elseif which_path(i) == 56
            x(i) = tanh(x(i));
            a = tanh(1);
            b = tanh(0);
            a = (1 - a) / (1 + a);
            b = (1 - b) / (1 + b);
            y(i) = ( ((1 - x(i)) / (1 + x(i))) - a ) / (b - a);
        elseif which_path(i) == 57
            x(i) = sinh(x(i));
            a = sinh(1);
            b = sinh(0);
            a = (1 - a) / (1 + a);
            b = (1 - b) / (1 + b);
            y(i) = ( ((1 - x(i)) / (1 + x(i))) - a ) / (b - a);
        elseif which_path(i) == 58
            x(i) = sinh(exp(1) / pi * x(i));
            y(i) = (1 - x(i)) / (1 + x(i));
        elseif which_path(i) == 59
            a = 1 / (1 - exp(1));
            y(i) = ((x(i) / (x(i) - exp(x(i)))) - a) / -a;
        else
            y(i) = 1 - x(i);
        end
    end
end
%-------------------------------------------------------%