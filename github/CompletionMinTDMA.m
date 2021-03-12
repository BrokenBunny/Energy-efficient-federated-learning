function [Tcom2,trans]=CompletionMinTDMA(Kuser,vpar,Dpar,PathLoss_User_BS,...
    Noise,Cpar,kappa,Bandwidth,sdata,fkmax,pkmax,apar)

maxNum=1e2;
etavaluemar=zeros(maxNum,1);
timemar=zeros(Kuser,1);
for iduser=1:Kuser
    
    timemar(iduser)=sdata/(Bandwidth*...
        log2(1+PathLoss_User_BS(iduser)*pkmax/(Bandwidth*Noise)));
    
end
sumtime=sum(timemar);

Akpar=vpar*Cpar*Dpar;

for idnum=1:maxNum
    eta=1/(maxNum+1)*idnum;
    etavaluemar(idnum)=-Akpar/fkmax*apar*log2(eta)/(1-eta)+apar/(1-eta)*sumtime; 
end



[Tcom2,index]=min(etavaluemar);
eta=1/(maxNum+1)*index;
trans=apar/(1-eta)*sumtime;

