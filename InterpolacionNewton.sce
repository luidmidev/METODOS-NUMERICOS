function R = interpolacionNewton(xValues, yValues)
    x = xValues;
    y = yValues;
    if length(xValues) == length(xValues) then
        n = length(xValues);
        disp("Encontrar mediante interpolación de Newton, el polinomio"+ ..
        " que se ajuste a los puntos: ");
        data = [["x" st(xValues)]; ["y" st(yValues)]];
        disp(tablificar(data));
        
        disp("Resolución: ");
        
        a = zeros(n, n);
        a(:, 1) = y';
        
        c = string(a);
        aux = 0;
        for j = 1 : n
            for i = 1 : n - j
                a(i, j + 1) = (a(i + 1, j) - a(i, j))/(x(i + j) - x(i))
                str = "(" + st(a(i + 1, j)) + " - " + st(a(i, j)) +..
                 ")/(" + st(x(i + j)) + " - " + st(x(i)) + ") = " + st(a(i, j + 1));
                c(i, j + 1) = str;
            end
        end
                
        b = st(zeros(2 * n - 1, n + 1));
        
        for i = 1 : size(b)(1);
            for j = 1 : size(b)(2);
                b(i, j) = "";
            end
        end
        
        c = [st(x'), c]
        
        for j = 1 : 2
            for i = 1 : 2 : 2 * n - 1
                b(i, j) = c((i + 1)/2, j);                        
            end
        end
        
        for j = 3 : n + 1
            d = 1;
            for i = j - 1 : 2 : 2 * n - 1
                b(i, j) = c(d, j);      
                d = d + 1;                  
            end
        end    
        
        for i = 1 : size(b)(1);
            for j = 1 : size(b)(2);
                if b(i, j) == "0" then
                    b(i, j) = "";
                end
            end
        end 
         
        disp(tablificar(b));
        
        p = st(a(1, 1));
        p2 = "a0"
        xx = x*-1;
        
        i = 1
        for j = 2 : n
            signo = "";
            if a(i, j) >= 0
                signo = "+";
            end
            xt = "";
            xt2 = "";
            for i = 1 : j - 1
                signo2 = "";
                if xx(i) >= 0
                    signo2 = "+";
                end
                 xt = xt + "*(x" + signo2 + st(xx(i)) +")";
                 xt2 = xt2 + "*(x-x"+st(i - 1)+")"
            end
            p2 = p2 + "+a" + st(j - 1) + xt2;
            p = p + signo + st(a(1, j)) + xt;
        end
        disp("P = " + p2)
        disp("P = " + p);
        
        R = p;
        
    else
        disp("Los datos no son homogeneos");
    end
endfunction

function rs = lineDr(num)
    cadena = "";
    for i = 1 : num
        cadena = cadena + "─";
    end  
    rs = cadena;
endfunction

function tabla = tablificar(t)
    [n, m] = size(t);
    t = string(t);
    R = string(zeros(2 * n + 1, 2 * m + 1));
    
    R(1, 1) = "┌"
    R(2 * n + 1, 1) = "└"
    R(1, 2 * m + 1) = "┐"
    R(2 * n + 1, 2 * m + 1) = "┘"
    
    for i = 3 : 2 : 2 * n - 1
        R(i, 1) = "├";
    end
    for i = 3 : 2 : 2 * n - 1
        R(i, 2 * m + 1) = "┤";
    end
    for i = 3 : 2 : 2 * m - 1
        R(1, i) = "┬";
    end
    for i = 3 : 2 : 2 * m - 1
        R(2 * n + 1, i) = "┴";
    end
    for i = 2 : 2 : 2 * n 
        for j = 2 : 2 : 2 * m 
            R(i, j) = t(i/2, j/2);
        end
    end
    for i = 1 : 2 * n + 1
        if modulo(i, 2) == 0 then
            for j = 1 : 2 : 2 * m + 1
                R(i, j) = "│";
            end 
        end 
        if modulo(i, 2) == 1 then
            for j = 2 : 2 : 2 * m
                R(i, j) = "─";
            end
        end 
    end
    for i = 1 : n - 1
        for j = 1 : m - 1
            R(2 * i + 1, 2 * j + 1) = "┼"
        end
    end
    
    for j = 2 : 2 : 2 * m + 1
        auxA = 0;
        for i = 1 : 2 * n + 1
            aux = length(R(i, j));
            if aux > auxA then
                auxA = aux;
            end
        end
        for i = 1 : 2 : 2 * n + 1
            R(i, j) = lineDr(auxA);
        end
    end
    tabla = R;
endfunction

function a = st(b)
    a = string(b);
endfunction

