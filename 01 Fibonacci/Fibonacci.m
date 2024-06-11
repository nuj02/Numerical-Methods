% Math 529L WS1 
% 1/12
% Jun Ikeda

%% In-Class Problems
clear; close; clc

fibSeq = ones(1,10);
fibSeq(2) = 2;

for i = 3:length(fibSeq)
    fibSeq(i) = fibSeq(i-2) + fibSeq(i-1);
end

figure
plot(fibSeq)
title("First 10 members of Fibonacci Sequence")
xlabel("Fibonacci Sequence Index")
ylabel("Fibonacci Number")

fibSeqRat = zeros(1,length(fibSeq)-1);
for i = 2:length(fibSeq)-1
    fibSeqRat(i) = fibSeq(i-1)/fibSeq(i+1);
end

figure
plot(1:length(fibSeqRat),fibSeqRat)
title("Evolution of Ratio between Two Adjacent Terms of Fibonacci Sequence")
xlabel("Fibonacci Sequence Index")
ylabel("Ratio")

function C = matrixMult(A,B)
    if size(A,2) == size(B,1)
        C = A*B;
    else
        fprint("Multiplication is not valid")
    end
end