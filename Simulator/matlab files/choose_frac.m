function [ frac ] = choose_frac( initial_frac, mat, alpha2 )

% Program to choose the fraction for Local ACO w.r.t an initial fraction
% and mat providing all possible fractions and their pheromone levels.

total_prob = sum(mat(initial_frac*10,:));

prob = mat(initial_frac*10,:)/total_prob;
prob = prob.^alpha2;
total_prob = sum(prob);
prob = prob/total_prob;


index = random('unid', 9);
mw = max(prob);

B=0;

B=B+random('unif',0,2*mw);
while(prob(index)<B)
    B=B-prob(index);
    index=index+1;                                         % Roullete wheel
    
    if (index == 10)
        index=1;
    end
end
frac = index/10;


end

