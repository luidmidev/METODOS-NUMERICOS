 // Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
// Date of creation: 28/11/2021 

function y=f(x)
    y=x^4 + 3*x^3-2;
endfunction

function y=df(x)
    y=4*x^3 + 9*x^2;
endfunction

function Newton(tendencia_fin, x0)
    tendencia = %inf;
    k=0;
    while tendencia <= tendencia_fin
        disp("----------------------------------------------------------------------");
        disp("Iteración " + string(k + 1) + "       (k=" + string(k) + ")");
        disp("x" + string(k + 1) + " = x" + string(k) + " - f(x"  +  string(k) + ")/f´(x" + string(k) + ")");
        disp("f(" + string(x0) + ") = " + string(f(x0)));
        disp("f´(" + string(x0) + ") = " + string(df(x0)));
        x = x0 - (f(x0)/df(x0))
        disp("x" + string(k + 1) + " = " + string(x0) + " - (" + string(f(x0)) + ")/(" + string(df(x0)) + ") =" + string(x));
        tendencia=abs(x-x0);
        disp("Tendencia = | " + string(x) + " - " + string(x0) + " | = " + string(tendencia));
        er = (tendencia/x)*100;
        disp("Error relativo = |" + string(tendencia) + "|/|" + string(abs(x)) + "|*100% = " + string(er));
        k=k + 1;
        x0=x;
    end
endfunction
