% Math 529L WS2
% 1/19
% Jun Ikeda

%%
clear all; close all; clc;

y(1) = 1; 

dt = 0.1;
T = 0:dt:1;

max_it = 100;
tol = 1.e-5;

f = @(x) x-y(i-1)+dt*x^2;
df = @(x) 1+2*dt*x;

for i = 2:length(T)
  Secant_Method(0,1.e-5,f,df)
end

figure
plot(tol)
y_exact = @(t) 1./(1+t);
plot(T,y_exact(T))


