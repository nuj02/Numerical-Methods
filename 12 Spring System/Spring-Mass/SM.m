clear; close; clc; 

%% simple spring mass system
% Parameters 
k = 20; %spring constant 
m = 20; %mass
c = 40; %damping
b = 10; %external force

% time discretization
tleft = 0;
tright = 20;
dt = 0.001;
t = tleft:dt:tright;

%store velocity (x2) and displacement (x1)
x = zeros(2,length(t));
x(:,1) = [0;0];

for i = 2:length(t)
    x(:,i) = x(:,i-1) + dt*[x(2,i-1);1/m*(-k*x(1,i-1)+b-c*x(2,i-1))+x(2,i-1)];
end

figure(1)
plot(t,x(1,:))
xlabel("time")
ylabel("displacement")

figure(2)
plot(t,x(2,:))
xlabel("time")
ylabel("velocity")