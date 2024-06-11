% SEIR Model HW
% Jun Ikeda
% 4/10/23

clear;close;clc

%% SEIR Model

%Gamma is constant birth rate
Gamma = 10; 
%infection rate
beta = 0.3;
%incubation period
sigma = 0.1;
%recovery rate
gamma = 0.2;
%per-death capital death rate
miu = 0.001;

Rnaught = beta*(gamma+miu)^-1*sigma*(sigma+miu)^-1;
initial = (40000-Rnaught)/3;

%time discretization
lt = 0; 
rt = 1000; 
n = 1000;
dt = (rt-lt)/n;
time = lt:dt:rt;

%susceptible;incubation;infected;recovered
SEIR = zeros(4,length(time));

%initial conditions
SEIR(:,1) = [initial;...
            initial;...
            initial;...
            Rnaught];

for i = 2:length(time)
    N = sum(SEIR(:,i-1));
    SEIR(:,i) = SEIR(:,i-1) + dt*[Gamma-beta*SEIR(1,i-1)*SEIR(3,i-1)/N-miu*SEIR(1,i-1);...
                                beta*SEIR(1,i-1)*SEIR(3,i-1)/N-sigma*SEIR(2,i-1)-miu*SEIR(2,i-1);...
                                sigma*SEIR(2,i-1)-gamma*SEIR(3,i-1)-miu*SEIR(3,i-1);...
                                gamma*SEIR(3,i-1)-miu*SEIR(4,i-1)];
end

figure(1)
plot(time,SEIR(1,:))
hold on
plot(time,SEIR(2,:))
plot(time,SEIR(3,:))
plot(time,SEIR(4,:))
legend(["Susceptible","Incubation","Infected","Recovered"])
