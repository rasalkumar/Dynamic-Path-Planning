function [ prob_cell, total_dist ] = pheromone_update_local( prob_cell, possible_fractions,possible_paths_local, start, goal,Q2,rho2 )

% function to update pheromone level at each path of all the possible paths
% pheromone levels are updated on prob_cell using data from possible
% fractions inaccordance to ACO parameters Q2 and rho2 representing
% pheromone carried by each ant and evaporation rate.

dim1 = size(possible_paths_local);
dimh = size(prob_cell);
total_dist = zeros(1,dim1(2));
for i=1:dim1(2)
path2 = possible_paths_local{1,i};
dist = zeros(1,dim1(2));

    for j=1:dimh(2)-2
        dist(1,j) = sqrt((path2(j,1)-path2(j+1,1))^2+(path2(j,2)-path2(j+1,2))^2);
    end
        dist(1,j+1) = sqrt((path2(1,1)-start(1))^2+(path2(1,2)-start(2))^2);
         dist(j+2) = sqrt((path2(j+1,1)-goal(1))^2+(path2(j+1,2)-goal(2))^2);
        total_dist(i) = sum(dist(1,:));
end
pheromone =  Q2*total_dist.^-1;

for i=1:dimh

    prob_cell{1,i} =  prob_cell{1,i}.*(1-rho2);

end
for i=1:dim1(2)
    prob_cell{1,1}(1,possible_fractions{1,i}(1,1)*10) = prob_cell{1,1}(1,possible_fractions{1,i}(1,1)*10) + pheromone(i);
    for j=1:dimh(2)-1
        prob_cell{1,j+1}(possible_fractions{1,i}(1,j)*10,possible_fractions{1,i}(1,j+1)*10) = pheromone(i)+ prob_cell{1,j+1}(possible_fractions{1,i}(1,j)*10,possible_fractions{1,i}(1,j+1)*10);
        
    end
end
end

