function [c,ceq] = nonlconwei2s2(xvar)
load objcalpar2
 
weightTEt=weight;
time=xvar(1:Kuser);
fre=xvar(1+Kuser:Kuser*2);
pow=xvar(1+Kuser*2:Kuser*3);
eta=xvar(1+Kuser*3);


c=zeros(Kuser+1,1);
for id_k=1:Kuser
c(id_k)=sdata/time(id_k)-(Bandwidth*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(Bandwidth*Noise)));
 c(id_k+Kuser)=apar/(1-eta)*(Akpar*log2(1/eta)/fre(id_k)+sum(time(id_k:end)))-weightTEt;
 
end


 

ceq = [];