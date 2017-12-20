function result = guidance_convex(D,y,beta,maxiter);
%This function returns the leadindex by convex optimization.
[mmm nnn] = size(D);
g = D'*beta;
gamma = y-D*g;
eta = D*(D'*gamma);
epsilon = (gamma'*eta)/(eta'*eta);
t=0;    %times of iteration
while t < maxiter
    new_beta = beta + epsilon*gamma;
    new_gamma = gamma - epsilon*eta;
    new_eta = D*(D'*new_gamma);
    epsilon = (gamma'*eta)/(eta'*eta);
    eta = new_eta;
    gamma = new_gamma;
    beta = new_beta;
    t=t+1;
end

g=D'*beta;
[gs order] = sort(abs(g));
result = order(nnn);

end

