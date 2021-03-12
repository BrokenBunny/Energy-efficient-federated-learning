
% TDMA, Proposed FDMA, EB-FDMA, FE-FDMA
Kuser=50;
vpar=1;
Dpar=5e7;
%user_distribution(Kuser);
load('SystemData');
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
apar=10;

 
testpar=0;
