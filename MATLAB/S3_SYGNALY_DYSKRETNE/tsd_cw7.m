close all; clear; clc; 
Fs=100;
t=-5:(1/Fs):5;
x=2*(abs(t)<1);
subplot(211), plot(t,x);

xlabel('Czas [s]')
XT=fftshift(fft(x)); % (a) fft -> presuniecie
WA=abs(XT)/Fs;  % (b) /Fs - naginanie danych 
WF=angle(XT);
%f=linspace(0,Fs,length(t));  %rozdziela wektor na liniowe czesci
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

TT=abs(4*sinc(f*2));  % (c) abs() - naginanie danych 
                      % (d) *2 tylko dla matlaba bo matlab

subplot(212), plot(f, WA, 'r', f, TT, 'b'); % widmo amplitudowe i fazowe jest OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  % za zrobienie wykresu od czasu minus polowa pkt na kol

%(a) - zmiany dla widocznosci lepszej

%%

close all; clear; clc; 
Fs=100;
t=-5:(1/Fs):5;
x=2*(abs(t)<1);
%x=2*(abs(t)<4)/4; % zwężenie widma
%x=2*(abs(t)<0.25)*4; % poszerzenie widma
%x=2*(abs(t-2)<4)/4; % przesuniecie w czasie nie zmienia WA widma amplitud.
subplot(211), plot(t,x);

xlabel('Czas [s]')
XT=fftshift(fft(x)); % (a) fft -> presuniecie
WA=abs(XT)/Fs;  % (b) /Fs - naginanie danych 
WF=angle(XT);
%f=linspace(0,Fs,length(t));  %rozdziela wektor na liniowe czesci
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

TT=abs(4*sinc(f*2));  % (c) abs() - naginanie danych 
                      % (d) *2 tylko dla matlaba bo matlab

subplot(212), plot(f, WA, 'r', f, TT, 'b'); % widmo amplitudowe i fazowe jest OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  % za zrobienie wykresu od czasu minus polowa pkt na kol

%(a) - zmiany dla widocznosci lepszej

%%
close all; clear; clc; 
Fs=100;
t=-5:(1/Fs):5;
%x=2*(abs(t)<1);
%x=2*(abs(t)<4)/4; % wyplaszczenie widma
x=2*(abs(t-1)<1); % odwrocenie 
subplot(211), plot(t,x);

xlabel('Czas [s]')
XT=fftshift(fft(x));
WA=abs(XT)/Fs;
WF=angle(XT);

f=linspace(-Fs/2,Fs/2,length(t));  % (a)

TT=abs(4*sinc(f*2));

subplot(212), plot(f, unwrap(WF));
xlabel('Czestotliwosc [Hz]');

%% 
close all; clear; clc; 
fft([1 2+1i 3-1i 1])
%%
close all; clear; clc; 
Fs = 50;
t=0:(1/Fs):20;
%x = x1 + x2 + x3
%x1 funk trojkatna tw=10 szer 4 amp 5
%x2 harm sin f=17Hz amp0.9
%x3 harm okres 0.1 amp 0.7
x1 = 5*(1-abs(t-10)/2).*( t>=8 & t<=12 );
x2 = 0.9*sin(2*pi*t*17);
x3 = 0.7*sin(2*pi*(1/0.1)*t);
x = x1+x2+x3;
XT = fftshift(fft(x));

f=2.5*(t-10);
 
WA=abs(XT);
subplot(211), plot(t,x);
subplot(212), plot(f,WA);  %piki sie zgadzaja f sinus przechodzi w delte diraca

%%
close all; clear; clc;
%Fs=100; t=<-5,5>
%x - trojk, amp 2 szer 1 srod 0
%wykres i wa
Fs=100;
t=-5:(1/Fs):5;
x=2*(1-abs(t)/0.5).*(abs(t)<0.5);

subplot(211), plot(t,x);
xlabel('Czas [s]')
XT=fftshift(fft(x)); % (a) fft -> presuniecie
WA=abs(XT)/Fs;  % (b) /Fs - naginanie danych 
WF=angle(XT);
%f=linspace(0,Fs,length(t));  %rozdziela wektor na liniowe czesci
f=linspace(-Fs/2,Fs/2,length(t));  % (a)

TT=abs(sinc(2*f/4).^2);  % (c) abs() - naginanie danych tu dla formalnosci
                      % (d) *2 tylko dla matlaba bo matlab

subplot(212), plot(f, WA, '.g', f, TT, 'r'); % widmo amplitudowe i fazowe jest OD CZESTOTLIWOSCI
xlabel('Czestotliwosc [Hz]');  % za zrobienie wykresu od czasu minus polowa  pkt na kol

%%
close all; clear; clc; 
fft([2-2i 3 -1i 1+3i])




