%----- Functions ---------------------------------------%
function random_values = htrandn(minVal, maxVal, n, m, precision)

    p = rand(n, m);
    random_values = minVal + (maxVal - minVal) .* p;
end
%-------------------------------------------------------%