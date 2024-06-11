% Math 529L HW4
% 2/26/23
% Jun Ikeda

clear; close; clc;

%spatial discretization
xleft = 0;
xright = 1;
% dx = 0.1;
dx = [0.2,0.1,0.01];

%time discretization
tleft = 0;
tright = 2;
% dt = 0.005;
dt = [0.05,0.005,0.0005];

for i = 1:length(dx)
    x = xleft:dx(i):xright;
    t = tleft:dt(i):tright;

    %finite difference matrix
    A = zeros(length(x));
    A = (A + diag(ones(length(x)-1,1),1) + diag(ones(length(x)-1,1),-1)...
        + -2*diag(ones(length(x),1)));
    Atilde = eye(size(A))-dt(i)/dx(i)^2*A;

    %boundary conditions
    Atilde(1,1) = 1;
    Atilde(1,2) = 0;
    Atilde(end,end) = 1;
    Atilde(end,end-1) = 0;

    %store solution
    U = zeros(length(x),length(t));
    U(:,1) = 100.*x.*(1-x);

    for j = 2:length(t)
        U(:,j) = Atilde\U(:,j-1);
    end

    figure(i)
    surf(t',x',U)
    title(strcat("dt = ",num2str(dt(i))," dx = ",num2str(dx(i))))
end