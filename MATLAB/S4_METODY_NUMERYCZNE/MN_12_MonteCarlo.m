%% GENERATORY PSEUDOLOSOWE
close all; clear; clc;

X = ones(11,10);
for a = 1:10
    for i=2:11
        X(i,a) = mod(a * X(i-1,a), 11);
    end
end
X;

%subplot(211); plot(X(1:10,2), X(2:11,2), '.r')
%subplot(212); plot(X(1:10,8), X(2:11,8), '.b')

Y = 15*ones(1, 10001);
for i=2:10001
    Y(i) = mod(3 * Y(i-1), 31);
end
Y = Y / 31;

Z = ones(1, 10001);
for i=2:10001
    Z(i) = mod(7^5 * Z(i-1), 2^31-1);
end
Z = Z / (2^31-1);

subplot(211); plot(Y(1:10000), Y(2:10001), '.b')
subplot(212); plot(Z(1:10000), Z(2:10001), '.b')

a_n = Y(10001)
b_n = Z(10001)

%% PI METODĄ MONTE CARLO
close all; clear; clc; 

%rng(42)
%inside = 0;
%subplot(221);
%for i=1:1000
    %x = rand();
    %y = rand();
    %if (x-1/2)^2 + (y-1/2)^2 <= 1/4
        %plot(x, y, '.g')
        %inside = inside + 1;
    %else
        %plot(x, y, '.b')
    %end
    %hold on
%end
%hold off
%pi1_000 = 4 * inside / 1000

%inside = 0;
%subplot(222);
%for i=1:10000
    %x = rand();
    %y = rand();
    %if (x-1/2)^2 + (y-1/2)^2 <= 1/4
        %plot(x, y, '.g')
        %inside = inside + 1;
    %else
        %plot(x, y, '.b')
    %end
    %hold on
%end
%hold off
%pi10_000 = 4 * inside / 10000

rng(42)
inside = 0;
%subplot(223);
for i=1:100000
    x = rand();
    y = rand();
    if (x-1/2)^2 + (y-1/2)^2 <= 1/4
        %plot(x, y, '.g')
        inside = inside + 1;
    %else
        %plot(x, y, '.b')
    end
    %hold on
end
%hold off
pi100_000 = 4 * inside / 100000

%inside = 0;
%subplot(224);
%for i=1:1000000
    %x = rand();
    %y = rand();
    %if (x-1/2)*(x-1/2) + (y-1/2)*(y-1/2) <= 1/4
        %plot(x, y, '.g')
        %inside = inside + 1;
    %else
        %plot(x, y, '.b')
    %end
    %hold on
%end
%hold off
%pi1_000_000 = 4 * inside / 1000000

%% CAŁKA METODĄ MONTE CARLO
close all; clear; clc; 
rng(42)
inside = 0;
for i=1:10000
    x = -2 + 4*rand();
    y = 4 * rand();
    if y <= 4 - x*x
        %plot(x, y, '.g')
        inside = inside + 1;
    %else
        %plot(x, y, '.b')
    end
    %hold on
end
%hold off
int10_000 = inside / 10000 * 4 * 4


