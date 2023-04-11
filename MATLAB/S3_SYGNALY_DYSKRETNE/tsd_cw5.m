close all; clear; clc; 
Fs=100;
t=-5:(1/Fs):5;
x=2*(abs(t)<=3);
XT=1.2*ones(size(t));
for n=1:100
    an=4*sin(3*n*pi/5)/(n*pi);  %mianownik w nawiasach
    XT = XT+an*cos(n*pi*t/5);
end
plot(t,x,'.g',t,XT,'b')
%%
close all; clear; clc; 
Fs=100;
t=-3:(1/Fs):3;
x=(1-abs(t)/2).*(abs(t)<=2);
XT=ones(size(t))/3;
for n=1:100
    an=3*(1-cos(2*n*pi/3))/(n*n*pi*pi);  %mianownik w nawiasach
    XT = XT+an*cos(n*pi*t/3);
end
plot(t,x,'.g',t,XT,'k')

%% zad 5 1
close all; clear; clc; 
Fs=100;
t=-1:(1/Fs):1;
x=(abs(t)<=1/2);
XT=1/2*ones(size(t));
for n=1:100
    an=2*sin(n*pi/2)/(n*pi);  %mianownik w nawiasach
    XT = XT+an*cos(n*pi*t);
end
plot(t,x,'.r',t,XT,'k')


%% zad 5 3
close all; clear; clc; 
Fs=100;
t=-pi:(1/Fs):pi;
x=t.*(t>0);
XT=pi/4*ones(size(t));
apom = -1;
for n=1:100
    an=(apom-1)/(n*n*pi);  %mianownik w nawiasach
    apom = -apom;
    bn=apom/(n);  %mianownik w nawiasach
    XT = XT+an*cos(n*t)+bn*sin(n*t);
end
plot(t,x,'.r',t,XT,'k')

%% zad 5 4
close all; clear; clc; 
Fs=100;
t=-pi:(1/Fs):pi;
x=t.*t;
XT=pi*pi/3*ones(size(t));
apom = -1;
for n=1:100
    an=(4*apom)/(n*n);  %mianownik w nawiasach
    apom = -apom;
    XT = XT+an*cos(n*t);
end
plot(t,x,'.r',t,XT,'k')

%% zad 5 6
close all; clear; clc; 
Fs=100;
t=-5:(1/Fs):5;
x=mod(floor(t),2)==0;
x=2*(x-1/2);
XT=zeros(size(t));
apom = -1;
for n=1:100
    bn=2*(1-apom)/(n*pi);  %mianownik w nawiasach
    apom = -apom;
    XT = XT+bn*sin(n*pi*t);
end
plot(t,x,'.r',t,XT,'k')

%% 6 z1
close all; clear; clc; 
Fs=100;
t=-2:(1/Fs):4;
x=1/2*t.*(t>=0 & t<2) + 1.0*(t>=2 & t<=4);
XT=1/2*ones(size(t));  
for n=1:100
    an=3*(cos(2*pi*n/3)-1)/(2*pi*pi*n*n)+sin(4*n*pi/3)/(pi*n); 
    bn=3*sin(2*pi*n/3)/(2*pi*pi*n*n)-cos(4*n*pi/3)/(pi*n); 
    XT = XT+an*cos(n*t*pi/3)+bn*sin(n*t*pi/3);
end
plot(t,x,'.r',t,XT,'k')

%% 6 z2
close all; clear; clc; 
Fs=100;
t=0:(1/Fs):6;
x=(1-t).*(t>=0 & t<2) + -1.0*(t>=2 & t<=4) + (3-t).*(t>4 & t<=6);
XT=-1*ones(size(t));  
for n=1:100
    bn=3*(sin(4*pi*n/3)-sin(2*pi*n/3))/(2*pi*pi*n*n); 
    XT = XT+bn*sin(n*t*pi/3);
end
plot(t,x,'.g',t,XT,'k')


%% s15
close all; clear; clc;
Fs=100;
t=3:(1/Fs):3;
x1=(t+3).*(t<-1);
x2=(-2).*(abs(t)<=1);
x3=(3-t).*(t>1);
x=x1+x2+x3;

A1 = zeros(sizeof(t));
A2 = zeros(sizeof(t));

MSE=@(x,y)(1/length(x))*sqrt(sum((x-y).^2);

blad= zeros(50,1);

for n=1:25
    an = ((-8/(pi*n))*sin)

end


subplot(211)
subplot(212); plot(t,x,'.g',t,XT,'k')