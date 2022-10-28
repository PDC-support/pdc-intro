tic
disp('Start parallel calculation of spectral radius')
ticBytes(gcp);
n = 500;
A = 1000;
a = zeros(n);
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
tocBytes(gcp)
disp('End parallel calculation of spectral radius')
toc
