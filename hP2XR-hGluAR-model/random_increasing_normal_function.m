%--------------------------------------------------------------------------
%   Copyright (c) 2024–2025 Alireza Poshtkohi. All rights reserved.
%   Email: a.poshtkohi@herts.ac.uk
%   Website: https://www.interdisciplinary.team
%
%   This file is part of the gHH model and is distributed under the
%   GNU General Public License v3.0 (see LICENSE for details).
%--------------------------------------------------------------------------

%----- Functions ---------------------------------------%
function y = random_increasing_normal_function(x, precision)
     
    n = length(x);
    y = zeros(n, 1);
    
    which_path = htrandi(1, 92, n, 1, precision);

    for i=1:1:n
        if which_path(i) == 1
            x(i) = tanh(x(i));
            tanh1 = tanh(1);
            denominator = tanh1 + tanh1^2 + tanh1^3 + tanh1^4;
            y(i) = (x(i) + x(i)^2 + x(i)^3 + x(i)^4) / denominator;
        elseif which_path(i) == 2
            y(i) = (x(i) + x(i)^2 + x(i)^3 + x(i)^4) / 4;
        elseif which_path(i) == 3
            y(i) = 2 * x(i) / (1 + x(i));
        elseif which_path(i) == 4
            tanh1 = tanh(1);
            x(i) = tanh(x(i));
            y(i) = ((1 + tanh1)/tanh1) * x(i) / (1 + x(i));
        elseif which_path(i) == 5
            ln2 = log(2);
            x(i) = log(1 + x(i));
            y(i) = ((1 + ln2)/ln2) * x(i) / (1 + x(i));
        elseif which_path(i) == 6
            ln2 = log(2);
            x(i) = log(1 + x(i));
            denominator = ln2 + ln2^2 + ln2^3 + ln2^4;
            y(i) = (x(i) + x(i)^2 + x(i)^3 + x(i)^4) / denominator;
        elseif which_path(i) == 7
            sinh1 = sinh(1);
            x(i) = sinh(x(i));
            denominator = sinh1 + sinh1^2 + sinh1^3 + sinh1^4;
            y(i) = (x(i) + x(i)^2 + x(i)^3 + x(i)^4) / denominator;
        elseif which_path(i) == 8
            sinh1 = sinh(1);
            x(i) = sinh(x(i));
            y(i) = ((1 + sinh1)/sinh1) * x(i) / (1 + x(i));
        elseif which_path(i) == 9
            sinh1 = sinh(1);
            x(i) = sinh(x(i));
            y(i) = x(i) / sinh1;
        elseif which_path(i) == 10
            ln2 = log(2);
            x(i) = log(1 + x(i));
            y(i) = x(i) / ln2;
        elseif which_path(i) == 11
            tanh1 = tanh(1);
            x(i) = tanh(x(i));
            y(i) = x(i) / tanh1;
        elseif which_path(i) == 12
            y(i) = (x(i) + x(i)^2 + x(i)^3) / 3;
        elseif which_path(i) == 13
            y(i) = (x(i) + x(i)^2) / 2;
        elseif which_path(i) == 14
            x(i) = tanh(x(i));
            tanh1 = tanh(1);
            denominator = tanh1 + tanh1^2;
            y(i) = (x(i) + x(i)^2) / denominator;
        elseif which_path(i) == 15
            x(i) = tanh(x(i));
            tanh1 = tanh(1);
            denominator = tanh1 + tanh1^2 + tanh1^3;
            y(i) = (x(i) + x(i)^2 + x(i)^3) / denominator;
        elseif which_path(i) == 16
            ln2 = log(2);
            x(i) = log(1 + x(i));
            denominator = ln2 + ln2^2;
            y(i) = (x(i) + x(i)^2) / denominator;
        elseif which_path(i) == 17
            ln2 = log(2);
            x(i) = log(1 + x(i));
            denominator = ln2 + ln2^2 + ln2^3;
            y(i) = (x(i) + x(i)^2 + x(i)^3) / denominator;
        elseif which_path(i) == 18
            sinh1 = sinh(1);
            x(i) = sinh(x(i));
            denominator = sinh1 + sinh1^2;
            y(i) = (x(i) + x(i)^2) / denominator;
        elseif which_path(i) == 19
            sinh1 = sinh(1);
            x(i) = sinh(x(i));
            denominator = sinh1 + sinh1^2 + sinh1^3;
            y(i) = (x(i) + x(i)^2 + x(i)^3) / denominator;
        elseif which_path(i) == 20
            a = sinh(1);
            y(i) = (a - sinh(sqrt(1 - x(i)))) / a;
        elseif which_path(i) == 21
            a = sinh(1);
            y(i) = (a - sinh(sqrt(1 - x(i)^2))) / a;
        elseif which_path(i) == 22
            a = tanh(1);
            y(i) = (a - tanh(sqrt(1 - x(i)))) / a;
        elseif which_path(i) == 23
            a = tanh(1);
            y(i) = (a - tanh(sqrt(1 - x(i)^2))) / a;
        elseif which_path(i) == 24
            a = log(2);
            y(i) = 1 - 2 * log(sqrt(2 - x(i))) / a;
        elseif which_path(i) == 25
            a = log(2);
            y(i) = 1 - 2 * log(sqrt(2 - x(i)^2)) / a;
        elseif which_path(i) == 26
            a = exp(1);
            y(i) = (exp(x(i)) - 1) / (a - 1);
        elseif which_path(i) == 27
            a = exp(1);
            y(i) = (exp(sqrt(x(i))) - 1) / (a - 1);
        elseif which_path(i) == 28
            a = exp(1);
            y(i) = (exp(x(i)^2) - 1) / (a - 1);
        elseif which_path(i) == 29
            a = exp(1) - 1;
            y(i) = a * x(i) / (exp(x(i)) - x(i));
        elseif which_path(i) == 30
            a = exp(1) - 1;
            y(i) = a * x(i)^2 / (exp(x(i)^2) - x(i)^2);
        elseif which_path(i) == 31
            a = exp(1) - 1;
            y(i) = a * sqrt(x(i)) / (exp(sqrt(x(i))) - sqrt(x(i)));
        elseif which_path(i) == 32
            y(i) = sqrt(x(i));
        elseif which_path(i) == 33
            y(i) = 2 * sqrt(x(i)) / (sqrt(x(i)) + 1);
        elseif which_path(i) == 34
            y(i) = sqrt(sinh(x(i)) / sinh(1));
        elseif which_path(i) == 35
            y(i) = sqrt(tanh(x(i)) / tanh(1));
        elseif which_path(i) == 36
            a = log(1 + sqrt(2));
            y(i) = log(x(i) + sqrt(1 + x(i)^2)) / a;
        elseif which_path(i) == 37
            x(i) = sqrt(x(i));
            y(i) = 2 * x(i) / (1 + x(i));
        elseif which_path(i) == 38
            y(i) = (x(i) - 1 + sqrt(1 + x(i)^2)) / sqrt(2);
        elseif which_path(i) == 39
            y(i) = asin(x(i)) / asin(1);
        elseif which_path(i) == 40
            y(i) = asin(x(i))^2 / asin(1)^2;
        elseif which_path(i) == 41
            y(i) = asin(x(i)^2) / asin(1);
        elseif which_path(i) == 42
            y(i) = asin(x(i)^3) / asin(1);
        elseif which_path(i) == 43
            y(i) = asin(sqrt(x(i))) / asin(1);
        elseif which_path(i) == 44
            y(i) = atan(x(i)) / atan(1);
        elseif which_path(i) == 45
            y(i) = atan(x(i))^2 / atan(1)^2;
        elseif which_path(i) == 46
            y(i) = atan(x(i)^2) / atan(1);
        elseif which_path(i) == 47
            y(i) = atan(x(i)^3) / atan(1);
        elseif which_path(i) == 48
            y(i) = atan(sqrt(x(i))) / atan(1);
        elseif which_path(i) == 49
            a = 1 + sqrt(2);
            y(i) = a * x(i) / (x(i) + sqrt(1 + x(i)^2));
        elseif which_path(i) == 50
            y(i) = x(i) / (1 + sqrt(1 - x(i)^2));
        elseif which_path(i) == 51
            a = 1 + sqrt(2);
            y(i) = a * x(i) / (1 + sqrt(1 + x(i)^2));
        elseif which_path(i) == 52
            a = sqrt(2);
            y(i) = a * x(i) / (1 + sqrt(x(i)^2));
        elseif which_path(i) == 53
            y(i) = 2 * x(i) / (1 + x(i)^2);
        elseif which_path(i) == 54
            y(i) = 2 * x(i)^2 / (1 + x(i)^2);
        elseif which_path(i) == 55
            y(i) = sin(x(i)) / sin(1);
        elseif which_path(i) == 56
            y(i) = sin(x(i))^2 / sin(1)^2;
        elseif which_path(i) == 57
            y(i) = sin(x(i)^2) / sin(1);
        elseif which_path(i) == 58
            y(i) = sin(x(i)^3) / sin(1);
        elseif which_path(i) == 59
            y(i) = sin(sqrt(x(i))) / sin(1);
        elseif which_path(i) == 60
            y(i) = tan(x(i)) / tan(1);
        elseif which_path(i) == 61
            y(i) = tan(x(i))^2 / tan(1)^2;
        elseif which_path(i) == 62
            y(i) = tan(x(i)^2) / tan(1);
        elseif which_path(i) == 63
            y(i) = tan(x(i)^3) / tan(1);
        elseif which_path(i) == 64
            y(i) = tan(sqrt(x(i))) / tan(1);
        elseif which_path == 65
            a = sec(1) - 1;
            y(i) = (sec(x(i)) - 1) / a;
        elseif which_path(i) == 66
            a = sec(1)^2 - 1;
            y(i) = (sec(x(i))^2 - 1) / a;
        elseif which_path(i) == 67
            a = sec(1) - 1;
            y(i) = (sec(x(i)^2) - 1) / a;
        elseif which_path(i) == 68
            a = sec(1) - 1;
            y(i) = (sec(x(i)^3) - 1) / a;
        elseif which_path(i) == 69
            a = sec(1) - 1;
            y(i) = (sec(sqrt(x(i))) - 1) / a;
        elseif which_path(i) == 70
            a = (1 + cos(1)) / sin(1);
            y(i) = a * sin(x(i)) / (1 + cos(x(i)));
        elseif which_path(i) == 71
            a = (1 + cosh(1)) / sinh(1);
            y(i) = a * sinh(x(i)) / (1 + cosh(x(i)));
        elseif which_path(i) == 72
            a = (1 + cos(1)) / sinh(1);
            y(i) = a * sinh(x(i)) / (1 + cos(x(i)));
        elseif which_path(i) == 73
            a = cosh(1) - 1;
            y(i) = (cosh(x(i)) - 1) / a;
        elseif which_path(i) == 74
            a = cosh(1)^2 - 1;
            y(i) = (cosh(x(i)^2) - 1) / a;
        elseif which_path(i) == 75
            a = cosh(1) - 1;
            y(i) = (cosh(x(i)^2) - 1) / a;
        elseif which_path(i) == 76
            a = cosh(1) - 1;
            y(i) = (cosh(x(i)^3) - 1) / a;
        elseif which_path(i) == 77
            a = cosh(1) - 1;
            y(i) = (cosh(sqrt(x(i))) - 1) / a;
        elseif which_path(i) == 78
            a = 1 + sin(1);
            y(i) = log(1 + sin(x(i))) / a;
        elseif which_path(i) == 79
            a = 1 + sinh(1);
            y(i) = log(1 + sinh(x(i))) / a;
        elseif which_path(i) == 80
            a = 1 + tan(1);
            y(i) = log(1 + tan(x(i))) / a;
        elseif which_path(i) == 81
            a = 1 + tanh(1);
            y(i) = log(1 + tanh(x(i))) / a;
        elseif which_path(i) == 82
            a = atanh(2 / pi);
            y(i) = atanh(2 / pi * x(i)) / a;
        elseif which_path(i) == 83
            a = sinh(1);
            a = a / (1 + a);
            x(i) = sinh(x(i));
            y(i) = (x(i) / (1 + x(i))) / a;
        elseif which_path(i) == 84
            a = 1 / (1 - exp(1));
            y(i) = ((1 / (x(i) - exp(x(i)))) + 1) / (a + 1);
        elseif which_path(i) == 85
            a = (cosh(1) - 1) / (cosh(1) + 1);
            y(i) = (cosh(x(i)) - 1) / (cosh(x(i)) + 1) / a;
        elseif which_path(i) == 86
            a = (exp(1) - 1) / (exp(1) + 1);
            y(i) = (exp(x(i)) - 1) / (exp(x(i)) + 1) / a;
        elseif which_path(i) == 87
            a = (exp(1) - 1) / (exp(1) + 1);
            y(i) = sqrt(((exp(x(i)) - 1) / (exp(x(i)) + 1)) / a);
        elseif which_path(i) == 88
            a = (1 - cos(1)) / (1 + cos(1));
            y(i) = (1 - cos(x(i))) / (1 + cos(x(i))) / a;
        elseif which_path(i) == 89
            a = (1 - cos(1)) / (1 + cos(1));
            y(i) = sqrt((1 - cos(x(i))) / (1 + cos(x(i))) / a);
        elseif which_path(i) == 90
            a = log(2) / (1 + log(2));
            y(i) = (log(1 + x(i)^2) / (1 + log(1 + x(i)^2))) / a;
        elseif which_path(i) == 91
            a = log(2) / (1 + log(2));
            y(i) = sqrt((log(1 + x(i)^2) / (1 + log(1 + x(i)^2))) / a);
        else
            y(i) = x(i);
        end
    end
end
%-------------------------------------------------------%