function val=obj2(xvar)

load objcalpar2
weightTEt=weight;
time=xvar(1:Kuser);
fre=xvar(1+Kuser:Kuser*2);
pow=xvar(1+Kuser*2:Kuser*3);
eta=xvar(1+Kuser*3);


val=apar/(1-eta)*(kappa*Akpar*sum(fre.^2)*log2(1/eta)+...
    sum(time.*pow));
