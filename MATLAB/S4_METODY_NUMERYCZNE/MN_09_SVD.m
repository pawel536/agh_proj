%% SVD OGÓLNE
close all; clear; clc; 

A = [ 1 1; 0 1; 1 0]
B = [2 1 -2]
C = [2 2 2 2 ; 17/10 1/10 -17/10 -1/10; 3/5 9/5 -3/5 -9/5]

[Ua, Sa, Va] = svd(A)
[Uae, Sae, Vae] = svd(A, "econ")
[Ub, Sb, Vb] = svd(B)
[Ube, Sbe, Vbe] = svd(B, "econ")
[U, S, V] = svd(C)
[Uce, Sce, Vce] = svd(C, "econ")


%% SVD ZASTOSOWANIE - ROZW ROWN LINIOWYCH
% Gm =d
% G = U * S * V^T
% m = V * S^(-1) * U^T * d
close all; clear; clc; 

dane = importdata('punkty.txt'); 
x=dane(:,1);
d=dane(:,2);

G = ones(size(x,1),2);
G(:,1) = x;

[U, S, V] = svd(G, "econ"); %  U*S*V' daje G

m=V*inv(S)*U'*d;
a=m(1)
b=m(2)
y=x*a+b;

plot(x,d,'.b', x,y,'or')

%% SVD W KOMPRESJI STRATNEJ
close all; clear; clc; 
A = magic(5);   %[23 6 19 2 15; 4 12 25 8 16; 
% 10 18 1 14 22; 11 24 7 20 3; 17 5 13 21 9];

rng(42)
B = randi([1 12],18,17);

[Uae, Sae, Vae] = svd(A, "econ");
[Ube, Sbe, Vbe] = svd(B, "econ");

pax = ones(5,1);
pay = ones(5,1);
pbx = ones(17,1);
pby = ones(17,1);
for k=1:5
    pax(k)=k;
    pay(k)=Sae(k,k);
end
for k=1:17
    pbx(k)=k;
    pby(k)=Sbe(k,k);
end

%subplot(211); plot(pax, pay, '.r');
%subplot(212); plot(pbx, pby, '.b');

mars=double(imread('mars.jpg'));
colormap(gray(256));

[U, S, V] = svd(mars, "econ");

%sz = size(mars, 1);
%pcx = ones(sz,1);
%pcy = ones(sz,1);
%for k=1:sz
%    pcx(k)=k;
%    pcy(k)=S(k,k);
%end
%plot(pcx, pcy, '.b');

mars200=U(:,1:200)*S(1:200,1:200)*V(:,1:200)';
mars100=U(:,1:100)*S(1:100,1:100)*V(:,1:100)';
mars25=U(:,1:25)*S(1:25,1:25)*V(:,1:25)';

nfull = nnz(S) + nnz(U) + nnz(V)
n200 = nnz(S(1:200,1:200)) + nnz(U(:,1:200)) + nnz(V(:,1:200))
n100 = nnz(S(1:100,1:100)) + nnz(U(:,1:100)) + nnz(V(:,1:100)) 
n25 = nnz(S(1:25,1:25)) + nnz(U(:,1:25)) + nnz(V(:,1:25)) 

subplot(221); image(mars); title('oryginalny')
subplot(222); image(mars200); title('200 wart')
subplot(223); image(mars100); title('100 wart')
subplot(224); image(mars25); title('25 wart')



