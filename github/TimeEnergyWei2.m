function [weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WTE_FEt,WTE_FEe,weightTEecom]=...
    TimeEnergyWei2(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight)

%% intial solution
fre_ini=ones(Kuser,1)*fkmax;
pow_ini=ones(Kuser,1)*pkmax;
band_ini=ones(Kuser,1)*Bandwidth/Kuser/2;

time_ini=zeros(Kuser,1);
eta_ini=1/2;
weightTEt_ini=0;

Akpar=vpar*Cpar*Dpar;

for id_k=1:Kuser
    time_ini(id_k)=sdata/(band_ini(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow_ini(id_k)/(band_ini(id_k)*Noise)));
    weightTEt_ini=max(weightTEt_ini,apar/(1-eta_ini)*(Akpar*log2(1/eta_ini)/fre_ini(id_k)+time_ini(id_k)));
end
%%

Akpar=vpar*Cpar*Dpar;
 
varini=[time_ini;band_ini;fre_ini;pow_ini;eta_ini];

save('objcalpar.mat');
Amar=[zeros(1,Kuser),ones(1,Kuser),zeros(1,Kuser*2+1)];
bval=Bandwidth;
lb=zeros(1+Kuser*4,1);
ub=[inf*ones(1,Kuser),ones(1,Kuser)*Bandwidth,...
    ones(1,Kuser)*fkmax,ones(1,Kuser)*pkmax,1]';
    options.MaxFunEvals=8e3;
    %options.MaxFunctionEvaluations=9e5;
%options.MaxIter =8e3;
[xvar,fval]= fmincon(@obj,varini,Amar,bval,[],[],lb,ub,@nonlconwei,options);

weightTEt=weight;
time=xvar(1:Kuser);
band=xvar(1+Kuser:Kuser*2);
fre=xvar(1+Kuser*2:Kuser*3);
pow=xvar(1+Kuser*3:Kuser*3+Kuser);
eta=xvar(1+Kuser+Kuser*3);


weightTEe=apar/(1-eta)*(kappa*Akpar*sum(fre.^2)*log2(1/eta)+...
    sum(time.*pow));

weightTEecom=apar/(1-eta)*sum(time.*pow);

obj_iter=0;
WTE_EBt=0;
for id_k=1:Kuser
    time_ini(id_k)=sdata/(band_ini(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(band_ini(id_k)*Noise)));
    WTE_EBt=max(WTE_EBt,apar/(1-eta)*(Akpar*log2(1/eta)/fre(id_k)+time_ini(id_k)));
end
WTE_EBe=apar/(1-eta)*(kappa*Akpar*sum(fre.^2)*log2(1/eta)+...
    sum(time_ini.*pow));
WTE_EBe=WTE_EBe*WTE_EBt/weight;
WTE_FEt=0;
for id_k=1:Kuser
    time_ini(id_k)=sdata/(band(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(band(id_k)*Noise)));
    WTE_FEt=max(WTE_FEt,apar/(1-eta_ini)*(Akpar*log2(1/eta_ini)/fre(id_k)+time_ini(id_k)));
end
WTE_FEe=apar/(1-eta_ini)*(kappa*Akpar*sum(fre.^2)*log2(1/eta_ini)+...
    sum(time_ini.*pow));

WTE_FEe=WTE_FEe*WTE_FEt/weight;

