% Tar begynnelsefördelningen, p, transitionsmatrisen, A, och antalet
% slumpmässiga urval, n, som argument, och returnerar pMat som innehåller
% fördelningar per år.

function pMat = markovChain(p, A, n)
pMat = p;

for i = 1:n
    pMat(:, i+1) = A*pMat(:, i);
end
end