function c = Bisection_Method(func,a,b,tol,max_it)

%Bisection root finding method for continuous function f(x) and a<b

sfb = sign(func(b));
i = 0;

while abs(b-1) > tol && i <= max_it
    c = (a+b)/2;
    sfc = sign((func(c)));
    if sfc == sfb
         b = c;
    else
        a = c;
    end
    i = i+1;
end

