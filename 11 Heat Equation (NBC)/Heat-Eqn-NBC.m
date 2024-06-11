% Math 529L HW5
% 2/26/23
% Jun Ikeda

clear; close; clc;

% k = k/(c*rho)
k = 0.3;

%spatial discretization
xl = 0;
xr = 1;
h = 0.25;
x = xl:h:xr;

yl = 0;
yr = 1;
y = yl:h:yr;

%temporal discretization
tl = 0;
tr = 5;
dt = 0.1;
t = tl:dt:tr;

%store soln.
T = zeros(length(x),length(y),length(t));
T(:,end,:) = 100;
T(:,1,:) = 0;

surf(x,y,T(:,:,1)')

for g = 2:length(t)
    for i = 2:length(x)-1
        for  j = 2:length(y)-1
            T(i,j,g) = T(i,j,g-1) + dt*k/h^2 * (T(i+1,j,g-1) + T(i-1,j,g-1)...
                + T(i,j+1,g-1) + T(i,j-1,g-1) - 4*T(i,j,g-1));
        end
    end
    T(1,:,g) = T(2,:,g);
    T(end,:,g) = T(end-1,:,g);
    surf(x,y,T(:,:,g)')
    colorbar
    pause(0.01)
    exportgraphics(gcf,'testAnimated.gif','Append',true);
end