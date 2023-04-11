%%
close all; clear; clc;
Fs=100;
t=0:(1/Fs):12;
%x = 0.8*(abs(t-4)>2) + 1*(1-(t-9)).*(abs(t-9)>1);
x = 0.8*(t>=2 & t<=6) + 1*(1-abs(t-9)/1).*(abs(t-9)<1);
N = 51;
LP = ones(1,N)/N;
x1=conv(x,LP,'same');

N2=floor(N/2);
odch=N2/4;
LP=exp(-(-N2:N2).^2/(2*odch*odch));
LP=LP/sum(LP(:));
x2=conv(x,LP,'same');

x3=medfilt1(x,N);  %filtr medianowa
%-czasochlonna +dobrze zachowuje krawedzi
%-nie na kartach graf
%-nie dolnoprzepustowa

x4=wiener2(x, [1 N]);
% ocalona krawedz

subplot(211);
plot(t,x,'.-g',t,x1,'r',t,x2,'k');
subplot(212);
plot(t,x,'.-g',t,x3,'r',t,x4,'k');

%%
close all; clear; clc;
Fs=100;
t=0:(1/Fs):12;
%x = 0.8*(abs(t-4)>2) + 1*(1-(t-9)).*(abs(t-9)>1);
x = 0.8*(t>=2 & t<=6) + 1*(1-abs(t-9)/1).*(abs(t-9)<1);
xs = x + 0.05*randn(size(t));

ocena=@(x,xs)sqrt(sum((x(:)-xs(:)) .^2));
wyn = zeros(50,5);
for k=1:50
    N=2*k+1;
    %N = 10;
    LP = ones(1,N)/N;
    x1=conv(xs,LP,'same');
    
    N2=floor(N/2);
    odch=N2/4;
    LP=exp(-(-N2:N2).^2/(2*odch*odch));
    LP=LP/sum(LP(:));
    x2=conv(xs,LP,'same');
    
    x3=medfilt1(xs,N);  
    x4=wiener2(xs, [1 N]);

    wyn(k,1)=N;
    wyn(k,2)=ocena(x,x1);
    wyn(k,3)=ocena(x,x2);
    wyn(k,4)=ocena(x,x3);
    wyn(k,5)=ocena(x,x4);
end

%najnizsze dla med/wie 19
subplot(211);
plot(t,x,'.-g',t,x1,'r',t,x2,'k');
subplot(212);
plot(t,x,'.-g',t,x3,'r',t,x4,'k');

figure();

%%
close all; clear; clc;
Fs=100;
t=0:(1/Fs):12;
x = 0.8*(t>=2 & t<=6) + 1*(1-abs(t-9)/1).*(abs(t-9)<1);
%x = sin(2*pi*t/3);
%xs = x + 0.05*randn(size(t));
%xs = x+(-0.1+0.2*rand(size(t)));
tt=rand(size(t));
xs=x+1*(tt<=0.025)-1*(tt>0.975);
plot(t,x,t,xs,'r');

ocena=@(x,xs)sqrt(sum((x(:)-xs(:)) .^2));
wyn = zeros(50,5);
for k=1:50
    N=2*k+1;
    %N = 10;
    LP = ones(1,N)/N;
    x1=conv(xs,LP,'same');
    
    N2=floor(N/2);
    odch=N2/4;
    LP=exp(-(-N2:N2).^2/(2*odch*odch));
    LP=LP/sum(LP(:));
    x2=conv(xs,LP,'same');
    
    x3=medfilt1(xs,N);  
    x4=wiener2(xs, [1 N]);

    wyn(k,1)=N;
    wyn(k,2)=ocena(x,x1);
    wyn(k,3)=ocena(x,x2);
    wyn(k,4)=ocena(x,x3);
    wyn(k,5)=ocena(x,x4);
end

%sygnal lagodny - typ 1/2
%sygnal ostry - typ 3/4


subplot(211);
plot(t,x,'.-g',t,x1,'r',t,x2,'k');
subplot(212);
plot(t,x,'.-g',t,x3,'r',t,x4,'k');

figure;
plot(wyn(:,1),wyn(:,2:5));
legend('avg','Gauss','Med','Wnr');

%x1 xs2        wiener 19 best
%x_all xs3  szum impulsowy -> med najlepsze
%kazda filtr degeneruje sygnal

%%
close all; clear; clc;
a=load('szum_201.txt');
t=a(:,1)';
x=a(:,2)';
xs=a(:,3)';
%plot(t,x,'.g',t,xs,'r');

ocena=@(x,xs)sqrt(sum((x(:)-xs(:)).^2)/length(x));

wyn = zeros(50,5);
for k=1:50
    N=2*k+1;
    %N = 10;
    LP = ones(1,N)/N;
    x1=conv(xs,LP,'same');
    
    N2=floor(N/2);
    odch=N2/4;
    LP=exp(-(-N2:N2).^2/(2*odch*odch));
    LP=LP/sum(LP(:));
    x2=conv(xs,LP,'same');
    
    x3=medfilt1(xs,N);  
    x4=wiener2(xs, [1 N]);

    wyn(k,1)=N;
    wyn(k,2)=ocena(x,x1);
    wyn(k,3)=ocena(x,x2);
    wyn(k,4)=ocena(x,x3);
    wyn(k,5)=ocena(x,x4);
end

%subplot(211);
%plot(t,x,'.-g',t,x1,'r',t,x2,'k');
%subplot(212);
%plot(t,x,'.-g',t,x3,'r',t,x4,'k');

figure;
plot(wyn(:,1),wyn(:,2:5));
legend('avg','Gauss','Med','Wnr');

Y=wiener2(xs,[1 11]);
ocena(x,Y)  %ma byc 1 rozw

WA=abs(fftshift(fft(x-xs)));
plot(WA)

%% FILTRY NIELINIOWE
%czas jak med
close all; clear; clc;
Fs=100;
t=0:(1/Fs):12;
x = 0.8*(t>=2 & t<=6) + 1*(1-abs(t-9)/1).*(abs(t-9)<1);
N=81;
x1=ordfilt2(x,1,ones(1,N));
x2=ordfilt2(x,N,ones(1,N));
%plot(t,x,'.-g',t,x1,'r',t,x2,'k');
plot(t,x,'.-g',t,x,'r',t,x2-x1,'k');
x=x+0.05*randn(size(t));
x3=entropyfilt(x,ones(1,N)); %filtr entropii n kolo 100
plot(t,x,t,x3);

%% kol prob 3.4
close all; clear; clc;
a=load('dem_201.txt');
x=a(:,1)';
xs=a(:,2)';
N=length(x);
Fs=1000;

t=0:(1/Fs):((N-1)/Fs);



ocena=@(x,xs)sqrt(1/N*sum((x-xs).^2));

wyn = zeros(250,5);

for k=1:2:250
    N=2*k+1;
    LP = ones(1,N)/N;
    x1=conv(xs,LP,'same');
    
    N2=floor(N/2);
    odch=N2/4;
    LP=exp(-(-N2:N2).^2/(2*odch*odch));
    LP=LP/sum(LP(:));
    x2=conv(xs,LP,'same');
    
    x3=medfilt1(xs,N);  
    x4=wiener2(xs, [1 N]);

    wyn(k,1)=N;
    wyn(k,2)=ocena(x,x1);
    wyn(k,3)=ocena(x,x2);
    wyn(k,4)=ocena(x,x3);
    wyn(k,5)=ocena(x,x4);
end

%subplot(211);
%plot(t,x,'.-g',t,x1,'r',t,x2,'k');
%subplot(212);
%plot(t,x,'.-g',t,x3,'r',t,x4,'k');

figure;
plot(wyn(:,1),wyn(:,2:5));
legend('avg','Gauss','Med','Wnr');

Y=medfilt1(xs,30);
ocena(x,Y)

%%
XTxs=fftshift(fft(xs_old));
WAxs=abs(XTxs); 
fxs=linspace(-Fs/2,Fs/2,length(t));
filtrxs=1.0*( abs(fxs)<=419.5 | abs(fxs)>=420.8 );
xs=real(ifft(ifftshift(filtrxs.*XTxs)));

WA=abs(fftshift(fft(xs)));
plot(fxs, WA, 'g', fxs, filtrxs*4000, 'r')

