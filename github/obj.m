function val=obj(xvar)

load objcalpar
 
time=xvar(1:Kuser);
band=xvar(1+Kuser:Kuser*2);
fre=xvar(1+Kuser*2:Kuser*3);
pow=xvar(1+Kuser*3:Kuser*3+Kuser);
eta=xvar(1+Kuser+Kuser*3);



val=apar/(1-eta)*(kappa*Akpar*sum(fre.^2)*log2(1/eta)+...
    sum(time.*pow));
