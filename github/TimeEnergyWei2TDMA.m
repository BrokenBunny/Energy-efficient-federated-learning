function [weightTEt,weightTEe,trans]=...
    TimeEnergyWei2TDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight)

%% intial solution
fre_ini=ones(Kuser,1)*fkmax/2;
pow_ini=ones(Kuser,1)*pkmax/2;
band_ini=0;
band=0;
time_ini=zeros(Kuser,1);
eta_ini=1/2;
weightTEt_ini=0;

Akpar=vpar*Cpar*Dpar;

for id_k=1:Kuser
    time_ini(id_k)=sdata/(Bandwidth*...
        log2(1+PathLoss_User_BS(id_k)*pow_ini(id_k)/(Bandwidth*Noise)));
end
%%
time_ini=time_ini*1.5;
weightTEt_ini=apar/(1-eta_ini)*(Akpar*log2(1/eta_ini)/min(fre_ini)+sum(time_ini));


Akpar=vpar*Cpar*Dpar;

varini=[time_ini;fre_ini;pow_ini;eta_ini];

save('objcalpar2.mat');

lb=zeros(1+Kuser*3,1);
ub=[inf*ones(1,Kuser),...
    ones(1,Kuser)*fkmax,ones(1,Kuser)*pkmax,1]';
options.MaxFunEvals=8e3;
%options.MaxIter=8e3;
%options.MaxFunctionEvaluations=9e5;
[xvar,fval]= fmincon(@obj2,varini,[],[],[],[],lb,ub,@nonlconwei2,options);

weightTEt=weight;
time=xvar(1:Kuser);
fre=xvar(1+Kuser:Kuser*2);
pow=xvar(1+Kuser*2:Kuser*3);
eta=xvar(1+Kuser*3);


weightTEe=apar/(1-eta)*(kappa*Akpar*sum(fre.^2)*log2(1/eta)+...
    sum(time.*pow));
trans=apar/(1-eta)*sum(time.*pow);


