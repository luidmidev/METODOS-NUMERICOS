// Copyright (C) 2022 - WaiperSoft - PlayerLuis
// About your license if you have any
// Date of creation: 15/02/2022

function dy = df(x, y)
    execstr("dy = " + fun1);
endfunction

function y = f(x)
    execstr("y = " + fun2);
endfunction

fun1 = "2*x^2 - 4*x + y";
fun2 = "x^2-1";
y0 = 0.7182818;

function str = rf(xval, yval)
    funs = fun1;
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
    funs = strsubst(funs,'y', '('+s(yval)+')');
    funs = strsubst(funs,'(y)','(' + s(yval) +')');
    funs = strsubst(funs,'absx', '|y|');
    funs = strsubst(funs,'abs(y²)', '|y²|');
    funs = strsubst(funs,'abs(y³)', '|y³|');
    funs = strsubst(funs,'abs(y⁴)', '|y⁴|');
    funs = strsubst(funs,'abs(y⁵)', '|y⁵|');
    funs = strsubst(funs,'abs(y⁶)', '|y⁶|');    
    str = funs;
endfunction

function r = s(a)
    r = string(a)
endfunction

function metodoHeun(a, b, h)
    x0 = a;
    xi = (a : h : b)';
    yi = zeros(length(xi), 1)
    yi(1) = y0;
    for i = 0 : length(xi) - 2
            
            mprintf("Cuando i = " + s(i) + "\n")
            
            k1 = h * df(xi(i + 1), yi(i + 1));
            k2 = h * df(xi(i + 1) + h, yi(i + 1) + k1);
            yi(i + 2) = yi(i + 1) + 0.5 * (k1 + k2);
            
            mprintf("x_" + s(i) + " = " + s(x0) + " + " + s(i) + "(" + s(h) + ") = " + s(xi(i + 1)) + "\n")

            mprintf("K_1 = " + s(h) + "×f(" + s(xi(i + 1)) + ", " + s(yi(i + 1)) + ")\n");
            mprintf("K_1 = " + s(h) + "×(" + rf(xi(i + 1), yi(i + 1)) + ")\n");
            mprintf("K_1 = " + s(k1) + "\n");
            
            mprintf("K_2 = " + s(h) + "×f(" + s(xi(i + 1)) + " + " + s(h) + ", " + s(yi(i + 1)) + " + (" + s(k1) + "))\n");
            mprintf("K_2 = " + s(h) + "×f(" + s(xi(i + 1) + (h)) + ", " + s(yi(i + 1) + (k1)) + ")\n");
            mprintf("K_2 = " + s(h) + "×(" + rf(xi(i + 1) + h, yi(i + 1) + k1) + ")\n");
            mprintf("K_2 = " + s(k2) + "\n");
            
            mprintf("y_" + s(i + 1) + " = " + s(yi(i + 1)) + " + (1/2)×(" + s(k1) + " + (" + s(k2) + "))\n" );
            mprintf("y_" + s(i + 1) + " = " + s(yi(i + 2)) + "\n")
            mprintf("\n");
            
    end
    if fun2 == "null" then  
              
        n = length(xi);
        table = s(zeros(n + 1, 2));
        table(1, :) = ["x_i", "ý_(xi)"]
        table(2 : n + 1, :) = s([xi, yi])
        
        for i = 1 : size(table)(1)
            mprintf("%s \t %s \n", table(i, 1), table(i, 2));
        end
        
    else        
        
        n = length(xi);
        table = s(zeros(n + 1, 3));
        table(1, :) = ["x_i", "ý_(xi)", "y_(xi)"]
        table(2 : n + 1, :) = s([xi, yi, f(xi)])
        
        for i = 1 : size(table)(1)
            mprintf("%s \t %s \t %s \n", table(i, 1), table(i, 2), table(i, 3));
        end
        
    end
endfunction


