function weights = weights(centroids, spectrum, sparse_penalty, basis)

if(nargin < 4)
   basis = 2:24;
end

A = centroids(basis,:);
b = spectrum(basis,:);

param.lambda=sparse_penalty;
param.pos = 1;
param.mode = 2;

weights = mexLasso(b,A,param);
%weights = pinv(A) * b;
end