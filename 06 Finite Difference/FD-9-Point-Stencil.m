% Math 529L HW3
% 2/19/23
% Jun Ikeda

%% 1 
clear; close; clc

n = 10;
h = 1/n;
xn = 0:h:1;
yn = 0:h:1;

Ai = spdiags([ones(n,1)*-4,ones(n,1)*-20,ones(n,1)*-4],-1:1,n,n);
Aj = spdiags([ones(n,1),ones(n,1)*-4,ones(n,1)],-1:1,n,n);
A = (1/6*h^2)*(kron(eye(n,n),Ai) + kron(spdiags([ones(n,1),zeros(n,1),ones(n,1)],-1:1,n,n),Aj));
