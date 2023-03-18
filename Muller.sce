// Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
// Date of creation: 28/11/2021

function y=f(x)
    y=x^4-4*x^3+2*x-30;
endfunction

function Muller(iteraciones, x0, x1, x2)
    i = 2;
    x=0;
    while i-1 <= iteraciones;
        disp("----------------------------------------------------------------------");
        disp("Iteración "+s(i-1)+"       (i="+s(i)+")");
        
        f2=f(x2);
        f1=f(x1);
        f0=f(x0);
        
        disp("f"+s(i)+" = f(x"+s(i)+") = f("+s(x2)+") = "+s(f2));
        disp("f"+s(i-1)+" = f(x"+s(i-1)+") = f("+s(x1)+") = "+s(f1));
        disp("f"+s(i-2)+" = f(x"+s(i-2)+") = f("+s(x0)+") = "+s(f0));
        
        f21=(f2-f1)/(x2-x1);
        disp("f[x"+s(i)+", x"+s(i-1)+"] = (f"+s(i)+" - "+"f"+s(i-1)+")/(x"+s(i)+" - "+"x"+s(i-1)+") = ("+s(f2)+" - "+s(f1)+")/("+s(x2)+" - "+s(x1)+") = "+s(f21));
        
        f10=(f1-f0)/(x1-x0);
        disp("f[x"+s(i-1)+", x"+s(i-2)+"] = (f"+s(i-1)+" - "+"f"+s(i-2)+")/(x"+s(i-1)+" - "+"x"+s(i-2)+") = ("+s(f1)+" - "+s(f0)+")/("+s(x1)+" - "+s(x0)+") = "+s(f10));
        
        f210=(f21-f10)/(x2-x0);
        disp("f[x"+s(i)+", x"+s(i-1)+", x"+s(i-2)+"] = (f[x"+s(i)+", x"+s(i-1)+"] - f[x"+s(i-1)+", x"+s(i-2)+"])/(x"+s(i)+" - x"+s(i-1)+") = ("+s(f21)+" - "+s(f10)+")/("+s(x2)+" - "+s(x0)+") = "+s(f210));
        
        a2=f210;
        disp("a2 = f[x"+s(i)+", x"+s(i-1)+", x"+s(i-2)+"] = "+s(a2));
        
        a1=f21-(x2+x1)*a2;
        disp("a1 = f[x"+s(i)+", x"+s(i-1)+"] - (x"+s(i)+" + x"+s(i-1)+")*a2 = "+s(f21)+" - ("+s(x2)+" + "+s(x1)+")*"+s(a2)+" = "+s(a1));
        
        a0=f2-x2*(f21-x1*a2)
        disp("a0 = f"+s(i)+" - x"+s(i)+"(f[x"+s(i)+", x"+s(i-1)+"] - x"+s(i-1)+"*a2 = "+s(f2)+" - "+s(x2)+"("+s(f21)+" - "+s(x1)+"*"+s(a2)+") = " + s(a0));
        
        d1 = -a1+(a1^2-4*a0*a2)^(0.5);
        disp("-a1 + (a1^2 - 4*a0*a2)^(1/2) = -"+s(a1)+" + ("+s(a1)+"^2 - 4"+s(a0)+"*"+s(a2)+")^(1/2) = " + s(d1));
        d2 = -a1-(a1^2-4*a0*a2)^(0.5);
        disp("-a1 - (a1^2 - 4*a0*a2)^(1/2) = -"+s(a1)+" - ("+s(a1)+"^2 - 4"+s(a0)+"*"+s(a2)+")^(1/2) = " + s(d2));
        if abs(d1)>abs(d2) then
            x=2*a0/d1;
            disp("x"+s(i+1)+"= 2*a0/(-a1 + (a1^2 - 4*a0*a2)^(1/2)) = 2*"+s(a0)+"/"+s(d1)+" = " + s(x));
        else 
            x=2*a0/d2;
            disp("x"+s(i+1)+"= 2*a0/(-a1 - (a1^2 - 4*a0*a2)^(1/2)) = 2*"+s(a0)+"/"+s(d2)+" = " + s(x));
        end
        
        x0=x1;
        x1=x2;
        x2=x;
                
        i = i + 1;
    end
endfunction

function r = s(a)
    r = string(a);
endfunction
