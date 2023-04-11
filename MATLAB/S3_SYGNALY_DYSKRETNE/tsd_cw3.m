close all; clear; clc; 
%t=<0;10> fs =100
% x prost śr 5 szer 4 amp 2

Fs = 100;
t=0:(1/Fs):10;
x=2*(t>3 & t<7);
xy = conv(x,x,'same')/Fs;
plot(t, x, 'r', t, xy, 'b')

%%
close all; clear; clc; 
Fs = 100;
t=0:(1/Fs):10;
x=2*(1-abs(t-5)/2).*(t>3 & t<7);
plot(t, x)
N=201;
y=ones(1,N)/N;
xy = conv(x,y,'same');
plot(t, x, 'r', t, xy, 'b')

%%
close all; clear; clc; 
Fs = 100;
t=0:(1/Fs):10;
x=2*(1-abs(t-5)/2).*(t>3 & t<7);
plot(t, x)
y=[1 0 -1];
xy = conv(x,y,'same');
plot(t, x, 'r', t, xy, 'b')

%%
close all; clear; clc; 
Fs = 100;
t=0:(1/Fs):10;
t1=(100.*t);

x=(mod(t1,100)==0);
plot(t, x)

odch = 1;  %to od 3 do 1 do 0.4 do 0.1
y=1*exp(-(t-5).*(t-5)/(2*odch*odch));

xy = conv(x,y,'same');
plot(t, x, 'r', t, xy, 'b')

%%
close all; clear; clc; 
Fs = 100;
t=0:(1/Fs):10;
t1=(100.*t);

x=2*(t>3 & t<7);
x=x+0.1*randn(size(x));
N=13;
y=ones(1,N)/N;
xy = conv(x,y,'same');
plot(t, x, 'r', t, xy, 'b')
%%
%zad1

close all; clear; clc; 
%t=<0;10> fs =100
% x prost śr 5 szer 4 amp 2

Fs = 100;
t=-5:(1/Fs):5;
x=(abs(t)<2);
xy = conv(x,x,'same')/Fs;
plot(t, x, 'r', t, xy, 'b')

%%
%zad2

close all; clear; clc; 
x=[-1,0,2,4];
y=[2,0,1];
conv(x,y,'full')
