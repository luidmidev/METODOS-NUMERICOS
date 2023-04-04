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
fun2 = "x^2-2";
y0 = 0.7182818;

function metodoEuler(a, b, h)
    x0 = a;
    rang = a : h : b;
    yapro = (zeros(length(rang), 1))
    yreal = (zeros(length(rang), 1))
        x = (zeros(length(rang) - 1, 1))
        x = [x0; x]        
        yapro(1) = y0;
        mprintf("Si i = 0 \n")        
        x(1) = x0;
        yapro(2) = y0 + h * df(x(1), y0)            
        mprintf("y_" + s(1) + " = " + s(y0) + " + " + s(h) + "(" + rf(x(1), yapro(1)) + ")\n")
        mprintf("y_" + s(1) + " = " + s(yapro(2)) + "\n")
        mprintf("\n")                
        for i = 2 : length(rang)  - 1          
            mprintf("Si i = " + s(i - 1) + "\n")
            
            x(i) = x(i - 1) + h;            
            yapro(i + 1) = yapro(i) + h * df(x(i) , yapro(i))      
            
            mprintf("x_" + s(i - 1) + " = " + s(x(i - 1)) + " + " + s(h) + " = " + s(x(i)) + "\n")      
            mprintf("y_" + s(i) + " = " + s(yapro(i)) + " + " + s(h) + "(" + rf(x(i), yapro(i)) + ")\n")
            mprintf("y_" + s(i) + " = " + s(yapro(i + 1)) + "\n")
            mprintf("\n")
           
        end
        x(length(rang)) = b;
            
    if fun2 == "null" then
        table = s(zeros(length(rang) + 1, 3))
        table(1, :) = ["n", "x_n", "y_(apro)"]       
        n = (0 : length(rang) - 1)';
        table(2 : length(rang) + 1, :) = s([n, x, yapro]);
        for i = 1 : size(table)(1)
            mprintf("%s \t %s \t %s \n", table(i, 1), table(i, 2), table(i, 3));
        end
    else        
        table = s(zeros(length(rang) + 1, 5))
        table(1, :) = ["n", "x_n", "y_(apro)", "y_(real)", "E_a"]        
        yreal = f(x);
        ea = abs(yreal - yapro);
        n = (0 : length(rang) - 1)';
        table(2 : length(rang) + 1, :) = s([n, x, yapro, yreal, ea]);
        for i = 1 : size(table)(1)
            mprintf("%s \t %s \t %s \t %s \t %s \n", table(i, 1), table(i, 2), table(i, 3), table(i, 4), table(i, 5));
        end
    end
endfunction

function r = s(a)
    r = string(a)
endfunction


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

metodoEuler(5, 10, 0.5);