tic
disp('Start serial calculation of spectral radius')
n = 500;
A = 1000;
a = zeros(n);
for i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
disp('End serial calculation of spectral radius')
toc
