
% TDMA, Proposed FDMA, EB-FDMA, FE-FDMA
Kuser=20;
vpar=4;

apar=160;


Dpar=5e0;
%user_distribution(Kuser);
load('SystemData_50');
PathLoss_User_BS=PathLoss_User_BS(50-Kuser+1:end);
PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
Noise=-174;%dBm/Hz
Noise=10^(Noise/10)/1e3*1e6;

Cpar=20/1e3;
kappa=1e-28*(1e9)^3;
Bandwidth=20e0;% MHz
sdata=2.81e4/1e6;%Mbits
fkmax=2e0;%G Hz
pkmax=10;%dBm
pkmax=10^(pkmax/10)/1e3;
 

weight=0.5;


itermax=1e1;
Timememar=zeros(6,itermax);
Energmar=zeros(6,itermax);
x_ini=10;
x_step=1;
weight=100; 
for iter=1:itermax
    
    pkmax=x_ini+(iter-1)*x_step;
    pkmax=10^(pkmax/10)/1e3;
    [weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WET_FEt,WET_FEe]=...
        TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
 Energmar(1,iter)=weightTEe;
 Energmar(2,iter)=WTE_EBe;
 Energmar(3,iter)=WET_FEe;
%     WTEimemar(6,iter)=...
%         TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
%         Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
    [Timememar(5,iter),Energmar(5,iter)]=...
        TimeEnergyWei2TDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
 end
figure(6)
 x_mar=x_ini:x_step:x_ini+x_step*(itermax-1);
 
plot(x_mar,Energmar(1,:),'-o',...
    x_mar,Energmar(2,:),'-s',...
    x_mar,Energmar(3,:),'-d',...
    x_mar,Energmar(1,:),'-^',...
    x_mar,Energmar(5,:),'-v','linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Maximum average transmit power (dBm)','fontsize',12);
ylabel('Weighted completion time and total energy');
legend('Proposed FDMA','EB-FDMA','FE-FDMA','EXH-FDMA','TDMA')
set(gca,'fontsize',12);
grid on;


% 
% figure(11)
% xmar=x_ini:x_step:x_ini+x_step*(itermax-1);
% xmar=xmar*200+100;
% plot(xmar,Energmar(1,:),'-o',...
%    xmar,Energmar(2,:),'-s','linewidth',2);
%  
% xlabel('Completion time (s)','fontsize',12);
% ylabel('Total energy (J)');
% legend('Proposed FL','RS')
% set(gca,'fontsize',12);
% grid on;
