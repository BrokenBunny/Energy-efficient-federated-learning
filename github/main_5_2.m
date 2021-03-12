
% TDMA, Proposed FDMA, EB-FDMA, FE-FDMA
Kuser=20;
vpar=1;
Dpar=5e1; % Mbits
%user_distribution(Kuser);
load('SystemData_50');
PathLoss_User_BS=PathLoss_User_BS(50-Kuser+1:end);
PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
Noise=-174;%dBm/Hz
Noise=10^(Noise/10)/1e3*1e6;

Cpar=20/1e3;
kappa=1e-28*(1e9)^3;
Bandwidth=20e0;% MHz
sdata=1e5/1e6;%Mbits
fkmax=2e0;%G Hz
pkmax=10;%dBm
pkmax=10^(pkmax/10)/1e3;
apar=10;
 
weight=0.2;
objmar1=...
TimeEnergyWei2conver(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);

  
weight=0.5;
objmar2=...
TimeEnergyWei2conver(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);

 
weight=0.8;
objmar3=...
TimeEnergyWei2conver(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);


figure(52)
x_mar=1:10;
plot(x_mar,objmar1,'-o',...
    x_mar,objmar2,'-s',...
    x_mar,objmar3,'-v',...
    'linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Iteration number');
ylabel('Objective value');
legend('w=0.2','w=0.5','w=0.8')
set(gca,'fontsize',12);
grid on;
