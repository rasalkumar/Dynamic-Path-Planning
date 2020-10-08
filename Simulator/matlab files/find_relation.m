function [ relation ] = find_relation( verti )

% Function the forms relations from a given matrix of veritces of all the
% obstacles. the relation are fromed by joining all possible vertice points
%and joing the vertices to the edges of the boundary 
%however eliminating those relations which pass through an obstacle.
% 
dim = size(verti);
z=1;
for i=2:dim(1)
    
    for j=1:2:7
        
        for k=i+1:dim(1)
            for l=1:2:7
                x1 = verti(i,j);
                y1 = verti(i,j+1);
                x2 = verti(k,l);
                y2 = verti(k,l+1);
                ob1 = i;
                ob2 = k;
                %display('Checking for relation in .......');
                relation_check = [x1 y1 x2 y2];
                %display(relation_check);
                
                if(check_relation(x1,y1,ob1,x2,y2,ob2,verti))
                    relation(z,1) = x1;
                    relation(z,2) = y1;                                  % Checking relation for a possible intersection with an obstacle
                    relation(z,3) = x2;
                    relation(z,4) = y2;
                    z=z+1;
                %display('Relation Formed !   relation matrix updated       ');     
                else
                %display(' Cannot form a relation ');    
                 
                end
            end
        end
    end
end

for i=2:dim(1)
    for j=1:2:7
        x1 = verti(i,j);
        y1 = verti(i,j+1);
        x2 = verti(1,1);
        y2 = y1;                                                 %Checking relations with boundary elements
        x3 = x1;
        y3 = verti(1,2);
        x4 = verti(1,3);
        y4 = y1;
        x5 = x1;
        y5 = verti(1,6);                     
        ob1 =i;
        ob2 = 1;
        
        if(j == 1 || j == 5)
        if(check_relation(x1,y1,ob1,x2,y2,ob2,verti))
                    relation(z,1) = x1;
                    relation(z,2) = y1;
                    relation(z,3) = x2;                         % joing only those vertices of obstacles to boundary edges which lie towards the boundary edge 
                    relation(z,4) = y2;
                    z=z+1;
        end
        end
        if(j == 1 || j == 3)
        if(check_relation(x1,y1,ob1,x3,y3,ob2,verti))
                    relation(z,1) = x1;
                    relation(z,2) = y1;
                    relation(z,3) = x3;
                    relation(z,4) = y3;
                    z=z+1;
        end
        end
        if( j == 3 || j == 7)
        if(check_relation(x1,y1,ob1,x4,y4,ob2,verti))
                    relation(z,1) = x1;
                    relation(z,2) = y1;
                    relation(z,3) = x4;
                    relation(z,4) = y4;
                    z=z+1;
        end
        end
        if(j == 5 || j == 7)
        if(check_relation(x1,y1,ob1,x5,y5,ob2,verti))
                    relation(z,1) = x1;
                    relation(z,2) = y1;
                    relation(z,3) = x5;
                    relation(z,4) = y5;
                    z=z+1;
        end
        end
    end
end
    

end
function [output] = check_relation(x1,y1,ob1,x2,y2,ob2,verti)              % Checking for a intersection with an obstacle
dim = size(verti);
for i=2:dim(1)
    xbox = [verti(i,1) verti(i,3) verti(i,7) verti(i,5) verti(i,1)];
    ybox = [verti(i,2) verti(i,4) verti(i,8) verti(i,6) verti(i,2)];         
    xline = [x1 x2];
    yline = [y1 y2];
    [xi,~] = polyxpoly(xline,yline,xbox,ybox);
    xi = unique(xi);
    P = size(xi);
    if(i ~= ob1 && i ~= ob2)
    if(P(1)>0)
        output =0;
        break;
    else
        output =1;
    end
    else 
       if(P(1)>1)
        output =0;
        break;
    else
        output =1;
      end 
    end
end
end