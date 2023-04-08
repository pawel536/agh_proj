%% INTERPOLACJA FUNKCJAMI SKLEJANYMI
close all; clear; clc;

x = [-1 0 1 3 2];
y = [1 -1 -2 -1 0];
skr1 = 45;
skr2 = 135; %135
n = size(x,2);
[xsorted, pomoc]=sort(x);
xsorted
ysorted = y(pomoc)

G = zeros(n+2,n+2);
A = ones(n,4);
for i=2:4
    for k=1:n
        A(k,i)=A(k,i-1)*xsorted(k);
    end
end

B = zeros(n,n-2);
for i=1:(n-2)
    for k=1:n
        if xsorted(k)>xsorted(i+1)
            B(k,i)=(xsorted(k)-xsorted(i+1))^3;          
        end
    end
end

C = ones(2,4);
for i=1:4
    C(1,i)=(i-1);
    C(2,i)=(i-1);
end
C(1,3)=C(1,3)*xsorted(1);
C(1,4)=C(1,4)*xsorted(1)^2;
C(2,3)=C(2,3)*xsorted(n);
C(2,4)=C(2,4)*xsorted(n)^2;

D = zeros(2,n-2);
for i=1:(n-2)
    if xsorted(1)>xsorted(i+1)
        D(1,i)=3*(xsorted(1)-xsorted(i+1))^2;          
    end
    if xsorted(n)>xsorted(i+1)
        D(2,i)=3*(xsorted(n)-xsorted(i+1))^2;          
    end
end

G(1:n,1:4)=A;
G(1:n,5:n+2)=B;
G(n+1:n+2,1:4)=C;
G(n+1:n+2,5:n+2)=D;
G

d=ones(1,n+2);
d(1:n)=ysorted;
d(n+1)=tan(deg2rad(skr1));
d(n+2)=tan(deg2rad(skr2));
d

m = inv(G)*d'

xplot=xsorted(1):0.01:xsorted(n);
for i=1:size(xplot,2)
    yplot(i)=m(1)+m(2)*xplot(i)+m(3)*xplot(i)^2+m(4)*xplot(i)^3;
    for k=1:n-2
        if xplot(i)>xsorted(k+1)
            yplot(i)=yplot(i)+m(k+4)*( xplot(i)-xsorted(k+1) )^3    ;
        end
    end
end

plot(xplot,yplot,'.r',xsorted,ysorted,'ob');
f_09=yplot(11)

%% PRZYKŁAD RUNGEGO
close all; clear; clc; 

x = -5:0.01:5;
f = 1./(1+x.*x);
subplot(231); plot(x, f, '.b')
X2 = -5*ones(1,3);
for i=1:2
    X2(i+1)= X2(i+1)+10*i/2;
    Y2 = 1./(1+X2.*X2);
end
X4 = -5*ones(1,5);
for i=1:4
    X4(i+1)= X4(i+1)+10*i/4;
    Y4 = 1./(1+X4.*X4);
end
X6 = -5*ones(1,7);
for i=1:6
    X6(i+1)= X6(i+1)+10*i/6;
    Y6 = 1./(1+X6.*X6);
end
X8 = -5*ones(1,9);
for i=1:8
    X8(i+1)= X8(i+1)+10*i/8;
    Y8 = 1./(1+X8.*X8);
end
X10 = -5*ones(1,11);
for i=1:10
    X10(i+1)= X10(i+1)+10*i/10;
    Y10 = 1./(1+X10.*X10);
end

igrek2s = inter_spl(X2,Y2);
subplot(232); plot(X2, Y2, 'or', x, igrek2s, '.r')
igrek4s = inter_spl(X4,Y4);
subplot(233); plot(X4, Y4, 'or', x, igrek4s, '.r')
igrek6s = inter_spl(X6,Y6);
subplot(234); plot(X6, Y6, 'or', x, igrek6s, '.r')
igrek8s = inter_spl(X8,Y8);
subplot(235); plot(X8, Y8, 'or', x, igrek8s, '.r')
igrek10s = inter_spl(X10,Y10);
subplot(236); plot(X10, Y10, 'or', x, igrek10s, '.r')
igrek6s
igrek10s

function [yplot] = inter_spl(x,y)
skr1 = 0;
skr2 = 0; %135
n = size(x,2);
[xsorted, pomoc]=sort(x);
xsorted;
ysorted = y(pomoc);

G = zeros(n+2,n+2);
A = ones(n,4);
for i=2:4
    for k=1:n
        A(k,i)=A(k,i-1)*xsorted(k);
    end
end

B = zeros(n,n-2);
for i=1:(n-2)
    for k=1:n
        if xsorted(k)>xsorted(i+1)
            B(k,i)=(xsorted(k)-xsorted(i+1))^3;          
        end
    end
end

C = ones(2,4);
for i=1:4
    C(1,i)=(i-1);
    C(2,i)=(i-1);
end
C(1,3)=C(1,3)*xsorted(1);
C(1,4)=C(1,4)*xsorted(1)^2;
C(2,3)=C(2,3)*xsorted(n);
C(2,4)=C(2,4)*xsorted(n)^2;

D = zeros(2,n-2);
for i=1:(n-2)
    if xsorted(1)>xsorted(i+1)
        D(1,i)=3*(xsorted(1)-xsorted(i+1))^2;          
    end
    if xsorted(n)>xsorted(i+1)
        D(2,i)=3*(xsorted(n)-xsorted(i+1))^2;          
    end
end
 
G(1:n,1:4)=A;
G(1:n,5:n+2)=B;
G(n+1:n+2,1:4)=C;
G(n+1:n+2,5:n+2)=D;
G;

d=ones(1,n+2);
d(1:n)=ysorted;
d(n+1)=tan(deg2rad(skr1));
d(n+2)=tan(deg2rad(skr2));
d;

m = inv(G)*d';

xplot=xsorted(1):0.01:xsorted(n);
for i=1:size(xplot,2)
    yplot(i)=m(1)+m(2)*xplot(i)+m(3)*xplot(i)^2+m(4)*xplot(i)^3;
    for k=1:n-2
        if xplot(i)>xsorted(k+1)
            yplot(i)=yplot(i)+m(k+4)*( xplot(i)-xsorted(k+1) )^3;
        end
    end
end

end



