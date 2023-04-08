%% PIERWSZA POCHODNA RZĘDU 2/4 FUNKCJI F
close all; clear; clc;

f=@(x) x.^2/3.*sin(3*x);
fp=@(x) (2*x.*sin(3*x)+3*cos(3*x).*x.^2)/3;
z=-6.28:0.01:6.28;
x = -5.5;
h=0.5;

y1 = myfirst_2order(f,z,0.5);
y2 = myfirst_4order(f,z,0.5);
y3 = myfirst_2order(f,z,0.1);
y4 = myfirst_4order(f,z,0.1);
subplot(211); plot(z,f(z),'g',z,fp(z),'b',z,y1,'or',z,y2,'.r')
subplot(212); plot(z,f(z),'g',z,fp(z),'b',z,y3,'or',z,y4,'.r')

p_a = fp(x)
p_2 = myfirst_2order(f,x,h)
p_4 = myfirst_4order(f,x,h)

%% DRUGA POCHODNA RZĘDU 2/4 FUNKCJI F
close all; clear; clc; 

f=@(x) exp(-x.^2).*sin(3*x)/3; %x.^2
fp=@(x) 1/3*exp(-x.^2).*((4*x.^2-11).*sin(3*x)-12*x.*cos(3*x));
z=-6.28:0.01:6.28;
x = 0.35;
h= 0.1;

y1 = mysecond_2order(f,z,0.5);
y2 = mysecond_4order(f,z,0.5);
y3 = mysecond_2order(f,z,0.1);
y4 = mysecond_4order(f,z,0.1);
subplot(211); plot(z,f(z),'g',z,fp(z),'b',z,y1,'or',z,y2,'.r')
subplot(212); plot(z,f(z),'g',z,fp(z),'b',z,y3,'or',z,y4,'.r')

pp_a = fp(x)
pp_2 = mysecond_2order(f,x,h)
pp_4 = mysecond_4order(f,x,h)

%% FUNKCJE

function y = myfirst_2order(f,x,h)
    y=(f(x+h)-f(x-h))/(2*h);
end

function y = myfirst_4order(f,x,h)
    y=(8*f(x+h)-8*f(x-h)-f(x+2*h)+f(x-2*h))/(12*h);
end

function y = mysecond_2order(f,x,h)
    y=(f(x+h)+f(x-h)-2*f(x))/(h*h);
end

function y = mysecond_4order(f,x,h)
    y=(-f(x-2*h)+16*f(x-h)-30*f(x)+16*f(x+h)-f(x+2*h))/(12*h*h);
end



