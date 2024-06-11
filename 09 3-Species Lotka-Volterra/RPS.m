% Math 529L Wk8 InClass
% 3/2/23
% Jun Ikeda
%%
clear; close; clc 

%time discretization
tleft = 0;
tright = 10;
n = 100;
dt = (tright-tleft)/n;
time = tleft:dt:tright;

miu = 0.1;
sigma = 0.2;
pa = 0.4;
pb = 0.1;
pc = 0.8;

Y = [1/3;1/3;1/3];
F = @(Y) [Y(1)*(miu*(1-sum(Y))-sigma*Y(3)-pa/2*Y(1));...
    Y(2)*(miu*(1-sum(Y))-sigma*Y(1)-pb/2*Y(2));...
    Y(3)*(miu*(1-sum(Y))-sigma*Y(2)-pa/2*Y(3))];

for i = 2:length(time)
    Y(:,i) = Y(:,i-1)+F(Y(:,i-1))*dt;
end

plot(time,Y)

