function y = ramp_delay(x,delay,ramp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
y = min(1,max(0,(x-delay)/(1/ramp)));
end