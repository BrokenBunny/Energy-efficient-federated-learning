function [Lognormal_fade]=generate_shadow_fading(mean,sigma,x,y)
% ���������ɶ�����̬�ֲ�����Ӱ˥��
%mean:��ֵ dB
%sigma����׼�� dB
%x*y:����ά��
% Email: xuhao2013@seu.edu.cn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2015-11-12: Complete
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigma=10^(sigma/10);
mean=10^(mean/10);
m = log((mean^2)/sqrt(sigma^2+mean^2));
sigma= sqrt(log(sigma^2/(mean^2)+1));
Lognormal_fade=lognrnd(m,sigma,x,y);