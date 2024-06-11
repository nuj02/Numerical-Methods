function xn_plus = Newton_Rapshon_Method(func,xn,tol,max_it,diffeq)

%NEWTON_RAPSHON_METHOD to find roots of continuous function 

for i = 1:max_it
    xn_plus = xn - func(xn)/diffeq(xn);
    if abs(xn_plus-xn) < tol
        break
    end
    xn = xn_plus;
end

end

