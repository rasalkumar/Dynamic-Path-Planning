function [ adj_point, visited_matrix, warning ] = choose_adj_point( adj_point_mat, visited_matrix, alpha, beta )

% Program to choose the adj_point based upon the phromone level and
% visiblity of it w.r.t the point from the set adj_point_mat containing all
% possible adj_points , there distances from the given point and their
% respective pheromonne levels. Selection is done w.r.t. to the parameters
% alpha and beta which give respective importance to pheromone level and
% visiblity. The program uses visited_matrix, a collection of points it has
% visited to eliminate the possiblity of visiting a location twice.
% functions returns a warning if the adj_mat is a subset of visited_matrix

dim1 = size(visited_matrix);
num = size(adj_point_mat);
for i = 1:dim1(1)
    for j=1:num(1)
        if(visited_matrix(i,1) == adj_point_mat(j,1))
            adj_point_mat(j,3) = 0;                       % zeroing the probability of the points already visited to eliminate their chances of occuring
        end
    end
end
warning = 0;

total_prob = sum(adj_point_mat(:,3));
if (total_prob == 0)
    warning = 1;                                      % Warning 
    adj_point = 0;            
    return;
end

% prob = adj_point_mat(:,3)/total_prob;
for i=1:num(1)
    prob(i,1) = (adj_point_mat(i,3)^alpha)*(1/adj_point_mat(i,2)^beta);         % probability rule given by Ant Colony Optimization

end
total_prob = sum(prob);

prob = prob/total_prob;                      % Normalized probability

index = random('unid', num(1));
mw = max(prob);

B=0;flag=1;

B=B+random('unif',0,2*mw);
while(prob(index)<B)
    B=B-prob(index);                                    % Roullete wheel for selection of adj_point
    index=index+1;
    
    if (index == num(1)+1)
        index=1;
    end
end
adj_point = adj_point_mat(index,1);
visited_matrix = [visited_matrix;adj_point];           % updating visited matrix with the chosen point
end

