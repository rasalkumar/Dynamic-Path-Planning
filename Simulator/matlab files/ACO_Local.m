% Main Program to perform local Ant Colony Optimization
ants2 = 50;                                               % Number of Ants
iterations2 = 20;                                          % Number of iterations
Q2 = Q;                                                    %pheromone per ant
rho2 = rho;                                                % Evaporation rate
alpha2 = 2;                                                 % ACO parameter
data = possible_paths{1,index_short};                      % shortest path obtained from ACO Global on which ACO Local is to be applied
dim1 = size(data);
adj_points =[];
for i=1:dim1(2)-1
    adj_points = [adj_points;set1(data(i)-1,1:4)];
end
possible_fractions = cell(1,ants2);
adj_points;
prob_cell = cell(1,dim1(2));                                % Cell containing the pheromone levels of all possible pairs of fractions for each set of adj. points
prob_cell{1,1} = ones(1,9)*1; 
for i=2:dim1(2)
    prob_cell{1,i} = ones(9,9)*1;                         
end

for l = 1:iterations2
for i=1:ants2
    possible_fractions{1,i}(1,1) =  choose_frac( .1, prob_cell{1,1}, alpha2 );        % start = .1
    for j=2:dim1(2)
        possible_fractions{1,i}(1,j)= choose_frac(  possible_fractions{1,i}(1,j-1), prob_cell{1,j}, alpha2 );   % choosing fraction for relation containig next adj. point given the current fraction 
    end
    for j=1:dim1(2)-1
        possible_paths_local{1,i}(j,:) = [(adj_points(j,1)+(adj_points(j,3)-adj_points(j,1))*possible_fractions{1,i}(1,j)) (adj_points(j,2)+(adj_points(j,4)-adj_points(j,2))*possible_fractions{1,i}(1,j))];
    end
end
[ prob_cell, total_dist ] = pheromone_update_local( prob_cell, possible_fractions,possible_paths_local, start, goal,Q2,rho2 ); % updating phromone on prob_cell
end

[m,index] =  min(total_dist);

plot_path(2,possible_paths_local{1,index} ,[], start,goal );
min_dist = m;
performance = (min_dist - free_length)/free_length   % performance of local best path obtained


