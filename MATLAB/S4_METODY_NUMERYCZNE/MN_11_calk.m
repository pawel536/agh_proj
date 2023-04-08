%% CAŁKOWANIE MET PROSTOKĄTÓW I MET TRAPEZÓW

%f=@(x) x.^2;
g=@(x) x.^2 - 4;
%a1 = integral_rectangle(f,0,10,1) 285
%b1 = integral_trapese(f,0,10,1) 335
%a2 = integral_rectangle(f,0,10,2) 240
%b2 = integral_trapese(f,0,10,2) 340
t04 = integral_trapese(g,0,4,0.01)
p24 = integral_rectangle(g,2,4,0.01)

function [y] = integral_rectangle (fun,a,b,h)
suma = 0;
for k=a:h:(b-h)
    suma = suma + fun(k);
end
y = h * suma;
end

function [y] = integral_trapese (fun,a,b,h)
suma = 0;
for k=(a+h):h:(b-h)
    suma = suma + fun(k);
end
y = h/2*(fun(a)+fun(b)) + h*suma;
end



