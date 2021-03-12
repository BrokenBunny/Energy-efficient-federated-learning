function [Lognormal_fade]=generate_shadow_fading(mean,sigma,x,y)
% 本函数生成对数正态分布的阴影衰落
%mean:均值 dB
%sigma：标准差 dB
%x*y:矩阵维度
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