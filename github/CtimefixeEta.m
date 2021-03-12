function   [timemar,banmar,sumban]=CtimefixeEta(Tcom,fre,pow,Akpar,apar,Kuser,PathLoss_User_BS,...
    Noise,sdata,Bandwidth,eta)
 

maxNum=1e2;
opteta=0;
etamar=zeros(maxNum,1);
timemar=zeros(Kuser,1);
banmar=zeros(Kuser,1);
timetest=zeros(Kuser,1);





 
temp=Akpar/min(fre)*apar*(-log2(eta)/(1-eta));
if temp<Tcom
    for iduser=1:Kuser
        timemar(iduser)=(1-eta)*Tcom/apar+Akpar*log2(eta)/fre(iduser);
        temp=sdata/timemar(iduser);
        maxtemp=Bandwidth*...
            log2(1+PathLoss_User_BS(iduser)*pow(iduser)/(Bandwidth*Noise));
        band_min=0;
        band_max=Bandwidth;
        if maxtemp>temp
            iter_max=2e1;
            for iter=1:iter_max
                banmar(iduser)=(band_min+band_max)/2;
                temp2=banmar(iduser)*...
                    log2(1+PathLoss_User_BS(iduser)*pow(iduser)/(banmar(iduser)*Noise));
                
                if temp2>temp
                    band_max=banmar(iduser);
                else
                    band_min=banmar(iduser);
                end
            end
            
            %                 temp2=-log(2)*Noise*temp/(PathLoss_User_BS(iduser)*pow(iduser));
            %
            %                 banmar(iduser)=-temp*log(2)/...
            %                     (lambertw(temp2*exp(temp2))+temp2);
        else
            banmar(iduser)=Bandwidth;
        end
        
        
        
        timetest(iduser)=sdata/(banmar(iduser)*...
            log2(1+PathLoss_User_BS(iduser)*pow(iduser)/(banmar(iduser)*Noise)));
    end
    
end
sumban=sum(banmar);

testpar=0;
