function solucion = mInversa(mCoe, mInd)
    [n, m] = size(mCoe)
    if size(mInd)(1) == n then
        if n == m  then
            if mCoe(1, 1) <> 0 then
                mAmp = [mCoe, eye(n, n)];
                sep = string(zeros(n, 1));
                for i = 1 : n
                    sep(i, 1) = "|";
                end
                
                for X = 1 : n - 1
                    
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : n
                        line = ["|", mfrc(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    if X == 1 & mAmp(1, 1) <> 1 then
                        line = ["|", mfrc(mAmp(X, :)), "| f" + string(X) + " * ( 1 / " +..
                        frc(mAmp(X, X)) + " )"];
                        text(X, :) = line; 
                        text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                        disp("");             
                        disp(text);    
                        disp("");               
                        mAmp(X, :) = mAmp(X, :) * (1 / mAmp(X, X));
                    end                
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : X
                        line = ["|", mfrc(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    for Y = X + 1 : n
                        line = ["|", mfrc(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                        " * ( " + frc(mAmp(Y, X)) + " / " + frc(mAmp(X, X)) + " )"];
                        text(Y, :) = line; 
                    end
                    text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                    disp(text)
                    for Y = X + 1 : n
                        mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                   
                    end
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : n
                        line = ["|", mfrc(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    if X + 1 <= n then
                        line = ["|", mfrc(mAmp(X + 1, :)), "| f" + string(X + 1) + " * ( 1 / " +..
                        frc(mAmp(X + 1, X + 1)) + " )"];
                        text(X + 1, :) = line; 
                        text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                        disp("");             
                        disp(text);                   
                        mAmp(X + 1, :) = mAmp(X + 1, :) * (1 / mAmp(X + 1, X + 1));
                    end                
                    disp("");
                end
                for X = n : -1 :2
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : X - 1
                        line = ["|", mfrc(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                        " * ( " + frc(mAmp(Y, X)) + " / " + frc(mAmp(X, X)) + " )"];
                        text(Y, :) = line; 
                    end 
                    for Y = X : n
                        line = ["|", mfrc(mAmp(Y, :)), "|"]
                        text(Y, :) = line; 
                    end
                    text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                    disp(text);
                    for Y = 1 : X - 1
                        mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                  
                    end
                    for i = 1 : n
                        for j = 1 : n + 1
                            if mAmp(i, j) > -0.000000001 & mAmp(i, j) < 0.000000001 then
                                mAmp(i, j) = 0;
                            end       
                        end
                    end
                    disp("");         
                end 
                text = string(zeros(n, 2 * n + 2));
                for Y = 1 : n
                    line = ["|", mfrc(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                disp(text); 
                disp("");
                
                inversa = mAmp(:, n + 1 : 2 * n)
                
                disp("Matriz inversa: ");
                disp(mfrc(inversa));
                disp("Matriz de terminos independientes: ");
                disp(mfrc(mInd));
                disp("Solución: ");
                sol = inversa * mInd;
                for i = 1 : n
                    if sol(i, 1) > -0.000000001 & sol(i, 1) < 0.000000001 then
                        sol(i, 1) = 0;
                    end       
                end
                et = string(zeros(n, 1))
                for i = 1 : n
                    et(i, 1) = "x" + string(i) + " = ";
                end
                disp([et, mfrc(sol)]);
                ab = string(sol);
                sol = strtod(ab);
                solucion = sol;
            else
                disp("El elemento a11 no debe ser cero");
            end
        else 
            disp("La matriz de coeficiente no es cuadrada");
            solucion = null;
        end 
    else
        disp("La dimensión de la matriz de terminos independientes no coincide con la matriz de coeficientes");
        solucion = null
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
