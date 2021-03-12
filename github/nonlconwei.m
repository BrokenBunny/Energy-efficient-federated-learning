function [c,ceq] = nonlconwei(xvar)
load objcalpar
weightTEt=weight;
time=xvar(1:Kuser);
band=xvar(1+Kuser:Kuser*2);
fre=xvar(1+Kuser*2:Kuser*3);
pow=xvar(1+Kuser*3:Kuser*3+Kuser);
eta=xvar(1+Kuser+Kuser*3);



for id_k=1:Kuser
c(id_k)=apar/(1-eta)*(Akpar*log2(1/eta)/fre(id_k)+time(id_k))-weightTEt;
c(id_k+Kuser)=sdata/time(id_k)-(band(id_k)*...
        log2(1+PathLoss_User_BS(id_k)*pow(id_k)/(band(id_k)*Noise)));
end
 

ceq = [];