%% QR HOUSEHOLDERA
close all; clear; clc;

%format rat  %format short
A = [-1 -1 1; 1 3 3; -1 -1 5; 1 3 7];
[Q, R] = qr_ht(A)

%% QR GRANA - SCHMIDTA
close all; clear; clc;

format rat  %format short
A = [-1 -1 1; 1 3 3; -1 -1 5; 1 3 7];
[Q, R] = qr_gs(A)

%% QR POROWN DOKLADNOSCI
close all; clear; clc; 

x=[1, 2, 3, 4, 5, 6];
mx = [15, 30, 75, 150, 300, 750];
my = [10, 20, 50, 100, 200, 500];
time_qr_gs = zeros(1,6);
time_qr_ht = zeros(1,6);
time_qr = zeros(1,6);
err_qr_gs = zeros(1,6);
err_qr_ht = zeros(1,6);
err_qr = zeros(1,6);

for i=1:6
   rng(42)
   A = randi([-500, 500], mx(i), my(i));
   tic; 
   [Q,R] = qr_gs2(A);
   time_qr_gs(i) = toc;
   err_qr_gs(i) = sum(sum(Q*R-A));
   
   tic; 
   [Q,R] = qr_ht2(A);
   time_qr_ht(i) = toc;
   err_qr_ht(i) = sum(sum(Q*R-A));
   
   tic; 
   [Q,R] = qr(A);
   time_qr(i) = toc;
   err_qr(i) = sum(sum(Q*R-A));
end

subplot(321); plot(x,time_qr,'ob'); xlabel('Rozmiar macierzy'); ylabel('czas [s]');
subplot(322); plot(x,err_qr,'ob')
subplot(323); plot(x,time_qr_gs,'or')
subplot(324); plot(x,err_qr_gs,'or')
subplot(325); plot(x,time_qr_ht,'og')
subplot(326); plot(x,err_qr_ht,'og')

%% FUNKCJE

function[Q, R] = qr_ht(A)
    il_w = size(A, 1);
    il_kol = size(A, 2);
    il = il_w;
    R = A;
    Q = eye(il_w);

    for i=1:il_kol
        A_WYCINEK = R(i:il_w,i:il_kol);
    
        a = A_WYCINEK(:,1);
        norm = sqrt(a'*a);
        e = eye(il, 1);
        v = a + sign(A_WYCINEK(1,1)) * norm * e;
        H_WYCINEK = eye(il)-2*v*v'/(v'*v);
        H = eye(il_w);
        H(i:il_w,i:il_w)=H_WYCINEK;
        R = H * R;
        Q = Q * H;
        
        il = il  - 1;
    end
end

function[Q, R] = qr_gs(A)
    il_w = size(A, 1);
    il_kol = size(A, 2);
    R = zeros(il_kol);
    Q = zeros(il_w, il_kol);
    
    for i=1:3
        qpom = A(:,i);
        for k=1:(i-1)
            R(k, i)=(Q(:,k))'*A(:,i);
            qpom = qpom - R(k,i)*Q(:,k);
        end
        R(i,i) = sqrt(qpom'*qpom); %norm
        Q(:,i) = qpom / R(i,i);  %q = qpom / R(i,i);  Q(:,i) = q;
    end
end

function[Q, R] = qr_ht2(A)
    il_w = size(A, 1);
    il_kol = size(A, 2);
    il = il_w;
    R = A;
    Q = eye(il_w);
    
    for i=1:il_kol
        A_WYCINEK = R(i:il_w,i:il_kol);
        
        a = A_WYCINEK(:,1);
        norm = sqrt(a'*a);
        e = eye(il, 1);
        v = a + sign(A_WYCINEK(1,1)) * norm * e;
        H_WYCINEK = eye(il)-2*v*v'/(v'*v);
        H = eye(il_w);
        H(i:il_w,i:il_w)=H_WYCINEK;
        R = H * R;
        Q = Q * H;
        
        il = il  - 1;
    end
end

function[Q, R] = qr_gs2(A)
    il_w = size(A, 1);
    il_kol = size(A, 2);
    R = zeros(il_kol);
    Q = zeros(il_w, il_kol);
    
    for i=1:3
        qpom = A(:,i);
        for k=1:(i-1)
            R(k, i)=(Q(:,k))'*A(:,i);
            qpom = qpom - R(k,i)*Q(:,k);
        end
        R(i,i) = sqrt(qpom'*qpom); %norm
        Q(:,i) = qpom / R(i,i);  %q = qpom / R(i,i);  Q(:,i) = q;
    end
end



