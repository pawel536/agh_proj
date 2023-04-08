%% INTERPOLACJA LAGRANGE'A
close all; clear; clc;

format rat
x = [1 2 3]
y = [0 1 4]
iks = [1.5 2.5];
iksCheck = 2:0.1:4;
igrek = interp_lagrange(x,y,iks)
igrekCheck = interp_lagrange(x,y,iksCheck);
suma_igrek = sum(igrekCheck)

%% INTERPOLACJA NEWTONA
close all; clear; clc;

x = [0 2 3 4 6]
y = [1 3 2 5 7]
iks = [1 1.5];
iksCheck = 2:0.1:4;
igrek = interp_newton(x,y,iks)
igrekCheck = interp_newton(x,y,iksCheck);
suma_igrek = sum(igrekCheck)

%% INTERPOLACJA LAGRANGE'A CD
close all; clear; clc; 

daneG = load('G.txt');
daneH = load('H.txt');
iks = -9:0.1:9;
igrekG = interp_lagrange(daneG(1,:),daneG(2,:),iks);  
igrekH = interp_lagrange(daneH(1,:),daneH(2,:),iks);   

p=plot(daneG(1,:),daneG(2,:),'or',daneH(1,:),daneH(2,:),'sb',iks,igrekG,'.r',iks,igrekH,'.b');
p(1).MarkerSize = 8;
xlabel('x');
ylabel('y');
title("Interpolacja Lagrange'a");
legend('G(x)','H(x)');

g_8_8 = igrekG(3)
h_8_8 = igrekH(3)

%% FUNKCJE
function [igrek] = interp_lagrange(x,y,iks)
igrek = zeros(1, size(iks,2));
for s=1:size(iks,2)
    suma = 0;
    for i=1:size(x,2)
        mnoz = 1;
        for k=1:size(x,2)
            if k==i
                continue
            end
            mnoz=mnoz*(iks(s)-x(k))/(x(i)-x(k));  %iks[i]
        end
    suma = suma + y(i)*mnoz;
    end
igrek(s) = suma;
end
end

function [igrek] = interp_newton(x,y,iks)
sz = size(x,2);
rozn = zeros(sz);
igrek = zeros(1, size(iks,2));

for k=1:sz %wypelnianie rozn
    rozn(k,1)=y(k);
end  
for i=2:sz
    for k=1:sz-i+1
        rozn(k,i)=(rozn(k+1,i-1)-rozn(k,i-1))/(x(k+i-1)-x(k));
    end
end
    
for s=1:size(iks,2) %newton
    suma = 0;
    for i=1:sz
        mnoz = 1;
        for k=1:(i-1)
           mnoz = mnoz*(iks(s)-x(k));
        end
        suma = suma + rozn(1,i) * mnoz;
    end
    igrek(s) = suma;
end

end


