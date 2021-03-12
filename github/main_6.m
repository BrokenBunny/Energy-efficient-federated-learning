
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

Cpar=2/1e3;
kappa=1e-28*(1e9)^3;
Bandwidth=20e0;% MHz
sdata=2.81e5/1e6;%Mbits
fkmax=2e0;%G Hz
pkmax=10;%dBm
pkmax=10^(pkmax/10)/1e3;
 


weight=300;


itermax=1e1;
WTEimemar=zeros(6,itermax);
x_ini=2;
x_step=2;
for iter=1:itermax
    
    pkmax=x_ini+(iter-1)*x_step;
    pkmax=10^(pkmax/10)/1e3;
    [weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WET_FEt,WET_FEe]=...
        TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
    WTEimemar(1,iter)=weight*weightTEt+(1-weight)*weightTEe;
    WTEimemar(2,iter)=weight*WTE_EBt+(1-weight)*WTE_EBe;
    
    WTEimemar(3,iter)=weight*WET_FEt+(1-weight)*WET_FEe;
%     WTEimemar(6,iter)=...
%         TimeEnergyWei2exh(Kuser,vpar,Dpar,PathLoss_User_BS,...
%         Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    
    [weightTEttdma,weightTEetdma]=...
        TimeEnergyWei2TDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
    WTEimemar(5,iter)=weight*weightTEttdma+(1-weight)*weightTEetdma;
end
figure(6)
x_mar=x_ini:x_step:x_ini+(itermax-1)*x_step;
plot(x_mar,WTEimemar(1,:),'-o',...
    x_mar,WTEimemar(2,:),'-s',...
    x_mar,WTEimemar(3,:),'-d',...
    x_mar,WTEimemar(1,:),'-^',...
    x_mar,WTEimemar(5,:),'-v','linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Maximal transmit power (dBm)','fontsize',12);
ylabel('Weighted completion time and total energy');
legend('Proposed FDMA','EB-FDMA','FE-FDMA','EXH-FDMA','TDMA')
set(gca,'fontsize',12);
grid on;

