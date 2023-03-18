function solucion = gaussSeidel(coe, ind, errarg)
    if  size(coe, 1) == size(coe, 2) then
        if size(coe, 1) == size(ind, 1) then
            if verificarDiagonalDominante(coe) then
                n = size(coe, 1);
                xs = string(zeros(n, 1));
                rs = string(zeros(n, 1));
                for i = 1 : n
                    xs(i, 1) = "x" + string(i);
                end
                valuesx = strtod(x_mdialog('Ingrese los valores inciales de sus variables', xs, rs));
                sol = zeros(n, 1);
                amp = [coe, ind];
                err = 100;
                rep = 1;
                while err > errarg then
                    disp("Iteracion " + string(rep));
                    rep = rep + 1;
                    aux = valuesx(1, 1)
                    for i = 1 : n
                        sol(i, 1) = amp(i, n + 1);
                        text = string(amp(i, n + 1));
                        for j = 1 : n
                            if j <> i then
                                sol(i, 1) = sol(i, 1) - amp(i, j) * valuesx(j, 1);
                                text = text + " - ("  + string(amp(i, j)) + ")*(" + string(valuesx(j, 1)) + ")";
                            end
                        end
                        sol(i, 1) = sol(i, 1) / amp(i, i);
                        valuesx(i, 1) = sol(i, 1);
                        rtext = "x" + string(i) + " = (" + text + ")/(" + string(amp(i, i)) + ") = " + string(sol(i, 1));
                        disp(rtext);
                    end
                    err = abs((valuesx(1, 1) - aux)/valuesx(1, 1)) * 100;
                    errtext = "Er = |" + string(valuesx(1, 1)) + " - " + string(aux) + "|/|" + string(valuesx(1, 1)) +...
                    "| * 100 = " + string(err);
                    disp(errtext)
                end
                disp(frc(sol))
                solucion = sol;
            else
                messagebox("La diagonal principal de la matriz no es dominante", "Error");
            end
        else
            messagebox("La matriz de coeficientes no coincide con la matriz de terminos independientes", "Error")
        end
    else
        messagebox("La matriz de coeficientes debe ser cuadrada.", "Error")
    end
endfunction

function bool = verificarDiagonalDominante(matriz)
    ver = %F
    for i = 1 : size(matriz, 1)
        suma = 0;
        for j = 1 : size(matriz, 2)
            if  j <> i then
                suma = suma + abs(matriz(i, j));
            end            
        end
        if abs(matriz(i, i)) > suma then
            ver = %T;
        else
            ver = %F;
            break
        end
    end
    bool = ver;
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
