%%
close all; clear; clc;
Fs=200;
t=0:(1/Fs):12;
x=0.8*sin(2*pi*31*t).*(t<=4) + 1.0*sin(2*pi*19*t).*(abs(t-6)<2) + 0.6*sin(2*pi*41*t).*(abs(t-10)<=2);

f=linspace(-Fs/2,Fs/2,length(t));
XT=fftshift(fft(x)); % (a) fft -> presuniecie
WA=abs(XT);

subplot(211);
plot(t,x,'r');
subplot(212);
plot(f,WA,'g');
%% STFT
close all; clear; clc;
Fs=200;
t=0:(1/Fs):12;
x=0.8*sin(2*pi*31*t).*(t<=4) + 1.0*sin(2*pi*19*t).*(abs(t-6)<2) + 0.6*sin(2*pi*41*t).*(abs(t-10)<=2);

%XT=fftshift(fft(x));
%WA=abs(XT);
%f=linspace(-Fs/2,Fs/2,length(t));

N=length(x);
okno = 128;
tab=zeros(okno, N-okno);

%wintool
wnd=blackman(okno);
%wnd=parzenwin(okno);

for k = 1:(N-okno)
    xx=x(k:k+okno-1).*wnd';
    WA = abs(fftshift(fft(xx)));
    tab(:,k)=WA';
end
figure;
imagesc(tab);

tt=(0:N-okno-1)/Fs;
ff=linspace(-Fs/2, Fs/2, okno);
imagesc(tt,ff,tab);
xlabel('Przesuniecie [s]');
ylabel('Czestotliwosc [Hz]');
colorbar('vertical');

%%
%wavemenu

%%
close all; clear; clc;
Fs=200;
t=0:(1/Fs):12;
x=sin(2*pi*(2+t).*t);  %byloby 2+2*t ale dzielimy przez 2 bo pochodna
f=linspace(-Fs/2,Fs/2,length(t));
XT=fftshift(fft(x)); % (a) fft -> presuniecie
WA=abs(XT);

subplot(211);
plot(t,x,'r');
subplot(212);
plot(f,WA,'g');

%%
[C,L]=wavedec(x,3,'db3');
A3 = C(1:L(1));
D3 = C(1+L(1):L(1)+L(2));
D2 = C(1+L(1)+L(2):L(1)+L(2)+L(3));
D1 = C(1+L(1)+L(2)+L(3):L(1)+L(2)+L(3)+L(4));
subplot(221), plot(A3);
subplot(222), plot(D3);
subplot(223), plot(D2);
subplot(224), plot(D1);
C(1+L(1)+L(2)+L(3):L(1)+L(2)+L(3)+L(4))=0;
xn = waverec(C,L,'db3');
figure;
plot(t,x,'g',t,xn,'k');