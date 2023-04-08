%% APROKSYMACJA SREDNIOKWADRATOWA
close all; clear; clc;

x = [-2 -1 0 1 2];
y = [4 1 0 1 4];
st = 2;
m = apro_sq(x,y,st)

x2 = [-3 -2 -1 0 1 2 3];
y2 = [-13.5092 15.0143 15.6399 11.9732 2.1204 7.1199 22.1617];
st2 = 3;
m3 = apro_sq(x2,y2,st2)

xplot = -2:0.01:2;
yplot = m(1)+m(2)*xplot+m(3)*xplot.^2;
plot(x, y, 'ob', xplot, yplot, '.r') 

xplot = -3:0.01:3;
yplot = m3(1)+m3(2)*xplot+m3(3)*xplot.^2+m3(4)*xplot.^3;
plot(x2, y2, 'ob', xplot, yplot, '.r') 

%% APROKSYMACJA TRYGONOMETRYCZNA
close all; clear; clc; 

x = [0 1.5708 3.1416 4.7124];
y = [0 3 4 1];
T = (x(2)-x(1))*size(x,2);
%[A0,A,B]=apro_tg(x,y,T)

x2 = [0 0.7854 1.5708 2.3562 3.1416 3.9270 4.7124 5.4978];
y2= [4.0000 1.2929 -1.0000 1.2929 4.0000 2.7071 1.0000 2.7071];
T2 = (x2(2)-x2(1))*size(x2,2);
[A0,A,B]=apro_tg(x2,y2,T2)

xplot = 0:0.01:6.15;
%yplot = A0;
%for i = 1:size(A,2)
%    yplot = yplot + A(i)*cos(2*i*pi/T*xplot) + B(i)*sin(2*i*pi/T*xplot);
%end
%plot(x, y, 'ob', xplot, yplot, '.r') 

yplot = A0;
size(A, 2)
for i = 1:size(A,1)
    yplot = yplot + A(i)*cos(2*i*pi/T*xplot) + B(i)*sin(2*i*pi/T*xplot);
end
plot(x2, y2, 'ob', xplot, yplot, '.r') 

%% FUNKCJE

function[m] = apro_sq(x, y, st)
sz = size(x,2);
G = ones(sz, st+1);
G(:,2)=x';
for i=2:st
    for k=1:sz
       G(k,i+1)=x(k)^i;
    end
end
G
m = inv(G'*G)*G'*y';
end

function[A0,A,B] = apro_tg(x, y, T)
n = size(x,2);
m=fix((n-2)/2);
A0 = 1/n*sum(y);
A = ones(m, 1);
B = ones(m, 1);
for k=1:m
    sumacos = 0;
    sumasin = 0;
    for i = 1:n
        sumacos = sumacos + y(i)*cos(2*pi*k*(i-1)/n);
        sumasin = sumasin + y(i)*sin(2*pi*k*(i-1)/n);
    end
    A(k) = 2/n*sumacos;
    B(k) = 2/n*sumasin;
end
end




