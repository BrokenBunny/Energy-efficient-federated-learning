
% TDMA, Proposed FDMA, EB-FDMA, FE-FDMA
Kuser=20;
vpar=4;

apar=160;


Dpar=5e6;
%user_distribution(Kuser);
load('SystemData_50');
PathLoss_User_BS=PathLoss_User_BS(50-Kuser+1:end);
PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
Noise=-174;%dBm/Hz
Noise=10^(Noise/10)/1e3;

Cpar=20;
kappa=1e-28;
Bandwidth=20e6;
sdata=1e5;
fkmax=2e9;
pkmax=10;%dBm
pkmax=10^(pkmax/10)/1e3;
 

itermax=2e1-1;
Timemar=zeros(5,itermax);
x_ini=2;
x_step=1;
for iter=1:itermax
    
    Bandwidth=x_ini+(iter-1)*x_step;
    Bandwidth=Bandwidth*1e6;
    [Timemar(1,iter),time,band,fre,pow,eta,Timemar(2,iter),Timemar(3,iter)]=...
        CompletionMin(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar);
    
    
    Timemar(5,iter)=CompletionMinTDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar);
end
figure(2)
x_mar=x_ini:x_step:x_ini+(itermax-1)*x_step;
plot(x_mar,Timemar(1,:),'-o',...
    x_mar,Timemar(2,:),'-s',...
    x_mar,Timemar(3,:),'-d',...
    x_mar,Timemar(5,:),'-v','linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Bandwidth (MHz)','fontsize',12);
ylabel('Completion time (s)');
legend('Proposed FDMA','EB-FDMA','FE-FDMA','TDMA')
set(gca,'fontsize',12);
grid on;
