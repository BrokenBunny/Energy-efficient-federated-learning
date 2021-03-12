
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

Cpar=2e1;
kappa=1e-28;
Bandwidth=20e6;
sdata=2.81e4;
fkmax=2e9;
pkmax=10;%dBm
pkmax=10^(pkmax/10)/1e3;


itermax=2e1-1;
Timemar=zeros(5,itermax);
x_ini=.05;
x_step=(.95-x_ini)/itermax;
 
for iter=1:itermax
    
    eta=x_ini+(iter-1)*x_step;
    %eta=10^eta;
    pkmax=1;
    pkmax=10^(pkmax/10)/1e3;
    Timemar(1,iter)=...
        CompletionCal(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,eta);
    
        pkmax=2;
    pkmax=10^(pkmax/10)/1e3;
    Timemar(2,iter)=...
        CompletionCal(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,eta);
   
    
        pkmax=5;
    pkmax=10^(pkmax/10)/1e3;
    Timemar(3,iter)=...
        CompletionCal(Kuser,vpar,Dpar,PathLoss_User_BS,...
        Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,eta);
   
   
end
figure(5)
x_mar=x_ini:x_step:x_ini+(itermax-1)*x_step;
%x_mar=10.^x_mar;
plot(x_mar,Timemar(1,:),'-o',...
    x_mar,Timemar(2,:),'-s',...
    x_mar,Timemar(3,:),'-d','linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Local accuracy \eta','fontsize',12);
ylabel('Completion time (s)');
legend('\it{p}^{max}=1 dBm','\it{p}^{max}=2 dBm','\it{p}^{max}=5 dBm')
set(gca,'fontsize',12);
grid on;
