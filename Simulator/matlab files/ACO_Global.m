
% Main program for Global Ant Colony Optimization
start = [509 115];                                         % Start  
goal = [2193 962];                                         %Goal 
free_length = sqrt((start(1)-goal(1))^2 + (start(2)-goal(2))^2);
num_ants =40 ;                                             % Number of Ants Used 
iterations = 15;                                           % Iterations
Q = 4000;                                                  % Pheromone per ant
rho = 0.5;                                                 % Evaporation Rate
alpha = 1;
beta = 0;                                                  % ACO Parameters
[map_adj_label,~,set1 ]= find_adj_map( verti , relations_refined , start , goal );
possible_paths = cell(1,num_ants);


for h = 1:iterations
    possible_paths = cell(1,num_ants);                     % Cell containg possible paths of ants
for q = 1:num_ants
flag=1;
while(flag)
visited_matrix = [];
adj_point = [];
[adj_point(1),visited_matrix,warning] = choose_adj_point(map_adj_label{1}, visited_matrix,alpha,beta);    % Choosing an appropriate adjacent point for path generation
i=1;
while (1)
    [adj_point(i+1) , visited_matrix , warning] = choose_adj_point(map_adj_label{adj_point(i)}, visited_matrix,alpha,beta);
    flag=0;
    if(warning)
        flag=1;
        break;
    end
    
    
    if(adj_point(i+1) == 999999999)                                         % IF goal is reached; Goal = 999999999
        break;
    end
    i=i+1;
end
end
possible_paths{1,q} = adj_point; 
end
map_adj_label = pheromone_update( possible_paths, map_adj_label, Q, rho);    % Perform update on phromone levels on all the paths under consideration
end
total_length = zeros(num_ants,1);
for p=1:num_ants
   
    path = possible_paths{1,p};
    dim2 = size(path);
    
    for i=1:dim2(2)-1
     adj_points =  map_adj_label{1,path(i)};
     dim3 = size(adj_points);
     for j=1:dim3(1)
         if(adj_points(j,1) == path(i+1))
             dist = adj_points(j,2);
             break;
         end
     end
     total_length(p) = total_length(p) + dist;   
    end
    
    
end

[min_length(i),index_short] = min(total_length);
performance = (min_length - free_length)/free_length;                        % Performane of the shortest path calculated
plot_path( 1 , possible_paths{1,index_short} , set1, start , goal );         % Plotting the path
