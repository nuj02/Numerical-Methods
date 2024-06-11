function x1 = Secant_Method(func,a,b,tol,max_it)

%Secant root finding method for continuous function f(x) and a<b

x1 = (a+b)/2;
x0 = a;

for i = 1:max_it
    if abs(x1-x0) < tol
        break
    end
    dx = func(x1)*func(x1-x0)/(func(x1)-func(x0));
    x0 = x1;
    x1 = x1 - dx;
end

end

