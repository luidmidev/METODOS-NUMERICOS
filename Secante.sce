// Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
// Date of creation: 28/11/2021

function y=f(x)
    y= %e ^ sqrt(1 * x - 2) - 10
endfunction

function secante(tend, x0, x1)
    k=1;
    tendencia  = 1000;
    while tendencia >= tend
        disp("----------------------------------------------------------------------");
        disp("Iteración "+string(k)+"       (k="+string(k)+")");
        disp("x"+string(k+1)+" = x"+string(k)+" - f(x" + string(k)+")(x"+string(k)+ " - x"+string(k-1)+")/(f(x"+string(k)+")"+" - "+"f(x"+string(k-1)+"))");
        
        disp("f(x"+string(k)+") = f("+string(x1)+") = "+string(f(x1)));
        disp("f(x"+string(k-1)+") = f("+string(x0)+") = "+string(f(x0)));
        
        x = x1-f(x1)*(x1-x0)/(f(x1)-f(x0));
        
        disp("x"+string(k+1)+" = "+string(x1)+" - "+string(f(x1))+"("+string(x1)+" - "+string(x0)+")/("+string(f(x1))+" - "+string(f(x0))+") = "+string(x));
        
        tendencia=abs(x-x1);
        disp("Tendencia = | "+string(x)+" - "+string(x1)+" | = "+string(tendencia));
        er = (tendencia/x)*100;
        disp("Error relativo = |"+string(tendencia)+"|/|"+string(abs(x))+"|*100% = "+string(er));
        k=k+1;
        x0=x1;
        x1=x;
    end
endfunction
