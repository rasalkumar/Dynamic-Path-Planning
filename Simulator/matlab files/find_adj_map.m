function [ adj_map_labeled, adj_map, set1 ] = find_adj_map( verti , relations_refined , start , goal )

% function to make possible paths given a start and end location as well as
% vertices of obstacles and matix containg information about all the
% relations present between those vertices
% Output is provided in two forms, adj_map is a cell containing coordinates
% of the adj. points from each mid_point of a relation, adj_map_labeled
% provides instead of coordinates a label w.r.t. its location in the matrix
% relations refined, aka a relation number which helps in identifying it
% from the relations refined/ set1( used later) and accessing data directly
% from there

dim_r = size(relations_refined);
set1 = zeros(dim_r(1),6);                          
for i=1:dim_r(1)
    set1(i,1:4) = relations_refined(i,1:4);
    xm  = (relations_refined(i,1)+relations_refined(i,3))/2;
    ym = (relations_refined(i,2)+relations_refined(i,4))/2;
    set1(i,5) = xm;
    set1(i,6) = ym;
end
adj_map = cell(1,dim_r(1)+1);
adj_map{1,1} = find_adjacent( verti , relations_refined , start , goal );    

for i=1:dim_r(1)
    
    adj_map{1,i+1} = find_adjacent(verti , relations_refined, [set1(i,5) set1(i,6)] , goal);     % using find_adjacent to make path between any two relations
    
end
adj_map_labeled = cell(1,dim_r(1)+1);                             
for i=1:dim_r(1)+1
    dim = size(adj_map{1,i});
    for j=1:dim(1)
        mat = adj_map{1,i};
        flag =1;
        for k=1:dim_r(1)
            if(set1(k,5) == mat(j,1) && set1(k,6) == mat(j,2) )
                if(i>1)
                dist = sqrt((set1(k,5)-set1(i-1,5))^2 + (set1(k,6)-set1(i-1,6))^2);
                else
                dist = sqrt((set1(k,5)-start(1))^2 + (set1(k,6)-start(2))^2);    
                end
                adj_map_labeled{1,i} = [adj_map_labeled{1,i};[k+1 dist 10]];
             elseif(goal(1) == mat(j,1) && goal(2) == mat(j,2) && flag)
                 dist = sqrt((goal(1)-set1(i-1,5))^2 + (goal(2)-set1(i-1,6))^2);
                 adj_map_labeled{1,i} = [adj_map_labeled{1,i};[999999999 dist 10]];
                 flag=0;
            end
            
        end
    end
end

