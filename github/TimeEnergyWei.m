function [weightTEt,weightTEe,time,band,fre,pow,eta,obj_iter,WTE_EBt,WTE_EBe,WET_FEt,WET_FEe]=...
    TimeEnergyWei(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar,weight)

%% intial solution
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
%% iterative algorithm

iter_max=3e1;
obj_iter=zeros(iter_max*2,1);
epsilon=1e-5;

fre=fre_ini;
pow=pow_ini;
band=band_ini;

time=time_ini;
eta=eta_ini;

Akpar=vpar*Cpar*Dpar;
for iter=1:iter_max
    %% given T b f p optimize t eta
    for id_k=1:Kuser
        time(id_k)=sdata/(band_ini(id_k)*...
            log2(1+PathLoss_User_BS(id_k)*pow_ini(id_k)/(band_ini(id_k)*Noise)));
    end
    alpha1=apar*Akpar*kappa*sum(fre_ini.^2);
    alpha2=apar*sum(time.*pow_ini);
    
    
    maxNum=1e2;
    etavaluemar=zeros(maxNum,1);
    optmin=inf;
flag=0;
    for idnum=1:maxNum
        temp=1/(maxNum+1)*idnum;
        for id_user=1:Kuser
tempT=apar/(1-temp)*(Akpar*log2(1/temp)/fre_ini(id_k)+time(id_k));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
        etavaluemar(idnum)=(-log2(temp)*alpha1+alpha2)/(1-temp);
    end
    
    
    %% optimize T b f p given t eta
    
    
end


