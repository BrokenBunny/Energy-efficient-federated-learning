function [Tcom,time,band,fre,pow,eta,TEB,TFE,avetr,avetr2]=CompletionMin(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar)

fre=ones(Kuser,1)*fkmax;
pow=ones(Kuser,1)*pkmax;



band=ones(Kuser,1)*Bandwidth/Kuser;
time=zeros(Kuser,1);
Tmax=0;

Akpar=vpar*Cpar*Dpar;
maxNum=1e2;
etavaluemar=zeros(maxNum,1);
for idnum=1:maxNum
    eta=1/(maxNum+1)*idnum;
    etavaluemar(idnum)=-log2(eta)/(1-eta);
end
Tmin=Akpar/min(fre)*apar*min(etavaluemar);


eta=1/2;
for id_k=1:Kuser
    time(id_k)=sdata/(band(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(band(id_k)*Noise)));
    Tmax=max(Tmax,apar/(1-eta)*(Akpar*log2(1/eta)/fre(id_k)+time(id_k)));
end
 
 

TEB=Tmax;
%% a function of eta, etamar with given T
iter_max=5e1;
epsilon=1e-5;
iter_max=min(iter_max,log2(1/epsilon));
for iter=1:iter_max
    Tcom=(Tmin+Tmax)/2;
    [eta,time,band,sumban,etamar]=CtimeEta(Tcom,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
        Noise,sdata,Bandwidth);
    if sumban<Bandwidth
        Tmax=Tcom;
    else
        Tmin=Tcom;
    end
end

avetr=max(time)*apar/(1-eta);

%% a function of eta, etamar with given T
etaini=3/5;
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
avetr2=max(time2)*apar/(1-eta);
testpar=0;




