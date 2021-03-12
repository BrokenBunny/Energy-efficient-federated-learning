%3-tier heteerogeneous network
%% System parameters
function user_distribution(Num_User)
temp=Num_User;
Num_User=Num_User*1;
Bandwidth=10;%MHz
Noise=-104;%dBm  -174dBm/Hz
%% Area: Square
l=0.5;  % 1km* 1km

%power limits
p_max=30; %dBm machine 

%% Users

BS_loc=[.5; .5]*l;

User_loc=rand(2,Num_User)*l;


Distance_User=max(1000*sqrt(sum((repmat(BS_loc,1,Num_User)-User_loc).^2)),1)'/1e3;

PathLoss_User_BS=128.1+37.6*log10(Distance_User);
%PathLoss_User_BS=60+randint(1,Num_User, [1 100])/50;
sigma=8;%dB
PathLoss_User_BS=PathLoss_User_BS+generate_shadow_fading(0,sigma,Num_User,1);
PathLoss_User_BS=sort(PathLoss_User_BS,'ascend');
PathLoss_User_BS=PathLoss_User_BS(1:temp);
%% Date save
save('SystemData.mat','PathLoss_User_BS');

%% Figre plot

% figure(1)
% plot(BS_loc(1,1),BS_loc(2,1),'^','Markersize',10,'Markerfacecolor',[0,0,0],'MarkerEdgecolor','k');
% hold on;
% plot(User_loc(1,:),User_loc(2,:),'*k');
% xlabel('km');
% ylabel('km');
% legend('BS','UE');
% xlim([0,l]);
% ylim([0,l]);