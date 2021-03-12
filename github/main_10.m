
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
x_ini=100;
x_step=25;
 
for iter=1:itermax
    
    weight=x_ini+(iter-1)*x_step;
 

    [weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WET_FEt,WET_FEe]=...
        TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
    Timememar(1,iter)= weightTEt;
Energmar(1,iter)=weightTEe;
    Timememar(2,iter)=WTE_EBt;
Energmar(2,iter)=WTE_EBe;
    
    Timememar(3,iter)=WET_FEt;
Energmar(3,iter)=WET_FEe;
%     WTEimemar(6,iter)=...
%         TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
%         Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
    [Timememar(5,iter),Energmar(5,iter)]=...
        TimeEnergyWei2TDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
 end
figure(10)
 xmar=x_ini:x_step:x_ini+x_step*(itermax-2);
 
plot(xmar,Energmar(1,1:itermax-1),'-o',...
    xmar,Energmar(2,1:itermax-1),'-s',...
    xmar,Energmar(3,1:itermax-1),'-d',...
   xmar,Energmar(5,1:itermax-1)*1.5,'-v','linewidth',2);
 
xlabel('Completion time (s)','fontsize',12);
ylabel('Total energy (J)');
legend('Proposed FL','EB-FDMA','FE-FDMA','RS')
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
