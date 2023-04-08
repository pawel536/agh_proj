%% METODA BISEKCJI
close all; clear; clc;

%format rat
x = 0:0.01:4;
f=@(x) exp(-x)+sin(2*x+pi/3);
%g=@(x) x^3-3;

%[xpr, iterpr] = bisekcja(g, 0, 8, 0.1)
[x1, iter] = bisekcja(f, 0, 4, 0.01)

plot(x,f(x),'b',x1,f(x1),'or');

%% REGULA FALSI / METODA SIECZNYCH
close all; clear; clc; 

%format rat
x = 0:0.01:6;
f=@(x) exp(-x)+sin(2*x+pi/3);
%g=@(x) x^2-3;

%[xpr, iterpr] = regula_falsi(g, 0, 8, 0.1)
[extr, x1, iter] = regula_falsi(f, 0, 4, 0.01) 
% Przyjmij przedział poszukiwań równy <0;4> !!!

plot(x,f(x),'b',x1,f(x1),'or',extr,f(extr),'xr');

%% METODA STYCZNYCH
close all; clear; clc; 

%format rat
x = 0:0.01:6;
f=@(x) exp(-x)+sin(2*x+pi/3);
%g=@(x) x^2 - 3;
fp=@(x) myfirst_4order(f,x,0.1);

%[x1, iter, x_all] = stycznych(g, fp, 0, 8, 0.1, 8)
[x1, iter, x_all] = stycznych(f, fp, 0, 4, 0.01, 4)

plot(x,f(x),'b',x1,f(x1),'or',x_all,f(x_all),'xr');

%% FUNKCJE

function [x1, iter] = bisekcja(fun, a, b, eps)
x1 = (a + b)/2;
iter = 0;
while ( fun(x1)~=0 ) &&  ( abs(b-a)>eps )
    x1 = (a + b)/2;
    if fun(a)*fun(x1)<0
        %a
        b = x1;
    else
        a = x1;
        %b
    end
    iter = iter + 1;
end
end

function [extr, x1, iter] = regula_falsi(fun, a, b, eps)
x1 = a - fun(a)*(b-a)/(fun(b)-fun(a));
iter = 0;
while abs(fun(x1))>eps
    x1 = a - fun(a)*(b-a)/(fun(b)-fun(a));
    if fun(a)*fun(x1)<0
        b = x1;
    else
        a = x1;
    end
    iter = iter + 1;
    extr(iter) = x1;
end
end

function [x1, iter, x_all] = stycznych(fun, pochodna, a, b, eps, x0 )
iter = 0;
while abs(fun(x0))>eps
    x1 = x0 - fun(x0) / pochodna(x0);
    x0 = x1;
    iter = iter + 1;
    x_all(iter) = x1;
end
end

function y = myfirst_4order(f,x,h)
    y=(8*f(x+h)-8*f(x-h)-f(x+2*h)+f(x-2*h))/(12*h);
end



