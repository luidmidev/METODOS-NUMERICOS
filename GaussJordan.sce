function solucion = gaussJordan(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            mAmp = [mCoe, mInd];
            sep = string(zeros(n, 1));
            for i = 1 : n
                sep(i, 1) = "|";
            end
            for X = 1 : n - 1
                text = string(zeros(n, n + 3));
                for Y = 1 : X
                    line = ["|", mfrc(mAmp(Y, :)), "|"];
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", mfrc(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + frc(mAmp(Y, X)) + " / " + frc(mAmp(X, X)) + " )"];
                    text(Y, :) = line; 
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)];
                disp(text)
                for Y = X + 1 : n
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                   
                end
                disp("Iteración: " + string(X))
            end

            count = X;
            for X = n : -1 :2
                text = string(zeros(n, n + 3));
                for Y = 1 : X - 1
                    line = ["|", mfrc(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +..
                    " * ( " + frc(mAmp(Y, X)) + " / " + frc(mAmp(X, X)) + " )"];
                    text(Y, :) = line; 
                end 
                for Y = X : n
                    line = ["|", mfrc(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)];
                disp(text);
                for Y = 1 : X - 1
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));          
                end
                count = count + 1;
                disp("Iteración: " + string(count));         
            end 
            
            text = string(zeros(n, n + 3));
            for Y = 1 : n
                line = ["|", mfrc(mAmp(Y, :)), "|"]
                text(Y, :) = line; 
            end
            text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)];
            disp(text); 
            
            sol = zeros(n, 1);
            for i = 1 : n
                sol(i) = mAmp(i, n + 1) / mAmp(i, i)
                text = "(" + frc(mAmp(i, i)) + ")*x" + string(i) + " = " + frc(mAmp(i, n + 1)) + " --> " +..
                "x" + string(i) + " = (" + frc(mAmp(i, n + 1)) + ")/(" + frc(mAmp(i, i)) + ") = " +..
                string(sol(i));
                disp("");
                disp(text);
            end
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
endfunction

function [solucion, iteraciones, variables] = gaussJordan2(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            mAmp = [mCoe, mInd];       
            //Este bucle es ele encargado de generar la matriz traingular superior    
            for X = 1 : n - 1
                for Y = X + 1 : n
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                   
                end
            end
            count = X;
            //Este bucle es ele encargado de generar la matriz traingular inferior     
            for X = n : -1 : 2                
                for Y = 1 : X - 1
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));          
                end
                count = count + 1;       
            end             
            sol = zeros(n, 1);
            sol_text = string(zeros(n, 1));
            //Este bucle es el encargado de realziar el despeje final para obtener la solucion
            for i = 1 : n
                sol(i) = mAmp(i, n + 1) / mAmp(i, i)
                sol_text(i) = "x_" + string(i);
            end
            solucion = sol;
            iteraciones = count;
            variables = sol_text
            
        else
            disp("El elemento a11 no debe ser cero");
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
