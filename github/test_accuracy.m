numax=80;
temp=1:numax;
x_mar=temp/(numax+1);
etamar3=1e3*(log2(1./x_mar)+.1)./(1-x_mar);

plot(x_mar,etamar3(temp),'-d',...
    'linewidth',2);
xlim([min(x_mar),max(x_mar)]);
xlabel('Local accuracy \eta','fontsize',12);
ylabel('Total number of iterations');
set(gca,'fontsize',12);
grid on;