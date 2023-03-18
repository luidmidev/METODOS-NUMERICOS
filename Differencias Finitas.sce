
function y = p(x)
    execstr("y = " + px);
endfunction

function y = q(x)
    execstr("y = " + qx);
endfunction

function y = r(x)
    execstr("y = " + rx);
endfunction

function y = s(x)
    execstr("y = " + sx);
endfunction

/* p(x) = */    px = "x^-2"
/* q(x) = */    qx = "x^-2"
/* r(x) = */    rx = "x^-2"
/* s(x) = */    sx = "8*cos(2*x)"
/* y_0 = */     y0 = 0;
/* y_n = */     yn = 18.26;

/*
* y_0 = y(a)
* y_n = y(b)
*/



/***
**Form of Equation Diferential
**   
**   p(x)y´´ + q(x)y´ + r(x)y = s(x)
**   
*/

function [MatrizCoeficientes, MatrizTIndependientes, Resultado] = diferenciasFinitas2H(a, b, n)
    mprintf("\n");
    mprintf(rp("x") + "×y´´ + " + rq("x") + "×y´ + " + rr("x") + "×y = " + rs("x") + "\n");
    mprintf("\n");
    mprintf(rp("x_i") + "×(y_(i+1) - 2y_i + y_(i-1))/h² + " + ..
            rq("x_i") + "×(y_(i+1) - y_(i-1))/2h + " + .. 
            rr("x_i") + "×y_i = " + rs("x_i") + ..
            ", \t por 2h² \n");
            
    mprintf("2×" + rp("x_i") + "×(y_(i+1) - 2y_i + y_(i-1)) + " + ..
            "h" + rq("x_i") + "×(y_(i+1) - y_(i-1)) + " + .. 
            "2h²" + rr("x_i") + "×y_i = 2h²(" + rs("x_i") + ")\n");
    
    mprintf("y_(i-1)(2("+rp("x_i")+") - h("+rq("x_i")+")) " + ..
            "+ y_i(-4("+rp("x_i")+") + 2h²("+rr("x_i")+")) " + ..
            "+ y_(i+1)(2("+rp("x_i")+") + h("+rq("x_i")+")) = 2h²(" + rs("x_i") + ")\n");
    
    mprintf("\n");
    mprintf(_s(a) + " <= x <= " + _s(b) + ",\t n = " + _s(n) + "\n");
    mprintf("y_0 = y(" + _s(a) + ") = " + _s(y0) + "\n");
    mprintf("y_ " + _s(n) + " = y(" + _s(a) + ") = " + _s(yn) + "\n");
    
    h = (b - a)/n;    
    mprintf("\n");
    mprintf("h = (b - a)/n = (" + _s(b) + " - " + _s(a) + ")/" + _s(n) + " = " + _s(h) + "\n");
    
    x_n = [a, zeros(1, n - 1)];
    coe = zeros(n - 1, n - 1);
    ind = zeros(n - 1, 1);
    for i = 1 : n - 1
        
        mprintf("\n");
        mprintf("i = " + _s(i) + "\n");
        
        x_n(i + 1) = x_n(i) + h;
        x_i = x_n(i + 1);
        mprintf("x_" + _s(i) + " = " + _s(x_n(i)) + " + " + _s(h) + " = " + _s(x_i) + " \n");
        mprintf("y_"+_s(i-1)+"(2("+rp("x_"+_s(i))+") - h("+rq("x_"+_s(i))+")) " + ..
        "+ y_"+_s(i)+"(-4("+rp("x_"+_s(i))+") + 2h²("+rr("x_"+_s(i))+")) " + ..
        "+ y_"+_s(i+1)+"(2("+rp("x_"+_s(i))+") + h("+rq("x_"+_s(i))+")) = 2h²(" + rs("x_"+ _s(i)) + ")\n");   
        if i == 1 then
            
            y_a = y0*(2*p(x_i) - h*q(x_i));
            y_b = (-4*p(x_i) + 2*h^2*r(x_i));            
            y_c = (2*p(x_i) + h*q(x_i));
            ins = 2*h^2*s(x_i);
            
            coe(i, 1) = y_b;
            coe(i, 2) = y_c;
            ind(i) = ins - y_a;       
            
            mprintf(_s(y0)+"(2("+_s(p(x_i))+") - "+ _s(h) + "("+_s(q(x_i))+")) " + ..
            "+ y_"+_s(i)+"(-4("+_s(p(x_i))+") + 2("+ _s(h) + ")²("+_s(r(x_i))+")) " + ..
            "+ y_"+_s(i+1)+"(2("+_s(p(x_i))+") + "+ _s(h) + "("+_s(q(x_i))+")) = 2("+ _s(h) + ")²(" + _s(s(x_i)) + ")\n");   
            
            mprintf(_s(y_a) + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins) + "\n");   
            
            mprintf("y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins - y_a) + "\n");   
            
        elseif i == n - 1 then
            
            y_a = (2*p(x_i) - h*q(x_i));
            y_b = (-4*p(x_i) + 2*h^2*r(x_i));            
            y_c = yn*(2*p(x_i) + h*q(x_i));
            ins = 2*h^2*s(x_i);
            
            coe(i, i-1) = y_a;
            coe(i, i) = y_b
            ind(i) = ins - y_c;      
            
            mprintf("y_"+_s(i-1)+"(2("+_s(p(x_i))+") - "+ _s(h) + "("+_s(q(x_i))+")) " + ..
            "+ y_"+_s(i)+"(-4("+_s(p(x_i))+") + 2("+ _s(h) + ")²("+_s(r(x_i))+")) " + ..
            _s(yn)+"(2("+_s(p(x_i))+") + "+ _s(h) + "("+_s(q(x_i))+")) = 2("+ _s(h) + ")²(" + _s(s(x_i)) + ")\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            " + " + _s(y_c) + " = " + _s(ins) + "\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") = " + _s(ins - y_c) + "\n");    
            
        else
            
            y_a = (2*p(x_i) - h*q(x_i));
            y_b = (-4*p(x_i) + 2*h^2*r(x_i));            
            y_c = (2*p(x_i) + h*q(x_i));
            ins = 2*h^2*s(x_i);
            
            coe(i, i - 1) = y_a;
            coe(i, i) = y_b;
            coe(i, i + 1) = y_c;            
            ind(i) = ins;      
            
            mprintf("y_"+_s(i-1)+"(2("+_s(p(x_i))+") - "+ _s(h) + "("+_s(q(x_i))+")) " + ..
            "+ y_"+_s(i)+"(-4("+_s(p(x_i))+") + 2("+ _s(h) + ")²("+_s(r(x_i))+")) " + ..
            "+ y_"+_s(i+1)+"(2("+_s(p(x_i))+") + "+ _s(h) + "("+_s(q(x_i))+")) = 2("+ _s(h) + ")²(" + _s(s(x_i)) + ")\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins) + "\n");               
        end
    end
    MatrizCoeficientes = coe;
    MatrizTIndependientes = ind;
    Resultado = inv(coe) * ind; 
endfunction


/***
**Form of Equation Diferential
**   
**   p(x)y´´ + r(x)y = s(x)
**   
*/

function [MatrizCoeficientes, MatrizTIndependientes, Resultado] = diferenciasFinitasH(a, b, n)
    mprintf("\n");
    mprintf(rp("x") + "×y´´ + " + rr("x") + "×y = " + rs("x") + "\n");
    mprintf("\n");
    mprintf(rp("x_i") + "×(y_(i+1) - 2y_i + y_(i-1))/h² + " + ..
            rr("x_i") + "×y_i = " + rs("x_i") + ..
            ", \t por h² \n");
            
    mprintf(rp("x_i") + "×(y_(i+1) - 2y_i + y_(i-1)) + " + ..
            "h²" + rr("x_i") + "×y_i = h²(" + rs("x_i") + ")\n");
    
    mprintf("y_(i-1)("+rp("x_i")+") " + ..
            "+ y_i(-2("+rp("x_i")+") + h²("+rr("x_i")+")) " + ..
            "+ y_(i+1)("+rp("x_i")+") = h²(" + rs("x_i") + ")\n");
    
    mprintf("\n");
    mprintf(_s(a) + " <= x <= " + _s(b) + ",\t n = " + _s(n) + "\n");
    mprintf("y_0 = y(" + _s(a) + ") = " + _s(y0) + "\n");
    mprintf("y_ " + _s(n) + " = y(" + _s(a) + ") = " + _s(y_n) + "\n");
    
    h = (b - a)/n;    
    mprintf("\n");
    mprintf("h = (b - a)/n = (" + _s(b) + " - " + _s(a) + ")/" + _s(n) + " = " + _s(h) + "\n");
    
    x_n = [a, zeros(1, n - 1)];
    coe = zeros(n - 1, n - 1);
    ind = zeros(n - 1, 1);
    for i = 1 : n - 1
        
        mprintf("\n");
        mprintf("i = " + _s(i) + "\n");
        
        x_n(i + 1) = x_n(i) + h;
        x_i = x_n(i + 1);
        mprintf("x_" + _s(i) + " = " + _s(x_n(i)) + " + " + _s(h) + " = " + _s(x_i) + " \n");
        
        mprintf("y_"+_s(i-1)+"("+rp("x_"+_s(i))+") " + ..
        "+ y_"+_s(i)+"(-2("+rp("x_"+_s(i))+") + h²("+rr("x_"+_s(i))+")) " + ..
        "+ y_"+_s(i+1)+"("+rp("x_"+_s(i))+") = h²(" + rs("x_"+ _s(i)) + ")\n");  
         
        if i == 1 then
            
            y_a = y0*(p(x_i));
            y_b = (-2*p(x_i) + h^2*r(x_i));            
            y_c = (p(x_i));
            ins = h^2*s(x_i);
            
            coe(i, 1) = y_b;
            coe(i, 2) = y_c;
            ind(i) = ins - y_a;       
            
            mprintf(_s(y0)+"("+_s(p(x_i))+") " + ..
            "+ y_"+_s(i)+"(-2("+_s(p(x_i))+") + "+ _s(h) + "²("+_s(r(x_i))+")) " + ..
            "+ y_"+_s(i+1)+"("+_s(p(x_i))+") = "+ _s(h) + "²(" + _s(s(x_i)) + ")\n");   
            
            mprintf(_s(y_a) + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins) + "\n");   
            
            mprintf("y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins - y_a) + "\n");   
            
        elseif i == n - 1 then
            
            y_a = (p(x_i));
            y_b = (-2*p(x_i) + h^2*r(x_i));            
            y_c = yn*(p(x_i));
            ins = h^2*s(x_i);
            
            coe(i, i-1) = y_a;
            coe(i, i) = y_b
            ind(i) = ins - y_c;      
            
            mprintf("y_"+_s(i-1)+"("+_s(p(x_i))+") " + ..
            "+ y_"+_s(i)+"(-2("+_s(p(x_i))+") + "+ _s(h) + "²("+_s(r(x_i))+")) " + ..
            _s(yn)+"("+_s(p(x_i))+") = "+ _s(h) + "²(" + _s(s(x_i)) + ")\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            " + " + _s(y_c) + " = " + _s(ins) + "\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") = " + _s(ins - y_c) + "\n");    
            
        else
            
            y_a = (p(x_i));
            y_b = (-2*p(x_i) + h^2*r(x_i));            
            y_c = (p(x_i));
            ins = h^2*s(x_i);
            
            coe(i, i - 1) = y_a;
            coe(i, i) = y_b;
            coe(i, i + 1) = y_c;            
            ind(i) = ins;      
            
            mprintf("y_"+_s(i-1)+"("+_s(p(x_i))+") " + ..
            "+ y_"+_s(i)+"(-2("+_s(p(x_i))+") + "+ _s(h) + "²("+_s(r(x_i))+")) " + ..
            "+ y_"+_s(i+1)+"("+_s(p(x_i))+") = "+ _s(h) + "²(" + _s(s(x_i)) + ")\n");   
            
            mprintf("y_"+_s(i-1) + "(" + _s(y_a) + ") " + ..
            "+ y_"+_s(i)+"(" + _s(y_b) + ") " + ..
            "+ y_"+_s(i+1)+"(" + _s(y_c) + ") = " + _s(ins) + "\n");               
        end
    end
    MatrizCoeficientes = coe;
    MatrizTIndependientes = ind;
    Resultado = inv(coe) * ind;  
endfunction

function str = rp(xval)
    str = _r(px, xval);
endfunction

function str = rq(xval)
    str = _r(qx, xval);
endfunction

function str = rr(xval)
    str = _r(rx, xval);
endfunction

function str = rs(xval)
    str = _r(sx, xval);
endfunction

function str = _r(funs, val)
    funs = strsubst(funs,'x', '('+_s(val)+')');
    funs = strsubst(funs,'^2','²');
    funs = strsubst(funs,'^3','³');
    funs = strsubst(funs,'^4','⁴');
    funs = strsubst(funs,'^5','⁵');
    funs = strsubst(funs,'^6','⁶');
    funs = strsubst(funs,'sqrt','√');
    funs = strsubst(funs,'%e','e');
    funs = strsubst(funs,'%pi','π');
    funs = strsubst(funs,'log','ln');
    funs = strsubst(funs,'(x)','(' + _s(val) +')');
    funs = strsubst(funs,'(x)','x');
    funs = strsubst(funs,'(x_i)','x_i');
    
    funs = strsubst(funs,'(x_1)','x_1');
    funs = strsubst(funs,'(x_2)','x_2');
    funs = strsubst(funs,'(x_3)','x_3');
    funs = strsubst(funs,'(x_4)','x_4');
    funs = strsubst(funs,'(x_5)','x_5');
    funs = strsubst(funs,'(x_6)','x_6');
    funs = strsubst(funs,'(x_7)','x_7');
    
    funs = strsubst(funs,'*','×');
    funs = strsubst(funs,'absx', '|x|');
    funs = strsubst(funs,'abs(x²)', '|x²|');
    funs = strsubst(funs,'abs(x³)', '|x³|');
    funs = strsubst(funs,'abs(x⁴)', '|x⁴|');
    funs = strsubst(funs,'abs(x⁵)', '|x⁵|');
    funs = strsubst(funs,'abs(x⁶)', '|x⁶|');
    str = funs;
endfunction

function r = _s(a)
    r = string(a)
endfunction
