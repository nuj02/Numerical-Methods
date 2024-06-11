% Math 529L HW6
% 3/27/23
% Jun Ikeda

clear; close; clc;

% k = k/(c*rho)
k = 0.3;

%spatial discretization
xl = 0;
xr = 1;
h = 0.2;
x = xl:h:xr;
n = length(x);

yl = 0;
yr = 1;
y = yl:h:yr;

%temporal discretization
tl = 0;
tr = 5;
dt = 0.05;
t = tl:dt:tr;

%store soln.
T = zeros(n,n,length(t));
T(:,end,:) = 100;
T(:,1,:) = 0;

%finite difference matrix
B = spdiags([ones(n,1),ones(n,1)*-4,ones(n,1)],-1:1,n,n);
D = eye(n);
D(1,:) = 0;
D(end,:) = 0;

C = spdiags([ones(n,1),zeros(n,1),ones(n,1)],-1:1,n,n); 
C(1,:) = zeros(n,1);
C(end,:) = zeros(n,1);

A = kron(D,B) + kron(C,eye(n));

surf(x,y,T(:,:,1)')
colorbar
pause(0.1)

T = reshape(T,[n*n,length(t)]);
I = eye(n*n);

for i = 2:length(t)
    T(:,i) = (I+dt*k/h^2*A)*T(:,i-1);
    
    T = reshape(T,[length(x),length(y),length(t)]);
    T(1,:) = T(2,:);
    T(end,:) = T(end-1,:);

    surf(x,y,T(:,:,i)')
    colorbar
    pause(0.1)

    T = reshape(T,[n*n,length(t)]);

    exportgraphics(gcf,'testAnimated.gif','Append',true);
end