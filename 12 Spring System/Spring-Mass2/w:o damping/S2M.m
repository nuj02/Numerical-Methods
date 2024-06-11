clear; close; clc; 

%% spring and two mass system
% Parameters 
k1 = 20; %spring constant 
m1 = 20; %mass
b = 0; %external force

k2 = 20; %spring constant 
m2 = 20; %mass

% time discretization
tleft = 0;
tright = 20;
dt = 0.001;
t = tleft:dt:tright;

%store velocity and displacement of mass 1 and 2
%x1;x1';x2;x2'
x = zeros(4,length(t));
x(:,1) = [0;0;1;0];

for i = 2:length(t)
    x(1:2,i) = x(1:2,i-1) + dt * [x(2,i-1);...
                                  1/m1*(k2*(x(3,i-1)-x(1,i-1))-k1*x(1,i-1))];
    x(3:4,i) = x(3:4,i-1) + dt * [x(4,i-1);...
                                  1/m2*(-k2*(x(3,i-1)-x(1,i-1))+b)];
end

figure(3)
plot(t,x(1,:))
xlabel("time")
ylabel("displacement")
title("mass 1")

figure(4)
plot(t,x(3,:))
xlabel("time")
ylabel("displacement")
title("mass 2")