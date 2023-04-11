%%
close all; clear; clc;
Fs=100;
t=0:(1/Fs):10;
x = 0.9*sin(2*pi/0.1*t) + 0.6*sin(2*pi*17*t) + 4*(1-abs(t-4)/1.5).*(abs(t-4)<1.5); 

xlabel('Czas [s]')
XT=fftshift(fft(x));
WA=abs(XT); 
%WF=angle(XT);
%f=linspace(0,Fs,length(t));  %rozdziela wektor na liniowe czesci
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

filtr=1.0*(abs(f)<14); %> - dolnoprzepustowy
x_new=real(ifft(ifftshift(filtr.*XT))); %obcinamy urojone
subplot(211), plot(t, x, 'g', t, x_new, 'r');
subplot(212), plot(f, WA, 'g', f, filtr*400, 'r'); % widmo amplitudowe i fazowe jest OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  

%%
close all; clear; clc;
Fs=100;
t=0:(1/Fs):10;
%x = 0.9*sin(2*pi/0.1*t) + 0.6*sin(2*pi*17*t) + 4*(1-abs(t-4)/1.5).*(abs(t-4)<1.5); 
x=3*(abs(t-5)<1); %dla prostokatnego 

xlabel('Czas [s]')
XT=fftshift(fft(x));
WA=abs(XT); 
%WF=angle(XT);
%f=linspace(0,Fs,length(t));
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

filtr=1.0*( abs(f)<=7 | abs(f)>=14 );

x_new=real(ifft(ifftshift(filtr.*XT)));
subplot(211), plot(t,x, 'g', t, x_new, 'r');
subplot(212), plot(f, WA, 'g', f, filtr*400, 'r');%OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  

%% FILTR BUTTERWORTHA
close all; clear; clc;
Fs=100;
t=0:(1/Fs):10;
%x = 0.9*sin(2*pi/0.1*t) + 0.6*sin(2*pi*17*t) + 4*(1-abs(t-4)/1.5).*(abs(t-4)<1.5); 
x=3*(abs(t-5)<1); %dla prostokatnego 

xlabel('Czas [s]')
XT=fftshift(fft(x));
WA=abs(XT); 
%WF=angle(XT);
%f=linspace(0,Fs,length(t));
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

filtr=1./(1+(f/10).^10);

x_new=real(ifft(ifftshift(filtr.*XT)));
subplot(211), plot(t, x, 'g', t, x_new, 'r');
subplot(212), plot(f, WA, 'g', f, filtr*400, 'r');%OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  

%% FILTR GAUSSA
clear all; clear; clc;
Fs=100;
t=0:(1/Fs):10;
%x = 0.9*sin(2*pi/0.1*t) + 0.6*sin(2*pi*17*t) + 4*(1-abs(t-4)/1.5).*(abs(t-4)<1.5); 
x=3*(abs(t-5)<1); %dla prostokatnego 

xlabel('Czas [s]')
XT=fftshift(fft(x));
WA=abs(XT); 
%WF=angle(XT);
%f=linspace(0,Fs,length(t));
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

%filtr=exp(-f.*f/(2*10*10)); %oscylacje 0 ale wada oslabiamy od 0 sygnal

filtr=1.0*(abs(f)<10); %lowpass
tt=-50:50; % okienkujemy filtr idealny
gg=exp(-tt.*tt/(2*100));
gg=gg/sum(gg(:));
filtr=conv(filtr,gg,'same');

x_new=real(ifft(ifftshift(filtr.*XT)));
subplot(211), plot(t, x, 'g', t, x_new, 'r');
subplot(212), plot(f, WA, 'g', f, filtr*400, 'r');%OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  

%% 
conv([3 0 -1 2],[1 0 -1])
conv([2 -1 1 3],[2 0 -3])