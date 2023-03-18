// Copyright (C) 2021 - WaiperSoft - LUID VASQUEZ
// Date of creation: 28/11/2021 

function y=f(x)    
    execstr("y = " + fun);
endfunction

fun = "x.^x - 100";

function bisection(iteraciones, a, b)
    
    disp("f(" + string(a) + ")=" + string(f(a)));
    disp("f(" + string(b) + ")=" + string(f(b)));
    
    if f(a)*f(b)<0 then
        
        i = 1;
        disp("-------------------------------------------------");
        disp("Iteración: " + string(i) + " ["+ string(a) + ", " + string(b) + "]");
                
        m = (a + b)/2;
        disp("m=(" + string(a) + "+" + string(b) +")/2="+string(m));
               
        disp("f(" + string(m) + ")=" + string(f(m)));
        disp("f(" + string(a) + ")=" + string(f(a)));
        
        i = i + 1;

        while i<=iteraciones
                
            if f(m)*f(a)<0 then
                disp("f("+string(m)+")*f("+string(a)+")= -"); 
                b=m;
                disp("-------------------------------------------------");
                disp("Iteración: " + string(i) + " ["+ string(a) + ", " + string(b) + "]");
                    
                m=(a + b)/2;
                disp("m=(" + string(a) + "+" + string(b) +")/2="+string(m));
                        
                disp("f(" + string(m) + ")=" + string(f(m)));
                disp("f(" + string(a) + ")=" + string(f(a))); 
                i=i+1;                      
            else
                disp("f("+string(m)+")*f("+string(a)+")= +"); 
                a = m;
                disp("-------------------------------------------------");
                disp("Iteración: " + string(i) + " ["+ string(a) + ", " + string(b) + "]");
                    
                m=(a + b)/2;
                disp("m=(" + string(a) + "+" + string(b) +")/2="+string(m));
                  
                disp("f(" + string(m) + ")=" + string(f(m)));
                disp("f(" + string(a) + ")=" + string(f(a)));
                i=i+1;   
           end                     
       end               
    end
end
