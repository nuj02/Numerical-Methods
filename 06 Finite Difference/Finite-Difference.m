% Math 529L inClass Wk6
% 2/16/23
% Jun Ikeda

clear; close; clc

%spatial discretization
xleft = 0;
xright = 1;
dx = 0.1;
x= xleft:dx:xright;

%time discretization
tleft = 0;
tright = 2;
dt = 0.005;
t = tleft:dt:tright;

%finite difference matrix
A = zeros(length(x));
A = (A + diag(ones(length(x)-1,1),1) + diag(ones(length(x)-1,1),-1)...
    + -2*diag(ones(length(x),1)));
Atilde = eye(size(A))+dt/dx^2*A;

%boundary conditions
Atilde(1,1) = 1; 
Atilde(1,2) = 0;
Atilde(end,end) = 1; 
Atilde(end,end-1) = 0;

%store solution
U = zeros(length(x),length(t));
U(:,1) = 100.*x.*(1-x);

for i = 2:length(t)
    U(:,i) = Atilde*U(:,i-1);
end

surf(t',x',U)