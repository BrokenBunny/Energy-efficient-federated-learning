function objmar=...
    TimeEnergyWei2conver(Kuser,vpar,Dpar,PathLoss_User_BS,...
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

varini=[weightTEt_ini*2;time_ini;band_ini;fre_ini;pow_ini;eta_ini];

fre_ini=ones(Kuser,1)*fkmax;
pow_ini=ones(Kuser,1)*pkmax;
band_ini=ones(Kuser,1)*Bandwidth/Kuser;

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

 
varini2=[weightTEt_ini;time_ini;band_ini;fre_ini;pow_ini;eta_ini];

save('objcalpar.mat');
Amar=[zeros(1,1+Kuser),ones(1,Kuser),zeros(1,Kuser*2+1)];
bval=Bandwidth;
lb=zeros(2+Kuser*4,1);
ub=[inf*ones(1,1+Kuser),ones(1,Kuser)*Bandwidth,...
    ones(1,Kuser)*fkmax,ones(1,Kuser)*pkmax,1]';
    options.MaxFunEvals=8e3;
    %options.MaxFunctionEvaluations=9e5;
%options.MaxIter =8e3;
[xvar,fval]= fmincon(@obj,varini,Amar,bval,[],[],lb,ub,@nonlconwei,options);
 
objmar=zeros(1,10);
objmar(1)=obj(varini);

objmar(2)=obj(varini/2+xvar/2);

objmar(3:end)=obj(xvar);


