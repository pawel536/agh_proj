%%
%close all; clear; clc;
Fs=100;
t=-5:(1/Fs):5;
x = 1.0*(abs(t)<1); 

%df=length(fir.Numerator)/(2*Fs);
%di=length(iir.scaleValues)/Fs;
%xF=filter(fir,x);
%xI=filter(iir,x);

df=0; di=0;
xF=filtfilt(fir.Numerator,1,x);
xI =filtfilt(iir.sosMatrix,iir.scaleValues,x);

plot(t,x,'r',t-df,xF,'g',t-di,xI,'b');

%%
close all; clear; clc;
load handel.mat
x=y';
N=length(x);
t=(0:N-1)/Fs;
XT=fftshift(fft(x));
WA=abs(XT);
f=linspace(-Fs/2,Fs/2,N);
BS=1.0*(abs(f)<1000);% & abs(f)>2000);
xn=real(ifft(ifftshift(BS.*XT)));
subplot(211),plot(t,x,'b',t,xn,'r');
subplot(212),plot(f,WA,'b',f,BS*500,'r');

sound(xn,Fs);



