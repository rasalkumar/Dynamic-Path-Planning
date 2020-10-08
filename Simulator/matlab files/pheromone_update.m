function [ map_adj_label ] = pheromone_update( possible_paths, map_adj_label, Q, rho )

% Function for updating pheromone levels for Global ACO using the paths
% formed in possible_paths cell and altering the pheromone levels present
% in map__adj_label with regard to the pheromone carried by each ant (Q)
% and evaporation rate. It returns the updated map_aj_label containing new
% values of phremones
dim1 = size(possible_paths);
total_length = zeros(dim1(2),1);
for p = 1:dim1(2)
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
     total_length(p) = total_length(p) + dist;                        % total length covered by each ant
    end
end
pheromone =  Q*total_length.^-1;                                       % pheromone to be spread over each segement of path covered by each ant across the map

dim4 = size(map_adj_label);

for i=1:dim4(2)

    map_adj_label{1,i}(:,3) =  map_adj_label{1,i}(:,3).*(1-rho);            % evaporating the pheromones at each path 

end

for p = 1:dim1(2)
    path = possible_paths{1,p};
    dim2 = size(path);
    
    
    for i=1:dim2(2)-1
        adj_points = map_adj_label{1,path(i)};
        dim3 = size(adj_points);
        for j=1:dim3(1)
            if(adj_points(j,1) == path(i+1))
                adj_points(j,3) = adj_points(j,3) + pheromone(p);            % depositing pheromones by respective ants at each part of path travelled by ant
                break;
            end
        end
        map_adj_label{1,path(i)} = adj_points;
    end
    
end

end

