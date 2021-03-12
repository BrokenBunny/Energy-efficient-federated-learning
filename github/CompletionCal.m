function TFE=...
    CompletionCal(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,eta)


fre=ones(Kuser,1)*fkmax;
pow=ones(Kuser,1)*pkmax;



 time=zeros(Kuser,1);
Tmax=0;

Akpar=vpar*Cpar*Dpar;
iter_max=2e1;
epsilon=1e-5;
etaini=eta;
bandini=ones(Kuser,1)*Bandwidth/Kuser;

Tmin2=Akpar/min(fre)*apar*(-log2(etaini)/(1-etaini));


Tmax2=0;
for id_k=1:Kuser
    time(id_k)=sdata/(bandini(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(bandini(id_k)*Noise)));
    Tmax2=max(Tmax,apar/(1-etaini)*(Akpar*log2(1/etaini)/fre(id_k)+time(id_k)));
end

for iter=1:iter_max
    TFE=(Tmin2+Tmax2)/2;
    [time2,band2,sumban]=CtimefixeEta(TFE,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
        Noise,sdata,Bandwidth,etaini);
    if sumban<Bandwidth
        Tmax2=TFE;
    else
        Tmin2=TFE;
    end
end

