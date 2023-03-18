function solucion = LU(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            m = mCoe;
            id = eye(n, n);
            for X = 1 : n - 1
                text = string(zeros(n, n + 2));
                for Y = 1 : X
                    line = ["|", mfrc(m(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", mfrc(m(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + frc(m(Y, X)) + " / " + frc(m(X, X)) + " )"]
                    text(Y, :) = line; 
                end
                disp(text)
                for Y = X + 1 : n
                    id(Y, X) = (m(Y, X) / m(X, X));
                    m(Y, :) = m(Y, :) - m(X, :) * (m(Y, X) / m(X, X));
                end
                for i = 1 : n
                    for j = 1 : n
                        if m(i, j) > -0.00000001 & m(i, j) < 0.00000001 then
                            m(i, j) = 0;
                        end       
                    end
                end
                disp("Iteración: " + string(X))
            end
            text = string(zeros(n, n + 2));
            for Y = 1 : n
                    line = ["|", mfrc(m(Y, :)), "|"]
                    text(Y, :) = line; 
            end
            disp(text);
            disp("Matriz LU");
            disp(mfrc(id));
            disp("Sistema de ecuaciones con el coeficiente de reducción:");
            for i = 1 : n
                cadena = "";
                for j = 1 : i
                    if j == 1 then
                        cadena = cadena + "(" + frc(id(i, j)) + ")*a" + string(j); 
                    else
                        cadena = cadena + " + (" + frc(id(i, j)) + ")*a" + string(j);
                    end  
                end
                cadena = cadena + " = " + frc(mInd(i, 1));
                disp(cadena);
            end
            disp("Solución del sistema con coeficientes de reducción: ")
            sol = zeros(n, 1);
            for i = 1:n
                sol(i) = mInd(i, 1)
                eq1 = "a" + string(i);
                eq2 = frc(mInd(i, 1));
                for j = 1: i - 1
                    sol(i) = sol(i) - sol(j) * id(i, j);
                    eq2 = eq2 + " - (" + frc(sol(j)) + ")*(" + frc(id(i, j)) + ")";
                end
                r = eq1 + " = " + eq2 + " = " + frc(sol(i));
                disp(r)
            end
            
            disp("Formar el sistema de ecuaciones con el último paso del método de Gauss");    
            
            for i =1:n
                cadena = "";
                for j = i:n
                    if j == i then
                        cadena = cadena + "(" + frc(m(i, j)) + ")*x" + string(j); 
                    else
                        cadena = cadena + " + (" + frc(m(i, j)) + ")*x" + string(j);
                    end
                end
                cadena = cadena + " = a" + string(i);
                disp(cadena);
            end
            disp("")
            for i =1:n
                cadena = "";
                for j = i:n
                    if j == i then
                        cadena = cadena + "(" + frc(m(i, j)) + ")*x" + string(j); 
                    else
                        cadena = cadena + " + (" + frc(m(i, j)) + ")*x" + string(j);
                    end
                end
                cadena = cadena + " = " + frc(sol(i, 1));
                disp(cadena)
            end
            
            disp("Solución final del sistema: ")
            sol2 = zeros(n, 1);
            for i = n:-1:1
                sol2(i) = sol(i, 1)
                eq = frc(sol2(i, 1));
                for j = i + 1:n
                    sol2(i) = sol2(i) - sol2(j) * m(i, j);
                    eq = eq + " - (" + frc(sol2(j)) + ")*(" + frc(m(i, j)) + ")"
                end
                sol2(i) = sol2(i) / m(i, i);
                r = "x" + string(i) + " = (" + eq + ")/(" + frc(m(i, i)) + ") = " + frc(sol2(i))
                disp(r)
            end
            ab = string(sol2);
            sol2 = strtod(ab);
            solucion = sol2;
        else
            disp("El elemento a11 no debe ser cero")
        end
    else 
        disp("La matriz de coeficiente no es cuadrada");
        solucion = null;
    end
endfunction

function y = frc(n)
    [num, den] = rat(n)
    if den == 1 then
        y = string(n)
    else
        y = string(num) + "/" + string(den);
    end
endfunction

function y = mfrc(n)
    [num,den] = rat(n)
    [t1, t2] = size(n)
    text = string(zeros(t1, t2));
    for i = 1 : t1
        for j = 1 : t2
            text(i, j) = frc(n(i, j))
        end
    end
    y = text
endfunction
