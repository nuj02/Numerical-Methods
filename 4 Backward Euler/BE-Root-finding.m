% Math 529L HW2
% 2/5/23
% Jun Ikeda

%% 
clear; close; clc

%time step 
h = [1/2,1/4,1/8,1/16,1/32];

%time domain boundaries
a = 0;
b = 1;

%Legend
LegendBE = [];

%error array to store max error @ time step
abserror = zeros(1,length(h));

%analytical soln
func = @(x) 1/2*(log(abs(x-1))-log(abs(x+1)))+2;

for i = 1:length(h)
    %initialize time domain
    time = a:h(i):b;

    %intialize where y and y' are stored, first row is y, second row is y'
    y = zeros(2,length(time));
    %initial conditions
    y(1,1) = 2;
    y(2,1) = -1;

    %initalize where abs error is stored
    error = zeros(1,length(time));

    for j = 2:length(time)

        %calculate ykplus for y' from pseudo quadratic function produced by BE
        y(2,j) = Bisection_Method(@(ykplus) 2*h(i)*time(j)*ykplus^2+ykplus-y(2,j-1),...
            -6,6,10e-9,1000);

        %calculate y using BE
        y(1,j) = y(1,j-1)+h(i)*y(2,j);

        %calculate error at each timestep
        error(j) = abs(y(1,j) - func(time(j)));
    end

    %Since the analytical solution is undefined at 1, our numerical
    %solution also becomes undefined and unstable as we get closer and
    %closer to 1. This becomes evident in the rootfinding of ykplus, no
    %root can be found and derivative = -6. We just use points without
    %derivative -6 so that the numerical solution points are stable and 
    %relevant to what we are looking for. 
    ind = find(y(2,:)~=-6);

    %calculate max error for each time step
    abserror(i) = max(error(ind));

    figure(1)
    hold on
    plot(time(ind),y(1,ind))
    hold off

    LegendBE = [LegendBE, strcat("BE \Deltat =",num2str(h(i)))];
end

figure(1)
hold on
plot(time,func(time))
hold off
LegendBE = [LegendBE, "Analytical Solution"];
xlabel("t")
ylabel("y")
title("Numerical Solutions via BE")
legend(LegendBE)

%error analysis is non-linear, a little wonky because we are dealing with
%a numerical solution near instability
figure(2)
plot(h,abserror)
xlabel("h")
ylabel("|error|")
title("Absolute Error b/w Numerical and Analytical Soln.")