// Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
//About your license if you have any
//Date of creation: 09/02/2022

C = 17;
fun = "x^(-2)*sin(C*x)";

function y = f(x)
    execstr("y = " + fun);
endfunction


function y = df(x)
    y = numderivative(f, x)
endfunction

function y = df2(x)
    y = numderivative(df, x)
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
    funs = strsubst(funs,'C', s(C));
    funs = strsubst(funs,'absx', '|x|');
    funs = strsubst(funs,'abs(x²)', '|x²|');
    funs = strsubst(funs,'abs(x³)', '|x³|');
    funs = strsubst(funs,'abs(x⁴)', '|x⁴|');
    funs = strsubst(funs,'abs(x⁵)', '|x⁵|');
    funs = strsubst(funs,'abs(x⁶)', '|x⁶|');
    str = funs;
endfunction

function r = diferenciaCentrada(x0, h, orden)
    disp("");
    disp("C = " + s(C))
    disp("ƒ(x) = " + fun);
    disp("");
    df = 0;
    select orden 
    case 1 then
        f1 = f(x0 + 1 * h);
        f_1 = f(x0 - 1 * h);
        df = (f1 - f_1)/(2 * h)
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("");
        disp("ƒ´(" + s(x0) + ") ≈ (" + s(f1) + " - (" + s(f_1) + "))/(2×" + s(h) + ")");
        disp("ƒ´(" + s(x0) + ") ≈ " + s(df));
    case 2 then
        f1 = f(x0 + 1 * h);
        f_1 = f(x0 - 1 * h);
        f0 = f(x0 + 0 * h);
        df = (f1 - 2 * f0 + f_1)/(h ^ 2)
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 - 0 * h) + ") = " + rf(x0 - 0 * h) + " = " + s(f0));
        disp("");
        disp("ƒ´´(" + s(x0) + ") ≈ (" + s(f1) + " - 2×(" + s(f0) + ") + (" + s(f_1) + "))/(" + s(h) + ")²");
        disp("ƒ´´(" + s(x0) + ") ≈ " + s(df));
    case 3 then
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        df = (f2 - f1 + 2 * f_1 - f_2)/(2 * (h ^ 3))
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("")
        disp("ƒ´´´(" + s(x0) + ") ≈ (" + s(f2) + " - (" + s(f1) + ") + 2×(" + s(f_1) + ") - (" + s(f_2) + "))" + ..
        "/(2×(" + s(h) + ")³)");
        disp("ƒ´´´(" + s(x0) + ") ≈ " + s(df));
    case 4 then
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        f0 = f(x0 + 0 * h);
        df = (f2 - 4 * f1 + 6 * f0 - 4 * f_1 + f_2)/(h ^ 4)
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("")
        disp("ƒ´´´´(" + s(x0) + ") ≈ (" + s(f2) + " - 4×(" + s(f1) + ") + 6×(" + s(f0) + ") - 4×(" + s(f_1) + ..
        ") - (" + s(f_2) + "))" + "/(" + s(h) + ")⁴");
        disp("ƒ´´´´(" + s(x0) + ") ≈ " + s(df));
    else
        disp("No disponemos de ese orden de derivada :)");
    end
    disp("");
    r = df;
endfunction

function r = diferenciaProgresiva(x0, h, orden)
    disp("")
    disp("C = " + s(C))
    disp("ƒ(x) = " + fun);
    disp("");
    df = 0;
    select orden 
    case 1 then
        f0 = f(x0 + 0 * h);
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        df = (- 3 * f0 + 4 * f1 - f2)/(2 * h);
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("");
        disp("ƒ´(" + s(x0) + ") ≈ (-3×(" + s(f0) + ") + 4×(" + s(f1) + ") - (" + s(f2) + "))/(2×" + s(h) + ")");
        disp("ƒ´(" + s(x0) + ") ≈ " + s(df));
    case 2 then
        f0 = f(x0 + 0 * h);
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        f3 = f(x0 + 3 * h);
        df = (2 * f0 - 5 * f1 + 4 * f2 - f3)/(h ^ 2);
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("ƒ3 = ƒ(" + s(x0) + " + 3×(" + s(h) + ")) = ƒ(" + s(x0 + 3 * h) + ") = " + rf(x0 + 3 * h) + " = " + s(f3));
        disp("");
        disp("ƒ´´(" + s(x0) + ") ≈ (2×" + s(f0) + " - 5×(" + s(f1) + ") + 4×(" + s(f2) + ") - (" + s(f3) + "))/(" + s(h) + ")²");
        disp("ƒ´´(" + s(x0) + ") ≈ " + s(df));
    case 3 then
        f0 = f(x0 + 0 * h);
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        f3 = f(x0 + 3 * h);
        f4 = f(x0 + 4 * h);
        df = (- 5 * f0 + 18 * f1 - 24 * f2 + 14 * f3 - 3 * f4)/(2 * (h ^ 3))
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("ƒ3 = ƒ(" + s(x0) + " + 3×(" + s(h) + ")) = ƒ(" + s(x0 + 3 * h) + ") = " + rf(x0 + 3 * h) + " = " + s(f3));
        disp("ƒ4 = ƒ(" + s(x0) + " + 4×(" + s(h) + ")) = ƒ(" + s(x0 + 4 * h) + ") = " + rf(x0 + 4 * h) + " = " + s(f4));
        disp("")
        disp("ƒ´´´(" + s(x0) + ") ≈ (- 5×(" + s(f0) + ") + 18×(" + s(f1) + ") - 24×(" + s(f2) +..
        ") + 14×(" + s(f3) + ") - 3×(" + s(f4) + "))/(2×(" + s(h) + ")³)");
        disp("ƒ´´´(" + s(x0) + ") ≈ " + s(df));
    case 4 then
        f0 = f(x0 + 0 * h);
        f1 = f(x0 + 1 * h);
        f2 = f(x0 + 2 * h);
        f3 = f(x0 + 3 * h);
        f4 = f(x0 + 4 * h);
        f5 = f(x0 + 5 * h);
        df = (3 * f0 - 14 * f1 + 26 * f2 - 24 * f3 + 11 * f4 - 2 * f5)/(h ^ 4)
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ1 = ƒ(" + s(x0) + " + 1×(" + s(h) + ")) = ƒ(" + s(x0 + 1 * h) + ") = " + rf(x0 + 1 * h) + " = " + s(f1));
        disp("ƒ2 = ƒ(" + s(x0) + " + 2×(" + s(h) + ")) = ƒ(" + s(x0 + 2 * h) + ") = " + rf(x0 + 2 * h) + " = " + s(f2));
        disp("ƒ3 = ƒ(" + s(x0) + " + 3×(" + s(h) + ")) = ƒ(" + s(x0 + 3 * h) + ") = " + rf(x0 + 3 * h) + " = " + s(f3));
        disp("ƒ4 = ƒ(" + s(x0) + " + 4×(" + s(h) + ")) = ƒ(" + s(x0 + 4 * h) + ") = " + rf(x0 + 4 * h) + " = " + s(f4));
        disp("ƒ5 = ƒ(" + s(x0) + " + 5×(" + s(h) + ")) = ƒ(" + s(x0 + 5 * h) + ") = " + rf(x0 + 5 * h) + " = " + s(f5));
        disp("")
        disp("ƒ´´´´(" + s(x0) + ") ≈ (3×(" + s(f0) + ") - 14×(" + s(f1) + ") + 26×(" + s(f2) + ") - 24×(" + s(f3) +..
        ") + 11×(" + s(f4) + ") - 2×(" + s(f5) + "))/(" + s(h) + ")⁴");
        disp("ƒ´´´´(" + s(x0) + ") ≈ " + s(df));
    else
        disp("No disponemos de ese orden de derivada :)");
    end
    disp("");
    r = df;
endfunction


function r = diferenciaRegresiva(x0, h, orden)
    disp("")
    disp("C = " + s(C))
    disp("ƒ(x) = " + fun);
    disp("");
    df = 0;
    select orden 
    case 1 then
        f0 = f(x0 + 0 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        df = (3 * f0 - 4 * f_1 + f_2)/(2 * h);
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("");
        disp("ƒ´(" + s(x0) + ") ≈ (" + s(f0) + " - 4×(" + s(f_1) + ") + (" + s(f_2) + "))/(2×" + s(h) + ")");
        disp("ƒ´(" + s(x0) + ") ≈ " + s(df));
    case 2 then
        f0 = f(x0 + 0 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        f_3 = f(x0 - 3 * h);
        df = (2 * f0 - 5 * f_1 + 4 * f_2 - f_3)/(h ^ 2);
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("ƒ-3 = ƒ(" + s(x0) + " - 3×(" + s(h) + ")) = ƒ(" + s(x0 - 3 * h) + ") = " + rf(x0 - 3 * h) + " = " + s(f_3));
        disp("");
        disp("ƒ´´(" + s(x0) + ") ≈ (2×" + s(f0) + " - 5×(" + s(f_1) + ") + 4×(" + s(f_2) + ") - (" + s(f_3) +..
        "))/(" + s(h) + ")²");
        disp("ƒ´´(" + s(x0) + ") ≈ " + s(df));
    case 3 then
        f0 = f(x0 + 0 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        f_3 = f(x0 - 3 * h);
        f_4 = f(x0 - 4 * h);
        df = (5 * f0 - 18 * f_1 + 24 * f_2 - 14 * f_3 + 3 * f_4)/(2 * (h ^ 3))
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 + 0 * h) + " = " + s(f0));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("ƒ-3 = ƒ(" + s(x0) + " - 3×(" + s(h) + ")) = ƒ(" + s(x0 - 3 * h) + ") = " + rf(x0 - 3 * h) + " = " + s(f_3));
        disp("ƒ-4 = ƒ(" + s(x0) + " - 4×(" + s(h) + ")) = ƒ(" + s(x0 - 4 * h) + ") = " + rf(x0 - 4 * h) + " = " + s(f_4));
        disp("")
        disp("ƒ´´´(" + s(x0) + ") ≈ (5×(" + s(f0) + ") - 18×(" + s(f_1) + ") + 24×(" + s(f_2) +..
        ") - 14×(" + s(f_3) + ") + 3×(" + s(f_4) + "))/(2×(" + s(h) + ")³)");
        disp("ƒ´´´(" + s(x0) + ") ≈ " + s(df));
    case 4 then
        f0 = f(x0 + 0 * h);
        f_1 = f(x0 - 1 * h);
        f_2 = f(x0 - 2 * h);
        f_3 = f(x0 - 3 * h);
        f_4 = f(x0 - 4 * h);
        f_5 = f(x0 - 5 * h);
        df = (3 * f0 - 14 * f_1 + 26 * f_2 - 24 * f_3 + 11 * f_4 - 2 * f_5)/(h ^ 4)
        disp("ƒ0 = ƒ(" + s(x0) + " + 0×(" + s(h) + ")) = ƒ(" + s(x0 + 0 * h) + ") = " + rf(x0 - 0 * h) + " = " + s(f0));
        disp("ƒ-1 = ƒ(" + s(x0) + " - 1×(" + s(h) + ")) = ƒ(" + s(x0 - 1 * h) + ") = " + rf(x0 - 1 * h) + " = " + s(f_1));
        disp("ƒ-2 = ƒ(" + s(x0) + " - 2×(" + s(h) + ")) = ƒ(" + s(x0 - 2 * h) + ") = " + rf(x0 - 2 * h) + " = " + s(f_2));
        disp("ƒ-3 = ƒ(" + s(x0) + " - 3×(" + s(h) + ")) = ƒ(" + s(x0 - 3 * h) + ") = " + rf(x0 - 3 * h) + " = " + s(f_3));
        disp("ƒ_4 = ƒ(" + s(x0) + " - 4×(" + s(h) + ")) = ƒ(" + s(x0 - 4 * h) + ") = " + rf(x0 - 4 * h) + " = " + s(f_4));
        disp("ƒ-5 = ƒ(" + s(x0) + " - 5×(" + s(h) + ")) = ƒ(" + s(x0 - 5 * h) + ") = " + rf(x0 - 5 * h) + " = " + s(f_5));
        disp("")
        disp("ƒ´´´´(" + s(x0) + ") ≈ (3×(" + s(f0) + ") - 14×(" + s(f_1) + ") + 26×(" + s(f_2) + ") - 24×(" + s(f_3) +..
        ") + 11×(" + s(f_4) + ") - 2×(" + s(f_5) + "))/(" + s(h) + ")⁴");
        disp("ƒ´´´´(" + s(x0) + ") ≈ " + s(df));
    else
        disp("No disponemos de ese orden de derivada :)");
    end
    disp("");
    r = df;
endfunction

function r = s(a)
    r = string(a)
endfunction
