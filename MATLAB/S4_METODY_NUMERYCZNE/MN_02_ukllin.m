%% WYZN GAUSSA
%Napisz program, który obliczy wyznacznik macierzy bazując na algorytmie eliminacji Gaussa
close all; clear; clc;

A=[1 4 2 -2; 1 6 1 -1; -1 0 0 5; 3 6 9 8];

detA=detfun(A,4)
rng(42);
B=randi([-3,3],6,6);
detB=detfun(B,6)

%% WYZN GAUSSA ROZSZERZ
close all; clear; clc; 

A=[-1 2 1 -1; 1 -3 -2 -1; 3 -1 -1 4];

A2=detfun2(A,3);
Y = zeros(3,1);
for i=3:(-1):1
    Y(i)=(A2(i,4)-sumfun(Y, A2, i, 3))/A2(i,i);
end
Y

rng(42);
G=randi([-30,30],6,6);
d=randi([-78,78],6,1);
B = zeros(6,7);
for i=1:6
    for j=1:6
       B(i,j)=G(i,j);
    end
    B(i,7)=d(i);
end

B2=detfun2(B,6);
m = zeros(6,1);
for i=6:(-1):1
    m(i)=(B2(i,7)-sumfun(m, B2, i, 6))/B2(i,i);
end
m

%% DEKOMP LU
close all; clear; clc;

A=[1 4 2 -2; 1 6 1 -1; -1 0 0 5; 3 6 9 8];
[L,U]=dekmpLU(A)
determinant=detLU(L,U)
[L4,U4,P4]=lu(A)
det2=det(A)

%% FUNKCJE
function [detM] = detfun(X, size)
for s = 1:(size-1)
   K=X;
   for i=(s+1):size
       for j=(s+1):size
            X(i,j)=K(i,j)-K(i,s)*K(s,j)/K(s,s);
       end
   end
end
detM=1;
for s=1:size
    detM = detM * X(s,s);
end

end

function [X] = detfun2(X, size)
for s = 1:(size-1)
   K=X;
   for i=(s+1):size
       for j=s:(size+1)
            X(i,j)=K(i,j)-K(i,s)*K(s,j)/K(s,s);
       end
   end
end
end

function [s] = sumfun(Y, A, i, size)
s = 0;
for j=(i+1):size
    s=s+A(i,j)*Y(j);
end
end

function[L,U]=dekmpLU(A)
L=eye(4);
U=A;
for i=1:3
    L2=eye(4);
    for j=(i+1):4
        L2(j,i)=-U(j,i)/U(i,i);
        L(j,i)=-L2(j,i);
    end
    U=L2*U;  
end
end

function[determinant]=detLU(L,U)
determinant=1;
for i=1:4
    determinant=determinant*U(i,i);
end
end





