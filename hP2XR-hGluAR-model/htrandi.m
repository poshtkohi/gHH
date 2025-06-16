%----- Functions ---------------------------------------%
function random_values = htrandi(minVal, maxVal, n, m, precision)
    random_values = round(htrandn(minVal, maxVal, n, m, precision));
end
%-------------------------------------------------------%