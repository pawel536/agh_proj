%% ARMA 1
close all; clear; clc;
Fs=100;
t=0:(1/Fs):10;
x=1*sin(2*pi*t*10) + 0.8*sin(2*pi*t*7) + t/5;
xs = x + 0.2*randn(size(x));
%plot(t,x,'r', t, xs, 'b');

%wiemy t0-8 zgadujemy t9-10

NN = 799;
xs=xs';  %potrz kolumnowe
model=arima(13,1,3);  %arima(p,D,q);

pres=xs(1:model.P); %przed
estym=xs(1+model.P:NN);
przed=xs(NN-model.P:NN);

model_est=estimate(model,estym,'Y0',pres);
przewid=forecast(model_est,100,przed);

plot(t,x,'g',t(NN:NN+99),przewid,'k');

%% ARMA 2
close all; clear; clc;
load Data_EquityIdx
xs = DataTable.NASDAQ;
t=1:length(xs);

%wiemy t0-8 zgadujemy t9-10

NN = 1599;  % ile wiem
model=arima(13,1,12);  %arima(p,D,q);
pres=xs(1:model.P); %przed
estym=xs(1+model.P:NN);
przed=xs(NN-model.P:NN);

model_est=estimate(model,estym,'Y0',pres);
przewid=forecast(model_est,100,przed);
plot(t,xs,'g',t(NN:NN+99),przewid,'k');
xlim([NN-100,NN+150]);

%% KLASTERYZACJA
close all; clear; clc;
a=load('klaster1.txt');
subplot(121);
scatter(a(:,1),a(:,2),[],a(:,3),'filled');
%[grupa, C]=kmeans(a(:,1:2),4);
%[grupa, C]=kmedoids(a(:,1:2),4);
grupa=clusterdata(a(:,1:2),'MaxClust',4 ,'distance','Cityblock');
subplot(122);
scatter(a(:,1),a(:,2),[],grupa,'filled'); hold on
%plot(C(:,1),C(:,2),'xk','MarkerSize',20,'LineWidth',3);
hold off

