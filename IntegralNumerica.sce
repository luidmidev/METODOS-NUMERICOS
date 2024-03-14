// Copyright (C) 2022  -  WaiperSoft  -  PlayerLuis
// About your license if you have any
// Date of creation: 30/01/2022

C = 17;

fun = "sqrt(C^2-x^2)";; 

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
    funs = strsubst(funs,'C', s(C));
    funs = strsubst(funs,'absx', '|x|');
    funs = strsubst(funs,'abs(x²)', '|x²|');
    funs = strsubst(funs,'abs(x³)', '|x³|');
    funs = strsubst(funs,'abs(x⁴)', '|x⁴|');
    funs = strsubst(funs,'abs(x⁵)', '|x⁵|');
    funs = strsubst(funs,'abs(x⁶)', '|x⁶|');
    str = funs;
endfunction

function r = s(a)
    r = string(a)
endfunction

function r  =  metodoTrapecio(x0, x1)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    disp("");
    y0 = f(x0);
    y1 = f(x1);
    h = x1 - x0;
    a = h * (y0 + y1) / 2;
    disp("y0 = ƒ(x0) = " + rf(x0) + " = " + s(y0));
    disp("y1 = ƒ(x1) = " + rf(x1) + " = " + s(y1));
    disp("h = x1 - x0 = " + s(x1) + " - " + s(x0) + " = " + s(h));
    disp("∫ desde "+s(x0)+" hasta "+s(x1)+" de " + rf("x") + "dx ≈ (" + s(h) +"(" + s(y0) + " + " + s(y1) + "))/2 = " + s(a));
    r  =  a;
endfunction

function r = metodoTrapecioCompuesto(x0, xn, n)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    disp("");
    h = (xn  -  x0)/n;
    disp("h = (xn  -  x0)/n = (" + s(xn) + "  -  " + s(x0) + ")/" + s(n) + " = " + s(h));
    disp("")
    y = zeros(1, n + 1)
    for i = 1 : n + 1
        y(i) = f(x0 + (i  -  1) * h);
        disp("x" + s(i - 1) + " = x0 + " + s(i-1) + "(h) = " + s(x0) + " + " + s(i - 1) + "(" + s(h) + ") = " + s(x0 + (i - 1) * h))
        disp("y" + s(i - 1) + " = " + rf(x0 + (i - 1) * h) + " = " + s(y(i)));
    end
    disp("")
    str = "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ " + s(h) + "[" + s(y(1)) +"/2";
    suma = y(1)/2;
    for i = 2: n
        str = str + " + (" + s(y(i)) + ")";
        suma = suma + y(i);
    end
    str  =  str + " + (" + s(y(n + 1)) + ")/2]";
    suma  =   suma + y(n + 1)/2;
    disp(str);
    a  =  h * suma
    str2  =  "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ " + s(a);
    disp(str2);
    r  =  a;
endfunction

function r  =  metodoSimpson13(x0, x2)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    disp("");
    h  =  (x2  -  x0)/2;
    disp("h = ("+s(x2)+" - "+s(x0)+")/2 = "+s(h))
    disp("")
    x1  =  x0 + h;
    disp("x0 = " + s(x0));
    disp("x1 = x0 + 1(h) = " + s(x1));
    disp("x2 = x0 + 2 (h) = " + s(x2));
    y0  =  f(x0);
    y2  =  f(x2);
    y1  =  f(x1);
    a  =  h * (y0 + 4 * y1 + y2) / 3;    
    disp("y0 = ƒ(x0) = " + rf(x0) + " = " + s(y0));
    disp("y1 = ƒ(x1) = " + rf(x1) + " = " + s(y1));
    disp("y2 = ƒ(x2) = " + rf(x2) + " = " + s(y2));
    disp("∫ desde "+s(x0)+" hasta "+s(x2)+" de " + rf("x") + "dx ≈ " + s(h) +"/3 ("+s(y0)+" + 4("+s(y1)+") + ("+s(y2)+")) = "+s(a));
    r  =  a;
endfunction


function r  =  metodoSimsonp13Extendido(x0, xn, n)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    h  =  (xn  -  x0)/n;
    disp("h = (xn - x0)/n = (" + s(xn) + " - (" + s(x0) + "))/" + s(n) + " = " + s(h));
    disp("")
    y  =  zeros(1, n + 1)
    for i  =  1 : n + 1
        y(i)  =  f(x0 + (i  -  1) * h);
        disp("x" + s(i - 1) + " = x0 + " + s(i - 1) + "(h) = " + s(x0) + " + " +s(i - 1) + "(" + s(h) + ") = " + s(x0 + (i - 1) * h))
        disp("y" + s(i - 1) + " = " + rf(x0 + (i - 1) * h) + " = " + s(y(i)));
    end
    disp("")
    str = "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ " + s(h) + "/3 [" + s(y(1));
    suma = y(1);
    strp = "(" + s(y(3));
    stri = "(" + s(y(2));
    suma = suma + 2 * y(3);
    suma = suma + 4 * y(2); 
    for i = 2 : n
        if modulo((i  -  1), 2) == 0 && i > 3 then
            strp = strp + " + (" + s(y(i)) + ")"; 
            suma = suma + 2 * y(i);              
        end
        if modulo((i  -  1), 2) <> 0 && i > 2 then
            stri = stri + " + (" + s(y(i)) + ")";
            suma = suma + 4 * y(i);
        end
    end

    str = str + " + 4(" + s(evstr(stri + ")")) + ") + 2(" + s(evstr(strp + ")")) + ") + (" + s(y(n + 1)) + ")]";
    suma = suma + y(n + 1);
    disp(str);
    a = (h / 3) * suma
    str2 = "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ " + s(a);
    disp(str2);
    r = a;
endfunction

function r = metodoSimpson38(x0, x3)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    h = (x3 - x0)/3;
    disp("h = ("+s(x3)+" - "+s(x0)+")/3 = "+s(h))
    disp("")
    x1 = x0 + h;
    x2 = x0 + 2 * h;
    disp("x0 = " + s(x0));
    disp("x1 = x0 + 1(h) = " + s(x1));
    disp("x2 = x0 + 2(h) = " + s(x2));
    disp("x3 = x0 + 3(h) = " + s(x3));
    y0 = f(x0);
    y2 = f(x2);
    y1 = f(x1);
    y3 = f(x3)
    a  = 3 * h * (y0 + 3 * y1 + 3 *y2 + y3) / 8;    
    disp("y0 = ƒ(x0) = " + s(y0));
    disp("y1 = ƒ(x1) = " + s(y1));
    disp("y2 = ƒ(x2) = " + s(y2));
    disp("y3 = ƒ(x3) = " + s(y3));
    disp("∫ desde "+s(x0)+" hasta "+s(x3)+" de " + rf("x") + "dx ≈ (3(" + s(h) +")/8)("+s(y0)+" + 3("+s(y1)+") + 3("+s(y2)+") + "+s(y3)+") = "+s(a));
    r = a;
endfunction

function r =  metodoSimsonp38Extendido(x0, xn, n)
    disp("C = " + s(C))
    disp("ƒ(x) = " + rf("x"));
    h = (xn  -  x0)/n;
    disp("h = (xn - x0)/n = (" + s(xn) + " - (" + s(x0) + "))/" + s(n) +" = " + s(h));
    disp("")
    y = zeros(1, n + 1)
    for i = 1 : n + 1
        y(i) = f(x0 + (i - 1) * h);
        disp("x" + s(i - 1) + " = x0 + " + s(i -1) + "(h) = " + s(x0) + " + " +s(i - 1) + "(" + s(h) + ") = " + s(x0 + (i - 1) * h))
        disp("y" + s(i - 1) + " = " + rf(x0 + (i - 1) * h) + " = " + s(y(i)));
    end
    disp("")
    str = "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ (3(" +s(h) + ")/8)[" + s(y(1));
    suma = y(1);
    str1 = "(" + s(y(2));
    str2 = "(" + s(y(3));
    str3 = "(" + s(y(4));
    suma1 = y(2);
    suma2 = y(3); 
    suma3 = y(4); 
    for i = 5 : 3 : n  -  1
        suma1  =  suma1 + y(i);
    end
    for i  =  6 : 3 : n 
        suma2  =  suma2 + y(i);
    end
    for i  =  7 : 3 : n  -  2
        suma3  =  suma3 + y(i);
    end

    str  =  str + " + 3(" + s(suma1) + ") + 3(" + s(suma2) + ") + 2(" +s(suma3) + ") + (" + s(y(n + 1)) + ")]";
    suma  =   suma + 3 * suma1 + 3 * suma2 + 2 * suma3 + y(n + 1);
    disp(str);
    a  =  (3 * h / 8) * suma
    str2  =  "∫ desde "+s(x0)+" hasta "+s(xn)+" de " + rf("x") + "dx ≈ " + s(a);
    disp(str2);
    r  =  a;
endfunction
