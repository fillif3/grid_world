function out= func(u,x,To)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pa = 1.2;
fi=3;
g=9.81;
H=5;
Ca=1005 ;
Tref=21+273;
deltaT=20*60;
beta=10^6;
m = pa*u*fi*sqrt(2*g*H*max(0,(x-To)/x));
out = m*Ca*abs(x-Tref)*deltaT+beta*(x-Tref)^2;
end