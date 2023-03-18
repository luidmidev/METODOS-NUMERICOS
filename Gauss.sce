function solucion = gauss(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            mAmp = [mCoe, mInd];
            for X = 1 : n - 1
                text = string(zeros(n, n + 3));
                for Y = 1 : X
                    line = ["|", mfrc(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", mfrc(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + frc(mAmp(Y, X)) + " / " + frc(mAmp(X, X)) + " )"]
                    text(Y, :) = line; 
                end
                sep = string(zeros(n, 1));
                for i = 1 : n
                    sep(i, 1) = "|";
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)]
                disp(text)
                for Y = X + 1 : n
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X))
                    
                end
                for i = 1 : n
                    for j = 1 : n + 1
                        if mAmp(i, j) > -0.00000001 & mAmp(i, j) < 0.00000001 then
                            mAmp(i, j) = 0;
                        end       
                    end
                end
                disp("Iteración: " + string(X))
            end
            text = string(zeros(n, n + 3));
            for Y = 1 : n
                    line = ["|", mfrc(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
            end
            text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)]
            disp(text)
            
            sol = zeros(n, 1);
            
            for i = n:-1:1
                sol(i) = mAmp(i, n + 1);
                ig3 = frc(sol(i));
                ig2 = frc(sol(i));
                ig1 = "(" + frc(mAmp(i, i)) + ")*x" + string(i);
                for j = i + 1:n
                    sol(i) = sol(i) - sol(j) * mAmp(i, j);
                    ig1 = ig1 + " + (" + frc(sol(j)) + ")*(" + frc(mAmp(i, j)) + ")"
                    ig2 = ig2 + " - (" + frc(sol(j)) + ")*(" + frc(mAmp(i, j)) + ")"
                end
                ig = ig1 + " = " + ig3;
                disp("")
                disp(ig);
                sol(i) = sol(i) / mAmp(i, i);
                disp("x" + string(i) + " = (" +  ig2 + ")/(" + frc(mAmp(i, i)) + ") = " + frc(sol(i)));
            end
            ab = string(sol);
            sol = strtod(ab);
            solucion = sol;
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
