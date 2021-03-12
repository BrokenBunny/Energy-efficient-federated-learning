%clc;clear;close all;
band=1e6;
Noise=-174;
Noise=10^(Noise/10);


P=1;
P=10^((P-30)/10);

Num_User_max=10;
NumUserMar=2:2:Num_User_max;
parmeter_num=length(NumUserMar);

Timemar=zeros(6,parmeter_num);



iter_num=5e2;

delay=zeros(parmeter_num,iter_num);

for iter=1:iter_num
    user_distribution(Num_User_max);
    Num_User=Num_User_max;
    load('SystemData2.mat');%save('SystemData2.mat','p_max','PathLoss_User_BS','Noise');
    PathLoss_User_BS=PathLoss_User_BS(1:Num_User);
    PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
    
    for i_num_user=1:parmeter_num
        Num_User=NumUserMar(i_num_user);
        load('SystemData2.mat');%save('SystemData2.mat','p_max','PathLoss_User_BS','Noise');
        PathLoss_User_BS=PathLoss_User_BS(1:Num_User);
        PathLoss_User_BS=10.^(-PathLoss_User_BS/10);
        
        band=1e6;
        Noise=-174;
        Noise=10^(Noise/10);
        
        P=1;
        P=10^((P-30)/10);
        
        Ratedemand=ones(Num_User,1)*1e6*1;%%for all the users
        
        Num_group=ceil(Num_User/2);
        PathlossSW=userpairingSW(PathLoss_User_BS,Num_group);
        delaymin=TimeMinRSMA(Noise,Num_User,PathLoss_User_BS,band,Ratedemand,P);
        Timemar(1,i_num_user)=Timemar(1,i_num_user)+delaymin;
        Timemar(2,i_num_user)=Timemar(2,i_num_user)+TimeMinNOMA(Noise,Num_User,PathLoss_User_BS,band,Ratedemand,P);
        delaymax=TimeMinFDMA(Noise,Num_User,PathLoss_User_BS,band,Ratedemand,P);
        Timemar(3,i_num_user)=Timemar(3,i_num_user)+delaymax;
        Timemar(5,i_num_user)=Timemar(5,i_num_user)+TimeMinTDMA(Noise,Num_User,PathLoss_User_BS,band,Ratedemand,P);
        
        Timemar(6,i_num_user)=Timemar(6,i_num_user)+TimeMinRSMAUser2Group(Noise,Num_User,PathlossSW,band,Ratedemand,P,...
            Num_group,delaymin,delaymax);
 
        
    end
end


Timemar=Timemar/iter_num;

figure(6);
x_mar=NumUserMar;
plot(x_mar,Timemar(1,:),'-o',...
    x_mar,Timemar(2,:),'-s',...
    x_mar,Timemar(3,:),'-d',...
    x_mar,Timemar(5,:),'-v','linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Number of users','fontsize',12);
ylabel('Delay (s)');
legend('RSMA','NOMA','FDMA','TDMA')
set(gca,'fontsize',12);
grid on;


test=0;

