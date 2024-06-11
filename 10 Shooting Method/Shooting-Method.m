% Math 529L HW5
% 2/26/23
% Jun Ikeda

clear; close; clc;

%spatial discretization
a = 1;
b = 3;
n = 100;
dx = (b-a)/n;
x = a:dx:b;

%initial conditions
alpha = 17;
beta = 43/3;
tk = (beta-alpha)/(a-b);

%y is y; y'; y''
y = zeros(2,n);
y(1,1) = alpha;

%equation for y''
yxx = @(xn,yn,ypn) 1/8*(32 + 2*xn^3 - yn*ypn);

%rootfinding eqn z''
zxx = @(fy,fyy,z,zx) -1/8*(fy*z + fyy*zx);

%z is z; z'; z''
z = zeros(2,n);
z(1,1) = 0;
z(2,1) = 1;

%equation for RK4
RK4 = @(yn,k1,k2,k3,k4) yn + 1/6*(k1 + 2*k2 + 2*k3 + k4)*dx;

%rootsfinding parameters
max_it = 1000;
tol = 10^-9;

%store error
abserror = [];

%analytical soln
asoln = x.^2+16./x;

for i = 1:max_it
    y(2,1) = tk;
    for j = 2:length(x)
        %Runge Kutta method for y'' to y' to y

        %y'' contains y' and y, calculate slopes for both y' and y to better
        %approximate y' found from RK4 with y''
        k11 = y(2,j-1);
        k12 = yxx(x(j-1), y(1,j-1), y(2,j-1));
        k21 = y(2,j-1) + dx*k12/2;
        k22 = yxx(x(j-1) + dx/2, y(1,j-1) + dx*k11/2, y(2,j-1) + dx*k12/2);
        k31 = y(2,j-1) + dx*k22/2;
        k32 = yxx(x(j-1) + dx/2, y(1,j-1) + dx*k21/2, y(2,j-1) + dx*k22/2);
        k41 = y(2,j-1) + dx*k32;
        k42 = yxx(x(j-1) + dx, y(1,j-1) + dx*k31, y(2,j-1) + dx*k32);

        %calculate y'
        y(2,j) = RK4(y(2,j-1),k12,k22,k32,k42);
        %calculate y
        y(1,j) = RK4(y(1,j-1),k11,k21,k31,k41);

        %Runge Kutta method for z'' to z' to z
        l11 = z(2,j-1);
        l12 = zxx(y(2,j-1),y(1,j-1),z(1,j-1),z(2,j-1));
        l21 = z(2,j-1) + dx*l12/2;
        l22 = zxx(y(2,j-1),y(1,j-1),z(1,j-1)+dx*l11/2,z(2,j-1)+dx*l12/2);
        l31 = z(2,j-1) + dx*l22/2;
        l32 = zxx(y(2,j-1),y(1,j-1),z(1,j-1)+dx*l21/2,z(2,j-1)+dx*l22/2);
        l41 = z(2,j-1) + dx*l32/2;
        l42 = zxx(y(2,j-1),y(1,j-1),z(1,j-1)+dx*l31,z(2,j-1)+l32);

        %calculate z'
        z(2,j) = RK4(z(2,j-1),l12,l22,l32,l42);
        %calculate z
        z(1,j) = RK4(z(1,j-1),l11,l21,l31,l41);
    end

    abserror(:,i) = [tk;max(abs(asoln - y(1,:)))];

    if abs(y(1,end)-beta) <= tol
        break
    end
    tk_plus = tk - (y(1,end)-beta)/z(1,end);
    tk = tk_plus;
end

figure(1)
plot(x,x.^2+16./x)
hold on
plot(x,y(1,:))
xlabel("x")
ylabel("y")
legend(["analytical soln","numerical soln"])
title("y v x")

figure(2)
plot(abserror(1,:),abserror(2,:))
xlabel("y' initial guess")
ylabel("max abs error")
title("error v shooting guess")