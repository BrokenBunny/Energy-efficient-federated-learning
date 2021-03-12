
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

tic;
weight=0.5;
[weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WET_FEt,WET_FEe]=...
TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);


[weightTEttdma,weightTEetdma]=...
TimeEnergyWei2TDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight);
toc;
testpar=0;
