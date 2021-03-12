
% TDMA, Proposed FDMA, EB-FDMA, FE-FDMA
Kuser=50;
vpar=4;

apar=160;


Dpar=5e2;
%user_distribution(Kuser);
load('SystemData_50');
PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
Noise=-174;%dBm/Hz
Noise=10^(Noise/10)/1e3;

Cpar=2e5;
kappa=1e-28;
Bandwidth=20e6;
sdata=1e5;
fkmax=2e9;

pkmax=20;%dBm
pkmax=10^(pkmax/10)/1e3;
 
Akpar=vpar*Cpar*Dpar;



[Tcom,time,band,fre,pow,eta,TEB,TFE]=CompletionMin(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar);
[eta,time,band,sumban,etamar1]=CtimeEta(Tcom,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
    Noise,sdata,Bandwidth);

sdata=2e5;



[Tcom,time,band,fre,pow,eta,TEB,TFE]=CompletionMin(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar);
[eta,time,band,sumban,etamar2]=CtimeEta(Tcom,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
    Noise,sdata,Bandwidth);

sdata=3e5;


[Tcom,time,band,fre,pow,eta,TEB,TFE]=CompletionMin(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar);
[eta,time,band,sumban,etamar3]=CtimeEta(Tcom,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
    Noise,sdata,Bandwidth);



figure(5)
numax=98;
temp=50:numax+2;
x_mar=temp/(numax+1);
 
plot(x_mar,etamar1(temp)/1e6,'-o',...
    'linewidth',2);
hold on;
temp=38:numax+2;
x_mar=temp/(numax+1);
plot(x_mar,etamar2(temp)/1e6,'-s',...
    'linewidth',2);
hold on;
temp=30:numax-5;
x_mar=temp/(numax+1);
plot(x_mar,etamar3(temp)/1e6,'-d',...
    'linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Local accuracy \eta','fontsize',12);
ylabel('Function value {\it u_k}({\it v_k}(\it{\eta}))');

legend('{\it s}=100 Kbits','{\it s}=200 Kbits','{\it s}=300 Kbits')
set(gca,'fontsize',12);
grid on;
