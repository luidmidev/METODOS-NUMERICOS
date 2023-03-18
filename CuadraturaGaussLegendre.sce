// Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
// About your license if you have any
// Date of creation: 08/02/2022

fun = "sin(3*x)*%e^-(x^2)";

function y = f(x)
    execstr("y = " + fun);
endfunction

function str = rf(xval)
    funs = fun;
    funs = strsubst(funs,'x', '('+s(xval)+')');
    funs = strsubst(funs,'^2','²');
    funs = strsubst(funs,'^3','³');
    funs = strsubst(funs,'^4','⁴');
    funs = strsubst(funs,'^5','⁵');
    funs = strsubst(funs,'^6','⁶');
    funs = strsubst(funs,'sqrt','√');
    funs = strsubst(funs,'%e','e');
    funs = strsubst(funs,'%pi','π');
    funs = strsubst(funs,'log','ln');
    funs = strsubst(funs,'(x)','(' + s(xval) +')');
    funs = strsubst(funs,'(x)','x');
    funs = strsubst(funs,'*','×');
    funs = strsubst(funs,'absx', '|x|');
    funs = strsubst(funs,'abs(x²)', '|x²|');
    funs = strsubst(funs,'abs(x³)', '|x³|');
    funs = strsubst(funs,'abs(x⁴)', '|x⁴|');
    funs = strsubst(funs,'abs(x⁵)', '|x⁵|');
    funs = strsubst(funs,'abs(x⁶)', '|x⁶|');
    str = funs;
endfunction

   //n i   wi            zi
t = [2  1  1             -0.5773502692 
     2  2  1             0.5773502692
     3  1  5/9           -0.7745966692
     3  2  8/9           0
     3  3  5/9           0.7745966692
     4  1  0.3478548451  -0.8611363116
     4  2  0.6521451549  -0.3399810436
     4  3  0.6521451549  0.3399810436
     4  4  0.3478548451  0.8611363116
     5  1  0.2369268851  -0.9061798459
     5  2  0.4786286705  -0.5384693101
     5  3  128/225       0.0
     5  4  0.4786286705  0.5384693101
     5  5  0.2369268851  0.9061798459
     6  1  0.1713244924  -0.9324695142
     6  2  0.3607615730  -0.6612093865
     6  3  0.4679139346  -0.2386191861
     6  4  0.4679139346  0.2386191861
     6  5  0.3607615730  0.6612093865
     6  6  0.1713244924  0.9324695142]

function w = getWi(n, i)
    for j = 1 : size(t)(1)
        if t(j, 1) == n && t(j, 2) == i then
            w = t(j, 3) 
        end
    end
endfunction

function z = getZi(n, i)
    for j = 1 : size(t)(1)
        if t(j, 1) == n && t(j, 2) == i then
            z = t(j, 4) 
        end
    end
endfunction

function r = cuadraturaGaussLegendre(a, b, n)
    disp("ƒ(x) = " + rf("x"));
    phi = zeros(1, n);
    disp("");
    for i = 1 : n
        phi(1, i) = ((b - a) / 2) * (getZi(n, i) + 1) + a;
        disp("φ"+s(i)+" = (" + s(b)+"-("+s(a)+"))/2*("+s(getZi(n, i)) + "+ 1) + ("+s(a)+") = " + s(phi(1, i)));
    end
    coef =  zeros(1, n);
    coefs =  s(zeros(1, n));
    coef(1, 1) = getWi(n, 1) * f(phi(1, 1));
    disp("");
    disp("ƒ(φ"+s(1)+") = " + rf(phi(1, 1)) + "=" + s(f(phi(1, 1))));
    str = s(getWi(n, 1)) + "(" + s(f(phi(1, 1))) + ")";
    for i = 2 : n
        coef(1, i) = getWi(n, i)* f(phi(1, i));
        disp("ƒ(φ"+s(i)+") = " + rf(phi(1, i)) + "=" + s(f(phi(1, i))));
        str = str + "+" + s(getWi(n, 1)) + "(" + s(f(phi(1, 1))) + ")";
    end
    disp("");
    dr = ((b - a) / 2) * sum(coef)
    disp("∫ desde " + s(a) + " hasta " + s(b) + " de " + rf("x") + "dx ≈ (" + s(b) + "-("+s(a)+"))/2*(" + str + ")")
    disp("∫ desde " + s(a) + " hasta " + s(b) + " de " + rf("x") + "dx ≈ "+s(dr));
    r = dr
endfunction

function r = s(a)
    r = string(a)
endfunction
