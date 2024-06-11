% Math 529L HW1
% 1/24
% Jun Ikeda

%% 
clear; close; clc

%analytical soln of diff eq
syms y(t)
ode = diff(y,t) == 2*t;
init_cond = y(0) == 1;
p_y(t) = dsolve(ode,init_cond);

%diff eq
diff = @(tprime) 2*tprime;

%time domain start and end
tleft = 0;
tright = 1;

%timestep
stepsize = [0.5,0.2,0.1,0.01];

%Legend
LegendFE = [];
LegendME = [];
LegendFEerr = [];
LegendMEerr = [];

%store abs error for FE and ME approx
abserr = zeros(2,length(stepsize));

for i = 1:4
    % initialize time domain
    time = tleft:stepsize(i):tright;

    %top row of y matrix is for forward Euler
    %bottom row of y matrix is for modified Euler
    y = zeros(2,length(time));

    %initial conditions
    y(:,1) = 1;
    
    %initialize error matrix
    err = zeros(2,length(time));
    
    for j = 1:length(time)-1
        %forward Euler
        y(1,j+1) = y(1,j) + diff(time(j))*stepsize(i);
    
        %modified Euler
        y(2,j+1) = y(2,j) + stepsize(i)/2*(diff(time(j+1))+diff(time(j)));

        %abs error b/w numerical and analytical soln
        %top row of y matrix is for forward Euler
        %bottom row of y matrix is for modified Euler
        err(1,j+1) = abs(y(1,j+1) - p_y(time(j+1)));
        err(2,j+1) = abs(y(2,j+1) - p_y(time(j+1)));
    end
    
    abserr(:,i) = max(err,[],2);

    figure(1)
    hold on
    plot(time,y(1,:))
    hold off
    LegendFE = [LegendFE, strcat("Forward Euler for \Deltat =",num2str(stepsize(i)))];

    figure(2)
    hold on
    plot(time,y(2,:))
    hold off
    LegendME = [LegendME, strcat("Modified Euler for \Deltat =",num2str(stepsize(i)))];

end

figure(1)
hold on
plot(time,p_y(time))
hold off
LegendFE = [LegendFE, "Analytical Solution"];
xlabel("t")
ylabel("y")
title("Numerical Solutions for y^{\prime}=2t via Forward Euler")
legend(LegendFE)

figure(2)
hold on
plot(time,p_y(time))
hold off
LegendME = [LegendME, "Analytical Solution"];
xlabel("t")
ylabel("y")
title("Numerical Solutions for y^{\prime}=2t via Modified Euler")
legend(LegendME)

figure(3)
xlabel("stepsize")
ylabel("max error")
plot(stepsize,abserr(1,:))
title("Absolute Error between FE Numerical Method and Analytical Solution for y^{\prime}=2t")

figure(4)
xlabel("stepsize")
ylabel("max error")
plot(stepsize,abserr(2,:))
title("Absolute Error between ME Numerical Method and Analytical Solution for y^{\prime}=2t")