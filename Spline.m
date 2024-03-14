# spline de grado n con n+1 puntos para octave

#x = input('Ingrese los valores de x: ');
#y = input('Ingrese los valores de y: ');
#opt = input('Ingrese el grado del polinomio: ');

x = [0 2 4];
y = [3 5 1];
disp('Seleccione el tipo de spline que desea calcular');
disp('1. Spline lineal');
disp('2. Spline cuadratico');
disp('3. Spline cubico');
opt = 1;

if opt < 1 || opt > 3
    error('La opcion seleccionada no es valida');
end

n = length(x);
if n ~= length(y)
    error('las longitudes de x e y deben ser iguales');
end

if n < opt
    error('El grado del polinomio no puede ser mayor que el numero de puntos');
end

for i = 1:n-1
    if x(i) >= x(i+1)
        error('Los valores de x deben estar ordenados de forma creciente');
    end
end

for i = 1:n-1
    if x(i) == x(i+1)
        error('Los valores de x no pueden ser iguales');
    end
end

for i = 1:n-1
    if y(i) == y(i+1)
        error('Los valores de y no pueden ser iguales');
    end
end

A = [];
b = [];

switch opt
    case 1
        for i = 1:n-1
            A = [A; x(i) 1];
            A = [A; x(i+1) 1];
            b = [b; y(i)];
            b = [b; y(i+1)];
        end
        
    case 2
    case 3

endswitch

disp('La matriz A es:');
disp(A);
disp('El vector b es:');
disp(b);

sol = inv(A)*b;
disp('Los coeficientes del polinomio son:');
disp(sol);