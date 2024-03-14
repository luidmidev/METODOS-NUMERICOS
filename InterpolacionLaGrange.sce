function R =interpolacionLagrange(xValues, yValues)
    //$L_k\left(x\right)=\dfrac{\prod_{i=1;i\neq k}^{n}\left(x-x_{i}\right)}{\prod_{i=1;i\neq k}^{n}\left x_k-x_i\right)}$
    //$p\left(x\right)=\sum_{k=1}^{n}y_kL_k(x)$
    //donde k es el polinomio que se quiere encontrar y p(x) es el polinomio de
    // grado n-1 que contiene a todos los x1,x2, ..., xn
    format(8);
    x = poly(0, "x");
    disp(x)
    
    plot(xValues, yValues, "r*");
    gca().grid=[1 1 1];
    
    if length(xValues) == length(xValues) then
        disp("Encontrar el polinomio de interpolación de Lagrange de los siguientes datos: ");
        data = [["x" string(xValues)]; ["y" string(yValues)]];
        disp(make_table(data));
        len = length(xValues);
        /////////////////////////////////////////////
        //Armamos los polinimios a ser implementados
        /////////////////////////////////////////////
        polyStr = string(zeros(3, len)); 
        for i = 1 : prod(size(polyStr));
            polyStr(i) = "";
        end
        
        polonimios = zeros(1, len); ///
        pols = [] ///
        for i = 1 : len ///
            pols = [pols, x - xValues(i)] ///

        end
                    disp(pols)
                    
        for k = 1 : len
            disp("k = " + string(k));
            polRstr = string(zeros(3, 5));
            for i = 1 : prod(size(polRstr));
                polRstr(i) = "";
            end
            polRstr(2, 1) = " L" + string(k) + "(x) ";
            polRstr(2, 2) = " = ";
            polRstr(2, 4) = " = ";
            pnum = ""
            pden = ""
            rPol = 1;
            rDen = 1;
            
            for i = 1: len ///
                if i <> k then ///
                    rPol = rPol * pols(i);///
                    rDen = rDen * (xValues(k) - xValues(i));///
                    pnum = pnum + "(" + string(pols(i)) + ")";
                    pden = pden + "(" + string(xValues(k)) + " - (" + string(xValues(i)) + "))";
                end
            end
            
            if length(pnum) >= length(pden) then
                polRstr(2, 3) = make_line(pnum);
            else
                polRstr(2, 3) = make_line(pden);
            end
            
            polRstr(1, 3) = pnum;
            polRstr(3, 3) = pden;
            polRstr(1, 5) = string(rPol);
            polRstr(2, 5) = make_line(string(rPol));
            polRstr(3, 5) = string(rDen);
            
            disp(polRstr);
            
            polyStr(1, k) = string(rPol);
            polyStr(2, k) = make_line(string(rPol));
            polyStr(3, k) = string(rDen);
            
            polinomios(1, k) = rPol/rDen; ///
        end

        pStr = "p(x) = y1L1(x) ";
        for i = 2 : len
            pStr = pStr  + " + y" + string(i) + "L" + string(i) + "(x)";
        end
        disp(pStr);
        
        pStr = "p(x) = " + string(yValues(1)) + "L1(x) ";
        for i = 2 : len
            pStr = pStr  + " + (" + string(yValues(i)) + ")" + "L" + string(i) + "(x)";
        end
        disp(pStr);
        
        polyR = 0; ///
        for i = 1 : len ///
            polyR = polyR + yValues(i)*polinomios(1, i); ///
        end
        
        disp("P(x) = " + string(polyR));
        
        R = polyR; ///
    else
        disp("Los datos no son homogeneos")
    end
endfunction

function rs = make_line(str)
    cadena = "";
    for i = 1 : length(str)
        cadena = cadena + "─";
    end  
    rs = cadena;
endfunction

function rs = lineDr(num)
    cadena = "";
    for i = 1 : num
        cadena = cadena + "─";
    end  
    rs = cadena;
endfunction

function tabla = make_table(t)
    
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
            R(i, j) = make_line(auxA);
        end
    end
    tabla = R;
endfunction
