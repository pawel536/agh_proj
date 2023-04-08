%% METODY SAMOSTARTUJĄCE
%Oprogramuj funkcję, która będzie rozwiązywać równanie różniczkowe zwyczajne 
% y'=f(x,y) z warunkami początkowymi y(x0)=y0 metodą Eulera, trapezów, 
% Rungego-Kutta. Funkcja powinna przyjmować jako argumenty: 
% funkcję f(x,y) - funkcje anonimowe pakietu matlab, krańce przedziału 
% a i b dla których ma zostać obliczone rozwiązanie,
% krok obliczeniowy h, wartości początkowe x0 oraz y0.
close all; clear; clc; 

f = @(x, y) y-x^2
%g=@(x, y) x/y
h = @(x) -exp(x)+x.^2+2*x+2
%eu_pr = rrz_euler(g, 1, 5, 1, 1, 2);
%tr_pr = rrz_trapez(g, 1, 5, 1, 1, 2);
%rk_pr = rrz_rk(g, 1, 5, 1, 1, 2);

x = 0:0.1:2;

eu = rrz_euler(f, 0, 2, 0.1, 0, 1);
tr = rrz_trapez(f, 0, 2, 0.1, 0, 1);
rk = rrz_rk(f, 0, 2, 0.1, 0, 1);
an = h(x);

eu_19 = eu(20)
tr_19 = tr(20)
rk_19 = rk(20)
an_19 = an(20)

plot(x, eu, 'm', x, tr,'y', x, rk, 'b', x, an, 'or' ) 

%% METODA ADAMSA BASHFORDA RZĘDU 1-4
close all; clear; clc;

h = @(x) -exp(x)+x.^2+2*x+2
f = @(x, y) y-x^2
x = 0:0.1:2;
an = h(x);

ab_1 = rrz_ab1(f, 0, 2, 0.1, 0, 1);
ab_2 = rrz_ab2(f, 0, 2, 0.1, 0, 1);
ab_3 = rrz_ab3(f, 0, 2, 0.1, 0, 1);
ab_4 = rrz_ab4(f, 0, 2, 0.1, 0, 1);

ab1_19 = ab_1(20)
ab2_19 = ab_2(20)
ab3_19 = ab_3(20)
ab4_19 = ab_4(20)

plot(x, ab_1, 'b', x, ab_2,'y', x, ab_3, 'm', x, ab_4,'g', x, an, 'or') 

%% FUNKCJE

function [y] = rrz_euler(fun, a,b,h,x0,y0)
x = a:h:b;
y = zeros(1, (b-a)/h+1 );
y(1) = y0;
for i=1:size(y,2)-1
    y(i+1) = y(i) + h*fun(x(i), y(i));
end
end

function [tra] = rrz_trapez(fun, a,b,h,x0,y0)
x = a:h:b;
tra = zeros(1, (b-a)/h+1 );
tra(1) = y0;
for i=1:size(tra,2)-1
    tra(i+1) = tra(i) + h/2*( fun(x(i), tra(i)) + fun(x(i+1), tra(i) + h*fun(x(i), tra(i))));
end
end

function [rk] = rrz_rk(fun, a,b,h,x0,y0)
x = a:h:b;
rk = zeros(1, (b-a)/h+1 );
rk(1) = y0;
for i=1:size(rk,2)-1
    k1 = h*fun(x(i),rk(i));
    k2 = h*fun(x(i)+h/2,rk(i)+k1/2); 
    k3 = h*fun(x(i)+h/2,rk(i)+k2/2); 
    k4 = h*fun(x(i)+h,rk(i)+k3);
    rk(i+1) = rk(i) + (k1 + 2*k2 + 2*k3+ k4)/6;
end
end

function [y] = rrz_ab1(fun, a,b,h,x0,y0)
x = a:h:b;
y = zeros(1, (b-a)/h+1 );
pom = rrz_rk(fun, a, b, h, x0, y0);
y(1:2) = pom(1:2);
for i=3:size(y,2)
    y(i) = y(i-1) + h/2*(-1*fun(x(i-2), y(i-2)) + 3*fun(x(i-1), y(i-1)));
end
end

function [y] = rrz_ab2(fun, a,b,h,x0,y0)
x = a:h:b;
y = zeros(1, (b-a)/h+1 );
pom = rrz_rk(fun, a, b, h, x0, y0);
y(1:3) = pom(1:3);
for i=4:size(y,2)
    y(i) = y(i-1) + h/12*( 5*fun(x(i-3), y(i-3)) + -16*fun(x(i-2),y(i-2)) + 23*fun(x(i-1), y(i-1)) );
end
end

function [y] = rrz_ab3(fun, a,b,h,x0,y0)
x = a:h:b;
y = zeros(1, (b-a)/h+1 );
pom = rrz_rk(fun, a, b, h, x0, y0);
y(1:4) = pom(1:4);
for i=5:size(y,2)
    y(i) = y(i-1) + h/24*( -9*fun(x(i-4), y(i-4)) + 37*fun(x(i-3), y(i-3)) + -59*fun(x(i-2),y(i-2)) + 55*fun(x(i-1), y(i-1)) );
end
end

function [y] = rrz_ab4(fun, a,b,h,x0,y0)
x = a:h:b;
y = zeros(1, (b-a)/h+1 );
pom = rrz_rk(fun, a, b, h, x0, y0);
y(1:5) = pom(1:5);
for i=6:size(y,2)
    y(i) = y(i-1) + h/720*( 251*fun(x(i-5), y(i-5)) + -1274*fun(x(i-4), y(i-4)) + ...
    2616*fun(x(i-3), y(i-3)) + -2774*fun(x(i-2),y(i-2)) + 1901*fun(x(i-1), y(i-1)) );
end
end




