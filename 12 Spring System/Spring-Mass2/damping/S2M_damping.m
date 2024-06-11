clear; close; clc; 

%% spring and two mass system
% Parameters
m1 = 20; %mass
k1 = 20; %spring constant 
c1 = 5; %damping
b = 0; %external force

m2 = 20; %mass
k2 = 20; %spring constant 
c2 = 5; %damping

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
                                  1/m1*(k2*(x(3,i-1)-x(1,i-1))-k1*x(1,i-1)-c1*x(2,i-1))];
    x(3:4,i) = x(3:4,i-1) + dt * [x(4,i-1);...
                                  1/m2*(-k2*(x(3,i-1)-x(1,i-1))-c2*(x(4,i-1)-x(2,i-1))+b)];
end

figure(1)
plot(t,x(1,:))
xlabel("time")
ylabel("displacement")
title("Displacement of Mass 1")

figure(2)
plot(t,x(3,:))
xlabel("time")
ylabel("displacement")
title("Displacement of Mass 2")

c1 = 0;
c2 = 0;

for i = 2:length(t)
    x(1:2,i) = x(1:2,i-1) + dt * [x(2,i-1);...
                                  1/m1*(k2*(x(3,i-1)-x(1,i-1))-k1*x(1,i-1)-c1*x(2,i-1))];
    x(3:4,i) = x(3:4,i-1) + dt * [x(4,i-1);...
                                  1/m2*(-k2*(x(3,i-1)-x(1,i-1))-c2*(x(4,i-1)-x(2,i-1))+b)];
end

figure(1)
hold on
plot(t,x(1,:))
hold off
legend(["w/ damping","w/o damping"])

figure(2)
hold on
plot(t,x(3,:))
hold off
legend(["w/ damping","w/o damping"])