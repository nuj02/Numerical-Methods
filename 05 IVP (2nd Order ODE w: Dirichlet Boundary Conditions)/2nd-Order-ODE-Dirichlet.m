% Math 529L inClass Wk4
% 2/5/23
% Jun Ikeda

%% 1 
clear; close; clc

%time step
h = 0.01; 

%boundary conditions
a = -5;
b = 3;

%time discretization
x = 0:h:3;

%form finite difference matrix
A = zeros(length(x));
A = (A + diag(ones(length(x)-1,1),1) + diag(ones(length(x)-1,1),-1)...
    + -2*diag(ones(length(x),1)))*1/h^2;

%enforce boundary conditions
A(1,1) = 1;
A(1,2) = 0;
A(end,end) = 1;
A(end,end-1) = 0;

%matrix containing second order ODE
fVec = exp(x)';
fVec(1) = a;
fVec(end) = b;

%matrix containing numerical solution
uVec = A\fVec;

c2 = -6;
c1 = (9-exp(3))/3;
u = @(t) exp(t)+c1*t+c2;

%calculate error
error = abs(uVec-u(x)');

figure(1)
plot(x,uVec)
title("Numerical Solution to u''(x)=e^x")
xlabel("x")
ylabel("u")

%axis is error vs x, should be error vs stepsize
figure(2)
semilogy(x,error)
title("Loglog error")
xlabel("x")
ylabel("error")
