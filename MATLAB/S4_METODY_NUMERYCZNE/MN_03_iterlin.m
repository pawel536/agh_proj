%% ITERACJA PROSTA
close all; clear; clc;

format rat
%format short

A = [6 4 1; 1 -3 -1; 1 -1 -4];
X = [2; 0; -2];
B = [11; -3; -4];
D = zeros(3);
R = A;
I = 0;
for i=1:3
    D(i,i)=A(i,i);
    R(i,i) = 0;
end
W = -inv(D)*R;
Z = inv(D)*B;

[w1,w2,w3]=warfun(W, 3)

if ( w1 < 1 ) || ( w2 < 1 ) || ( w3 < 1 )
    diff = ones(1,3);
    while( max( diff ) >= 0.001 )
        I = I +1;
        Xnew = W*X + Z;
        for i=1:3
           diff(i) = abs(Xnew(i)-X(i));
        end
        X = Xnew;
    end
end
X
I

%% ITERACJA PROSTA - KRYT STOPU
close all; clear; clc; 

format rat  %format short

A = [6 4 1; 1 -3 -1; 1 -1 -4];
X0 = [2; 0; -2];
B = [11; -3; -4];
eps = ones(1,10);
il_iteracji = ones(1,10);
for i=1:10
    eps(i) = 10^(-i);
    [X, iter, roznica] = it_prosta(A, B, X0, eps(i));
    il_iteracji(i) = iter;  
end

il_iteracji

%% FUNKCJE

function[w1, w2, w3]=warfun(Y, size)
YT = Y';
temp1 = zeros(1, 3);
temp2 = zeros(1, 3);
w3 = 0;
for i=1:size
    for n=1:size
        temp1(i) = temp1(i) + abs( Y(i,n) );
        temp2(i) = temp2(i) + abs( YT(i,n) );
        w3 = w3 + Y(i,n)*Y(i,n);
    end
end
w1 = max( temp1 );
w2 = max( temp2 );
w3 = sqrt(w3);
end

function[X, iter, roznica] = it_prosta(A, B, X0, eps)
sA = size(A,1);
D = zeros(sA);
R = A;
iter = 0;

for i=1:sA
    D(i,i)=A(i,i);
    R(i,i) = 0;
end

W = -inv(D)*R;
Z = inv(D)*B;

[w1,w2,w3]=warfunKS(W);

if ( w1 < 1 ) || ( w2 < 1 ) || ( w3 < 1 )
    X = X0;
    roznica = ones(sA, 1);
    while( max( roznica ) >= eps )
        iter = iter + 1;
        Xnew = W*X + Z;
        for i=1:sA
           roznica(i) = abs( Xnew(i)-X(i) );
        end
        X = Xnew;
    end
end

end

function[w1, w2, w3]=warfunKS(Y)
sY = size(Y,1);
YT = Y';
temp1 = zeros(1, sY);
temp2 = zeros(1, sY);
w3 = 0;
for i=1:sY
    for n=1:sY
        temp1(i) = temp1(i) + abs( Y(i,n) );
        temp2(i) = temp2(i) + abs( YT(i,n) );
        w3 = w3 + Y(i,n)*Y(i,n);
    end
end
w1 = max( temp1 );
w2 = max( temp2 );
w3 = sqrt(w3);

end




