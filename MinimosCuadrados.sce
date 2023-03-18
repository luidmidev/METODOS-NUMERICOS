function regresionLineal(xValues, yValues)
    
    plot(xValues, yValues, "r*");
    gca().grid=[1 1 1];
    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión lineal de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));
        
        table = string(zeros(n + 2, 6));
        table(1, :) = ["n" "x" "y" "xy" "x²" "yteo"];  //Etiqueta
        
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(xValues(i) * yValues(i));
            table(i + 1, 5) = string(xValues(i) ^ 2);
        end
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(xValues .* yValues));
        table(n + 2, 5) = string(sum(xValues .^ 2));
        table(n + 2, 1) = "SUM"
        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumxy = string(sum(xValues .* yValues));
        sumxx = string(sum(xValues .^ 2));
        
        A = [n strtod(sumx); strtod(sumx) strtod(sumxx)];
        B = [strtod(sumy); strtod(sumxy)];
        
        sol = inv(A)*B;
        Yt = sol(1) + sol(2)*xValues;
        
        for i = 1: n
            table(i + 1, 6) = string(Yt(i));
        end
        
        table(n + 2, 6) = "--";
        disp(tablificar(table));
        
        disp("Resolución");
        disp("  n×a1 + a2×Σx = Σy");
        disp("  a1×Σx + a2×Σx² = Σyx");
        disp("");
        
        disp("  " + string(n) + "×a1 + a2×" + sumx + " = " + sumy);
        disp("  a1×" + sumx + " + a2×" + sumxx + " = " + sumxy);
        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
            disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        disp("El sistema buscado es: ");
        disp("y = " + string(sol(1)) + " + " + string(sol(2)) + "×x")
        rango = min(xValues - 0.2): 0.01 : max(xValues + 0.2);
        ygrf = sol(1) + sol(2)*rango;
        plot(rango, ygrf, "b");
        gca().grid=[1 1 1];
    else
       disp("Numero de datos no homogeneos")
    end
endfunction

function regresionSeno(xValues, yValues)
    
    plot(xValues, yValues, "r*");
    gca().grid=[1 1 1];
    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión lineal de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));
        
        table = string(zeros(n + 2, 7));
        table(1, :) = ["n" "x" "y" "sen(x)" "sen(x)²" "y*sen(x)" "yteo"];  //Etiqueta
        
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(sin(xValues(i)));
            table(i + 1, 5) = string(sin(xValues(i))^2);
            table(i + 1, 6) = string(yValues(i)*sin(xValues(i)));
        end
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(sin(xValues)));
        table(n + 2, 5) = string(sum(sin(xValues) .^ 2));
        table(n + 2, 6) = string(sum(yValues .* sin(xValues)));
        table(n + 2, 1) = "SUM"
        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumxy = string(sum(xValues .* yValues));
        sumxx = string(sum(xValues .^ 2));
        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumsinx = string(sum(sin(xValues)));
        sumsinx2 = string(sum(sin(xValues) .^ 2));
        sumysinx = string(sum(yValues .* sin(xValues)));        
        
        A = [n strtod(sumsinx);
             strtod(sumsinx) strtod(sumsinx2)];
        B = [strtod(sumy); strtod(sumysinx)];
        
        sol = inv(A)*B;
        Yt = sol(1) + sol(2) .* sin(xValues);
        
        for i = 1: n
            table(i + 1, 7) = string(Yt(i));
        end
        
        table(n + 2, 7) = "--";
        disp(tablificar(table));
        
        disp("Resolución");
        disp("  n×a1 + a2×Σsen(x) = Σy");
        disp("  a1×Σsen(x) + a2×Σsen(x)² = Σysen(x)");
        disp("");
        
        disp("  " + string(n) + "×a1 + a2×" + sumsinx + " = " + sumy);
        disp("  a1×" + sumsinx + " + a2×" + sumsinx2 + " = " + sumysenx);
        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
            disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        disp("El sistema buscado es: ");
        disp("y = " + string(sol(1)) + " + " + string(sol(2)) + "×sen(x)");
        rango = min(xValues - 0.2): 0.01 : max(xValues + 0.2);
        ygrf = sol(1) + sol(2)*rango;
        plot(rango, ygrf, "b");
        gca().grid=[1 1 1];
    else
       disp("Numero de datos no homogeneos")
    end
endfunction

function regresionExponencial(xValues, yValues)
    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión exponencial de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));
        
        table = string(zeros(n + 2, 7));
        table(1, :) = ["n" "x" "y" "ln(y)" "xln(y)" "x²" "yteo"];  //Etiqueta
        
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(log(yValues(i)));
            table(i + 1, 5) = string(xValues(i) * log(yValues(i)));
            table(i + 1, 6) = string(xValues(i) ^ 2);
        end
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(log(yValues)));
        table(n + 2, 5) = string(sum(xValues .* log(yValues)));
        table(n + 2, 6) = string(sum(xValues .^ 2));
        table(n + 2, 1) = "SUM"
        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumlny = string(sum(log(yValues)));
        sumxlny = string(sum(xValues .* log(yValues)));
        sumxx = string(sum(xValues .^ 2));
        
        A = [n strtod(sumx); 
             strtod(sumx) strtod(sumxx)];
        
        B = [strtod(sumlny);
            strtod(sumxlny)];
            
        sol = inv(A)*B;
        Yt = %e^sol(1) .*(%e.^sol(2)).^xValues;
        
        for i = 1: n
            table(i + 1, 7) = string(Yt(i));
        end
        
        table(n + 2, 7) = "--";
        disp(tablificar(table));
        
        disp("Resolución");
        disp("  n×ln(a1) + ln(a2)×Σx = Σln(y)");
        disp("  ln(a1)×Σx + ln(a2)×Σx² = Σy×ln(x)");
        disp("");
        
        disp("  " + string(n) + "×ln(a1) + ln(a2)×" + sumx + " = " + sumlny);
        disp("  ln(a1)×" + sumx + " + ln(a2)×" + sumxx + " = " + sumxlny);
        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
            disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        
        disp("El sistema buscado es: ");
        disp("ln(a1) = " + string(sol(1)) + " --> a1 = e^(" + string(sol(1)) + ") =" + string(%e^sol(1)));
        disp("ln(a2) = " + string(sol(2)) + " --> a2 = e^(" + string(sol(2)) + ") =" + string(%e^sol(2)));
        
        disp("y = " + string(%e^sol(1)) + "(" + string(%e^sol(2)) + ")^x")

        rango = min(xValues - 0.2): 0.01 : max(xValues + 0.2);
        ygrf = sol(1) + sol(2)*rango;
        plot(rango, ygrf, "b");
        gca().grid=[1 1 1];
    else
       disp("Numero de datos no homogeneos")
    end
endfunction


function regresionPotencial(xValues, yValues)
    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión exponencial de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));
        
        table = string(zeros(n + 2, 8));
        table(1, :) = ["n" "x" "y" "ln(y)" "ln(x)" "ln(x)ln(y)" "(ln(x))²" "yteo"];  //Etiqueta
        
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(log(yValues(i)));
            table(i + 1, 5) = string(log(xValues(i)));
            table(i + 1, 6) = string(log(yValues(i) .* log(xValues(i))));
            table(i + 1, 7) = string(log(xValues(i)) .^ 2)
        end
        
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(log(yValues)));
        table(n + 2, 5) = string(sum(log(xValues)));
        table(n + 2, 6) = string(sum(log(xValues) .* log(yValues)));
        table(n + 2, 7) = string(sum(log(xValues) .^ 2));
        table(n + 2, 1) = "SUM"
        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumlny = string(sum(log(yValues)));
        sumlnx = string(sum(log(xValues)));
        sumlnxlny = string(sum(log(xValues) .* log(yValues)));
        sumlnxlnx = string(sum(log(xValues) .^ 2));
        
        A = [n strtod(sumlnx); 
             strtod(sumlnx) strtod(sumlnxlnx)];
        
        B = [strtod(sumlny);
            strtod(sumlnxlny)];
            
        sol = inv(A)*B;
        Yt = %e^sol(1) .*(xValues.^sol(2));
        
        for i = 1: n
            table(i + 1, 8) = string(Yt(i));
        end
        
        table(n + 2, 8) = "--";
        disp(tablificar(table));
        
        disp("Resolución");
        disp("  n×ln(a1) + a2×Σln(x) = Σln(y)");
        disp("  ln(a1)×Σln(x) + a2×Σ(ln(x))² = Σln(x)ln(y)");
        disp("");
        
        disp("  " + string(n) + "×ln(a1) + a2×" + sumlnx + " = " + sumlny);
        disp("  ln(a1)×" + sumlnx + " + a2×" + sumlnxlnx + " = " + sumlnxlny);
        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
             disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        
        disp("El sistema buscado es: ");
        disp("ln(a1) = " + string(sol(1)) + " --> a1 = e^(" + string(sol(1)) + ") =" + string(%e^sol(1)));
        
        disp("y = " + string(%e^sol(1)) + "(x^" + string(sol(2)) + ")")
    else
       disp("Numero de datos no homogeneos")
    end
endfunction


function regresionCuadratica(xValues, yValues)    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión cuadratico de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));
        table = string(zeros(n + 2, 9));
        table(1, :) = ["n" "x" "y" "xy" "x²" "x²y" "x³" "x⁴" "yteo"];  //Etiqueta
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(xValues(i) * yValues(i));
            table(i + 1, 5) = string(xValues(i) ^ 2);
            table(i + 1, 6) = string(xValues(i) ^ 2 * yValues(i));
            table(i + 1, 7) = string(xValues(i) ^ 3);
            table(i + 1, 8) = string(xValues(i) ^ 4);
        end
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(xValues .* yValues));
        table(n + 2, 5) = string(sum(xValues .^ 2));
        table(n + 2, 6) = string(sum(xValues .^ 2 .* yValues));
        table(n + 2, 7) = string(sum(xValues .^ 3));
        table(n + 2, 8) = string(sum(xValues .^ 4));
        table(n + 2, 1) = "SUM"
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumxy = string(sum(xValues .* yValues));
        sumxx = string(sum(xValues .^ 2));
        sumxxy = string(sum(xValues .^ 2 .* yValues));
        sumxxx = string(sum(xValues .^ 3));
        sumxxxx = string(sum(xValues .^ 4));
        A = [n strtod(sumx) strtod(sumxx);
             strtod(sumx) strtod(sumxx) strtod(sumxxx);
             strtod(sumxx) strtod(sumxxx) strtod(sumxxxx)];
        B = [strtod(sumy); 
             strtod(sumxy);
             strtod(sumxxy)];
        sol = inv(A) * B;
        Yt = sol(1) + sol(2) .* xValues + sol(3) .* xValues .^ 2;
        for i = 1: n
            table(i + 1, 9) = string(Yt(i));
        end
        table(n + 2, 9) = "--";
        disp(tablificar(table));        
        disp("Resolución");
        disp("  n×a1 + a2×Σx + a3×Σx² = Σy");
        disp("  a1×Σx + a2×Σx² + a3×Σx³ = Σyx");
        disp("  a1×Σx² + a2×Σx³ + a3×Σx⁴ = Σyx²");
        disp("");        
        disp("  " + string(n) + "×a1 + a2×" + sumx + " +a3×" + sumxx + " = " + sumy);
        disp("  a1×" + sumx + " + a2×" + sumxx + " +a3×" + sumxxx + " = " + sumxy);
        disp("  a1×" + sumxx + " + a2×" + sumxxx + " +a3×" + sumxxxx + " = " + sumxxy);        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
             disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        disp("El sistema buscado es: ");        
        disp("y = " + string(sol(1)) + " + " + string(sol(2)) + "×x + " + string(sol(3)) + "×x²")        
    else
       disp("Numero de datos no homogeneos");
    end
endfunction

function regresionCubica(xValues, yValues)    
    if length(xValues) == length(xValues) then
        n = length(xValues)
        disp("Encontrar un modelo  de regresión cuadratico de los siguientes puntos: ");
        data = [["x"; "_"; string(xValues')], ["y"; "_"; string(yValues')]];
        disp(tablificar(data));        
        table = string(zeros(n + 2, 12));
        table(1, :) = ["n" "x" "y" "xy" "x²" "x²y" "x³" "x³y" "x⁴" "x⁵" "x⁶" "yteo"];  //Etiqueta        
        for i = 1: n
            table(i + 1, 1) = string(i);
            table(i + 1, 2) = string(xValues(i));
            table(i + 1, 3) = string(yValues(i));
            table(i + 1, 4) = string(xValues(i) * yValues(i));
            table(i + 1, 5) = string(xValues(i) ^ 2);
            table(i + 1, 6) = string(xValues(i) ^ 2 * yValues(i));
            table(i + 1, 7) = string(xValues(i) ^ 3);
            table(i + 1, 8) = string(xValues(i) ^ 3 * yValues(i));
            table(i + 1, 9) = string(xValues(i) ^ 4);
            table(i + 1, 10) = string(xValues(i) ^ 5);
            table(i + 1, 11) = string(xValues(i) ^ 5);
        end        
        table(n + 2, 2) = string(sum(xValues));
        table(n + 2, 3) = string(sum(yValues));
        table(n + 2, 4) = string(sum(xValues .* yValues));
        table(n + 2, 5) = string(sum(xValues .^ 2));
        table(n + 2, 6) = string(sum(xValues .^ 2 .* yValues));
        table(n + 2, 7) = string(sum(xValues .^ 3));
        table(n + 2, 8) = string(sum(xValues .^ 3 .* yValues));
        table(n + 2, 9) = string(sum(xValues .^ 4));
        table(n + 2, 10) = string(sum(xValues .^ 5));
        table(n + 2, 11) = string(sum(xValues .^ 6));
        table(n + 2, 1) = "SUM"        
        sumx = string(sum(xValues));
        sumy = string(sum(yValues));
        sumxy = string(sum(xValues .* yValues));
        sumxx = string(sum(xValues .^ 2));
        sumxxy = string(sum(xValues .^ 2 .* yValues));
        sumxxx = string(sum(xValues .^ 3));
        sumxxxy = string(sum(xValues .^ 3 .* yValues));
        sumxxxx = string(sum(xValues .^ 4));
        sumxxxxx = string(sum(xValues .^ 5));
        sumxxxxxx = string(sum(xValues .^ 6));        
        A = [n strtod(sumx) strtod(sumxx) strtod(sumxxx);
             strtod(sumx) strtod(sumxx) strtod(sumxxx) strtod(sumxxxx);
             strtod(sumxx) strtod(sumxxx) strtod(sumxxxx) strtod(sumxxxxx)
             strtod(sumxxx) strtod(sumxxxx) strtod(sumxxxxx) strtod(sumxxxxxx)];        
        B = [strtod(sumy); 
             strtod(sumxy);
             strtod(sumxxy)
             strtod(sumxxxy)];        
        sol = inv(A)*B;
        Yt = sol(1) + sol(2) .* xValues + sol(3) .* xValues.^2 + sol(4) .* xValues.^3;        
        for i = 1: n
            table(i + 1, 12) = string(Yt(i));
        end        
        table(n + 2, 12) = "--";
        disp(tablificar(table));        
        disp("Resolución");        
        disp("  n×a1 + a2×Σx + a3×Σx² + a4×Σx³ = Σy");
        disp("  a1×Σx + a2×Σx² + a3×Σx³ + a4×Σx⁴ = Σyx");
        disp("  a1×Σx² + a2×Σx³ + a3×Σx⁴ + a4×Σx⁵ = Σyx²");
        disp("  a1×Σx³ + a2×Σx⁴ + a3×Σx⁵ + a3×Σx⁶ = Σyx³");
        disp("");        
        disp("  " + string(n)+"×a1 + a2×"+sumx+" +a3×"+sumxx+"a4×"+sumxxx+" = " + sumy);
        disp("  a1×"+sumx+" + a2×"+sumxx+" +a3×"+sumxxx+"a4×"+sumxxxx+" = " + sumxy);
        disp("  a1×"+sumxx+" + a2×"+sumxxx+" +a3×"+sumxxxx+"a4×"+sumxxxxx+" = " + sumxxy);
        disp("  a1×"+sumxxx+" + a2×"+sumxxxx+" +a3×"+sumxxxxx +"a4×"+sumxxxxxx+ " = " + sumxxy);        
        disp("");
        disp("Qué metodo desea emplear para la solución: ");
        disp("  1. Gauss");
        disp("  2. GaussJordan");
        disp("  3. Matriz Inversa");
        disp("  4. LU");
        met = input("   Metodo: ");
        select met
        case 1 then
            gauss(A, B);
        case 2 then
            gaussJordan(A, B);
        case 3 then
            mInversa(A, B);
        case 4 then
            LU(A, B);
        else
             disp("Selección invalida, se usará Gauss Jordan")
            gaussJordan(A, B);
        end
        disp("El sistema buscado es: ");        
        disp("y = " + string(sol(1)) + " + " + string(sol(2)) + "×x" + string(sol(3)) + "×x²")
    else
       disp("Numero de datos no homogeneos")
    end
endfunction


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
                    line = ["|", string(mAmp(Y, :)), "|"];
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", string(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + string(mAmp(Y, X)) + " / " + string(mAmp(X, X)) + " )"];
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
                    line = ["|", string(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +..
                    " * ( " + string(mAmp(Y, X)) + " / " + string(mAmp(X, X)) + " )"];
                    text(Y, :) = line; 
                end 
                for Y = X : n
                    line = ["|", string(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)];
                disp(text);
                for Y = 1 : X - 1
                    mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                  
                end
                for i = 1 : n
                    for j = 1 : n + 1
                        if mAmp(i, j) > -0.00000001 & mAmp(i, j) < 0.00000001 then
                            mAmp(i, j) = 0;
                        end       
                    end
                end
                count = count + 1;
                disp("Iteración: " + string(count));         
            end 
            
            text = string(zeros(n, n + 3));
            for Y = 1 : n
                line = ["|", string(mAmp(Y, :)), "|"]
                text(Y, :) = line; 
            end
            text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)];
            disp(text); 
            
            sol = zeros(n, 1);
            for i = 1 : n
                sol(i) = mAmp(i, n + 1) / mAmp(i, i)
                text = "(" + string(mAmp(i, i)) + ")×a" + string(i) + " = " + string(mAmp(i, n + 1)) + " --> " +..
                "a" + string(i) + " = (" + string(mAmp(i, n + 1)) + ")/(" + string(mAmp(i, i)) + ") = " +..
                string(sol(i));
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

function solucion = gauss(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            mAmp = [mCoe, mInd];
            for X = 1 : n - 1
                text = string(zeros(n, n + 3));
                for Y = 1 : X
                    line = ["|", string(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", string(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + string(mAmp(Y, X)) + " / " + string(mAmp(X, X)) + " )"]
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
                    line = ["|", string(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
            end
            text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : n + 3)]
            disp(text)
            
            sol = zeros(n, 1);
            
            for i = n:-1:1
                sol(i) = mAmp(i, n + 1);
                ig3 = string(sol(i));
                ig2 = string(sol(i));
                ig1 = "(" + string(mAmp(i, i)) + ")×a" + string(i);
                for j = i + 1:n
                    sol(i) = sol(i) - sol(j) * mAmp(i, j);
                    ig1 = ig1 + " + (" + string(sol(j)) + ")×(" + string(mAmp(i, j)) + ")"
                    ig2 = ig2 + " - (" + string(sol(j)) + ")×(" + string(mAmp(i, j)) + ")"
                end
                ig = ig1 + " = " + ig3;
                disp("")
                disp(ig);
                sol(i) = sol(i) / mAmp(i, i);
                disp("a" + string(i) + " = (" +  ig2 + ")/(" + string(mAmp(i, i)) + ") = " + string(sol(i)));
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

function solucion = LU(mCoe, mInd)
    [n, m] = size(mCoe)
    if n == m  then
        if mCoe(1) <> 0 then
            m = mCoe;
            id = eye(n, n);
            for X = 1 : n - 1
                text = string(zeros(n, n + 2));
                for Y = 1 : X
                    line = ["|", string(m(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                for Y = X + 1 : n
                    line = ["|", string(m(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                    " * ( " + string(m(Y, X)) + " / " + string(m(X, X)) + " )"]
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
                    line = ["|", string(m(Y, :)), "|"]
                    text(Y, :) = line; 
            end
            disp(text);
            disp("Matriz LU");
            disp(string(id));
            disp("Sistema de ecuaciones con el coeficiente de reducción:");
            for i = 1 : n
                cadena = "";
                for j = 1 : i
                    if j == 1 then
                        cadena = cadena + "(" + string(id(i, j)) + ")×b" + string(j); 
                    else
                        cadena = cadena + " + (" + string(id(i, j)) + ")×b" + string(j);
                    end  
                end
                cadena = cadena + " = " + string(mInd(i, 1));
                disp(cadena);
            end
            disp("Solución del sistema con coeficientes de reducción: ")
            sol = zeros(n, 1);
            for i = 1:n
                sol(i) = mInd(i, 1)
                eq1 = "b" + string(i);
                eq2 = string(mInd(i, 1));
                for j = 1: i - 1
                    sol(i) = sol(i) - sol(j) * id(i, j);
                    eq2 = eq2 + " - (" + string(sol(j)) + ")×(" + string(id(i, j)) + ")";
                end
                r = eq1 + " = " + eq2 + " = " + string(sol(i));
                disp(r)
            end
            
            disp("Formar el sistema de ecuaciones con el último paso del método de Gauss");    
            
            for i =1:n
                cadena = "";
                for j = i:n
                    if j == i then
                        cadena = cadena + "(" + string(m(i, j)) + ")×a" + string(j); 
                    else
                        cadena = cadena + " + (" + string(m(i, j)) + ")×a" + string(j);
                    end
                end
                cadena = cadena + " = b" + string(i);
                disp(cadena);
            end
            disp("")
            for i =1:n
                cadena = "";
                for j = i:n
                    if j == i then
                        cadena = cadena + "(" + string(m(i, j)) + ")×a" + string(j); 
                    else
                        cadena = cadena + " + (" + string(m(i, j)) + ")×a" + string(j);
                    end
                end
                cadena = cadena + " = " + string(sol(i, 1));
                disp(cadena)
            end
            
            disp("Solución final del sistema: ")
            sol2 = zeros(n, 1);
            for i = n:-1:1
                sol2(i) = sol(i, 1)
                eq = string(sol2(i, 1));
                for j = i + 1:n
                    sol2(i) = sol2(i) - sol2(j) * m(i, j);
                    eq = eq + " - (" + string(sol2(j)) + ")×(" + string(m(i, j)) + ")"
                end
                sol2(i) = sol2(i) / m(i, i);
                r = "a" + string(i) + " = (" + eq + ")/(" + string(m(i, i)) + ") = " + string(sol2(i))
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
                        line = ["|", string(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    if X == 1 & mAmp(1, 1) <> 1 then
                        line = ["|", string(mAmp(X, :)), "| f" + string(X) + " * ( 1 / " +..
                        string(mAmp(X, X)) + " )"];
                        text(X, :) = line; 
                        text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                        disp("");             
                        disp(text);    
                        disp("");               
                        mAmp(X, :) = mAmp(X, :) * (1 / mAmp(X, X));
                    end                
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : X
                        line = ["|", string(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    for Y = X + 1 : n
                        line = ["|", string(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                        " * ( " + string(mAmp(Y, X)) + " / " + string(mAmp(X, X)) + " )"];
                        text(Y, :) = line; 
                    end
                    text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                    disp(text)
                    for Y = X + 1 : n
                        mAmp(Y, :) = mAmp(Y, :) - mAmp(X, :) * (mAmp(Y, X) / mAmp(X, X));                   
                    end
                    text = string(zeros(n, 2 * n + 2));
                    for Y = 1 : n
                        line = ["|", string(mAmp(Y, :)), "|"];
                        text(Y, :) = line; 
                    end
                    if X + 1 <= n then
                        line = ["|", string(mAmp(X + 1, :)), "| f" + string(X + 1) + " * ( 1 / " +..
                        string(mAmp(X + 1, X + 1)) + " )"];
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
                        line = ["|", string(mAmp(Y, :)), "| f" + string(Y) + " - f" + string(X) +...
                        " * ( " + string(mAmp(Y, X)) + " / " + string(mAmp(X, X)) + " )"];
                        text(Y, :) = line; 
                    end 
                    for Y = X : n
                        line = ["|", string(mAmp(Y, :)), "|"]
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
                    line = ["|", string(mAmp(Y, :)), "|"]
                    text(Y, :) = line; 
                end
                text = [text(:, 1 : n + 1), sep, text(:, n  + 2 : 2 * n + 2)];
                disp(text); 
                disp("");
                
                inversa = mAmp(:, n + 1 : 2 * n)
                
                disp("Matriz inversa: ");
                disp(string(inversa));
                disp("Matriz de terminos independientes: ");
                disp(string(mInd));
                disp("Solución: ");
                sol = inversa * mInd;
                et = string(zeros(n, 1))
                for i = 1 : n
                    et(i, 1) = "a" + string(i) + " = ";
                end
                disp([et, string(sol)]);
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
        disp("La dimensión de la matriz de terminos independientes" +..
        "no coincide con la matriz de coeficientes");
        solucion = null
    end
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

    tabla = R;
endfunction
