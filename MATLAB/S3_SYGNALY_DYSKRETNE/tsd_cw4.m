%%
% KORELACJA DWA PODANE
close all; clear; clc; 
x=[4 -2+1i 4+3i -3i];
y=[-1i -4+2i 1];
conv(x,y,'full')
xcorr(x,y)

%% 
% KORELACJA DWA TROJKATNE
close all; clear; clc; 
Fs=100;
t=0:(1/Fs):15;
x1=0.7*(1-2*abs(t-5)/8).*(t>1 & t<9);
x2=0.9*(1-2*abs(t-11)/6).*(t>8 & t<14);
splot=conv(x1,x2,'same')/Fs;  %nie dzielimy gdy 1/3,1/3,1/3 badz suma 0
xc=xcorr(x1,x2);

tc=-15:(1/Fs):15;

subplot(211), plot(t,x1,"r",t,x2,"g",t,splot,"b");
subplot(2,1,2), plot(tc,xc);
%% KORELACJA PROSTOKĄT
close all; clear; clc; 
a=load('corr_02.txt');
t=a(:,1)';
x=a(:,2)';
plot(t,x);

%szukamy pros szer 16 amp 0.65 wynik przewid 54
dt=t(2)-t(1);
tp=0:dt:16;
pros=0.65*ones(size(tp));
xc=xcorr(x,pros);
tc=-200:dt:200;  %podwojny czas korelacji

nr=find(xc==max(xc(:)),5,'first'); %wektor log, max indeksow, od pocz
tc(nr)

subplot(211), plot(t,x,'r',tp+54,pros,'.b');
subplot(212), plot(tc,xc);




%%
%ŁADOWANIE PLIKÓW
close all; clear; clc; 
a=load('corr_02.txt');
t=a(:,1)';
x=a(:,2)';
plot(t,x);

% KORELACJA - NAJBARDZIEJ PASUJACE FIGURY
%szukamy troj szer 10 amp 1 wynik przewid 1 i 12
dt=t(2)-t(1);
tp=0:dt:10;
troj=1-(abs(tp-5)/5);
xc=xcorr(x,troj)+xcorr(1-x,1-troj); % NIE samo xcorr(x,troj) 
tc=-200:dt:200;  %podwojny czas korelacji

nr=find(xc>0.9999*max(xc(:)),5,'first'); 
%find -> wektor log, max indeksow, od pocz
tc(nr)

subplot(211), plot(t,x,'r',tp+12,troj,'.b');
subplot(212), plot(tc,xc);

%korelacja dziala do dominujacych sygnalow czyli o duzych polach pow.
%nie na chude trojkaty
%mozemy obejsc uzywajac funkcji log/pot/pierw Gauss-pierw, prost-pot
%badz obracajac PATRZ linijka 61

%%
%ŁADOWANIE PLIKÓW
close all; clear; clc; 
a=load('corr_02.txt');
t=a(:,1)';
x=a(:,2)';
plot(t,x);

% KORELACJA - NAJBARDZIEJ PASUJACE FIGURY
%szukamy gaussa czas w, odch 3, amp=0.9, wynik 185

dt=t(2)-t(1);
T=10;
tp=-T:dt:T;
gaus=0.9*exp(-tp.*tp/(2*3^2));
xc=xcorr(x,gaus)+xcorr(1-x,1-gaus);
tc=-200:dt:200;  %podwojny czas korelacji

nr=find(xc==max(xc(:)),5,'first'); 
tc(nr)+10

subplot(211), plot(t,x,'r',tp+185,gaus,'.b');
subplot(212), plot(tc,xc);

%% cw1a
close all; clear; clc; 
x=[1 -3/2 -2 1];
y=[2 -2 1];
conv(x,y,'full')
xcorr(x,y)

%% cw1b
close all; clear; clc; 
x=[1 -3/2 -2 1];
y=[2 -2 1];
conv(x,y,'full')
xcorr(x,y)


%% cw 6
a=load('tomo.dat');
b=load('tomo_sygn.dat');
figure;
hold on;
Fs=10E6;
t=(0:1200)/Fs;

%for k=1:41
%    plot( t,a(k,:)+k-1, 'b');
%end

%figure; plot(t,a(21,:))
%figure; plot(b(:,1),b(:,2)


v = zeros(1,41);
tc=(-1200:1200)/Fs; 

for k=1:41
    xc = xcorr(a(k,:),b(:,2)');
    nr = find(xc==max(xc(:)),1,'first');
    v(k) = tc(nr);  %czas fali
end

dx=sqrt(0.5^2+(-0.2:0.01:0.2).^2);
v=dx./v;
plot(v)

%%

close all; clear; clc; 
a=load('testowe.dat');
t=a(:,1)';
x=a(:,2)';
%plot(t,x);

dt=t(2)-t(1);
Fs = 1/dt;

tp=-1.25:dt:1.25;
troj=(1-(abs(tp)/1.25)).*(abs(tp)<1.25);

xc=xcorr(x,troj)+xcorr(1-x,1-troj); % NIE samo xcorr(x,troj) 
tc=-10:dt:10;  %podwojny czas korelacji

nr=find(xc>0.9999*max(xc(:)),5,'first'); 
tc(nr)

subplot(211), plot(t,x,'r',tp+6,troj,'.b');
subplot(212), plot(tc,xc);
