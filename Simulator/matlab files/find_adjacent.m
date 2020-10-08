function [ adjacent ] = find_adjacent( verti , relations_refined , initial_point , goal )
clear adjacent;
clear adj3;
% dim_r = size(set);
dim_r = size(relations_refined);
set1 = zeros(dim_r(1),7);
dim_v = size(verti);
initial_point_members = [];
flag = 1;
for i=1:dim_r(1)
    set1(i,1:4) = relations_refined(i,1:4);
    xm  = (relations_refined(i,1)+relations_refined(i,3))/2;
    ym = (relations_refined(i,2)+relations_refined(i,4))/2;
    set1(i,5) = xm;
    set1(i,6) = ym;
    set1(i,7) = sqrt((xm-initial_point(1))^2 + (ym-initial_point(2))^2);
end
for i=1:dim_r(1)
    if(initial_point(1) == set1(i,5) && initial_point(2) == set1(i,6))
        initial_point_members = set1(i,1:4);
        flag =0;
        break;
    end
end
adjacent = [];
q=1;
if(flag)
   % display(' initial Point is not a midpoint');
    for i=1:dim_r(1)
        flag2 = 0;
        xline = [initial_point(1) set1(i,5)];
        yline = [initial_point(2) set1(i,6)];
        for j=1:dim_r(1)
            
            if(j ~= i)
                xline1 = [set1(j,1) set1(j,3)];
                yline1 = [set1(j,2) set1(j,4)];
                [xi,~] = polyxpoly(xline,yline,xline1,yline1);
                P = size(xi);
                if(P(1)>0)
                    flag2 = 1;
                    break;
                end
            end
        end
        for k=2:dim_v(1)
            if(flag2 ==0)
                xbox = [verti(k,1) verti(k,3) verti(k,7) verti(k,5) verti(k,1)];
                ybox = [verti(k,2) verti(k,4) verti(k,8) verti(k,6) verti(k,2)];
                [xi,~] = polyxpoly(xline,yline,xbox,ybox);
                P = size(xi);
                if(P(1)>0)
                    flag2 = 1;
                    break;
                end
                
            end
            
            
        end
        if(flag2 == 0)
            adjacent(q,:) = set1(i,5:6) ;
            q=q+1;
        end
        
    end
    
    
else
 %   display('initial point is a midpoint');
    k=1;
    q=1;
    adj = [];
    adj2 = [];
    for i=1:dim_r(1)
      %  if(set1(i,1) ~= verti(1,1) && set1(i,1) ~= verti(1,3) && set1(i,2) ~= verti(1,2) && set1(i,4) ~= verti(1,4))
            if((initial_point_members(1) == set1(i,1) && initial_point_members(2) == set1(i,2)) || (initial_point_members(3) == set1(i,3)) && initial_point_members(4) == set1(i,4) || (initial_point_members(1) == set1(i,3) && initial_point_members(2) == set1(i,4)) || (initial_point_members(3) == set1(i,1)) && initial_point_members(4) == set1(i,2))
                
                
                adj(q,:) = set1(i,5:6);
                q=q+1;
            end
       % end
        
    end
    if(initial_point_members(1) == verti(1,1) || initial_point_members(3) == verti(1,1))
        for i=1:dim_r(1)
            if(set1(i,1) == verti(1,1) || set1(i,3) == verti(1,1))
                adj2(k,:) = set1(i,:);
                k=k+1;
            end
        end
    elseif(initial_point_members(1) == verti(1,3) || initial_point_members(3) == verti(1,3))
        for i=1:dim_r(1)
            if(set1(i,1) == verti(1,3) || set1(i,3) == verti(1,3))
                adj2(k,:) = set1(i,:);
                k=k+1;
            end
        end
    elseif(initial_point_members(2) == verti(1,2) || initial_point_members(4) == verti(1,2))
        for i=1:dim_r(1)
            if(set1(i,2) == verti(1,2) || set1(i,4) == verti(1,2))
                adj2(k,:) = set1(i,:);
                k=k+1;
            end
        end
    elseif(initial_point_members(2) == verti(1,6) || initial_point_members(4) == verti(1,6))
        for i=1:dim_r(1)
            if(set1(i,2) == verti(1,6) || set1(i,4) == verti(1,6))
                adj2(k,:) = set1(i,:);
                k=k+1;
            end
        end
    end
    dim_x = size(adj2);
    if(dim_x(1)>2)
        adj2 = sortrows(adj2,7);
        if((adj2(2,5)<initial_point(1) && adj2(3,5)>initial_point(1)) || (adj2(3,5)<initial_point(1) && adj2(2,5)>initial_point(1)) || (adj2(2,6)<initial_point(2) && adj2(3,6)>initial_point(2)) || (adj2(3,6)<initial_point(2) && adj2(2,6)>initial_point(2)))

        adj3 = adj2(2:3,5:6);
        else
        adj3 = adj2(2,5:6);
        end
       
    elseif(dim_x(1)==2)
        adj2 = sortrows(adj2,7);
        adj3 = adj2(2,5:6);
    else
        adj3 = [0 0];
    end
    dir_adj = size(adj);
    for i=1:dir_adj(1)
        if(adj(i,1) ~= initial_point(1) || adj(i,2) ~= initial_point(2))
            adjacent(i,:) = adj(i,:);
        end
    end
    if(size(adjacent))

    adjacent = [adjacent;adj3];
    else
    adjacent = adj3;
    end
end
adjacent( ~any(adjacent,2), : ) = [];
adjacent = unique(adjacent,'rows');
flag2 = 0;
        xline = [initial_point(1) goal(1)];
        yline = [initial_point(2) goal(2)];
        for j=1:dim_r(1)
            
            
                xline1 = [set1(j,1) set1(j,3)];
                yline1 = [set1(j,2) set1(j,4)];
                [xi,yi] = polyxpoly(xline,yline,xline1,yline1);
                P = size(xi);
                if(P(1)>0 && xi(1) ~= initial_point(1) && yi(1) ~= initial_point(2) )
                    flag2 = 1;
                    break;
                end
            
        end
        for k=2:dim_v(1)
            if(flag2 ==0)
                xbox = [verti(k,1) verti(k,3) verti(k,7) verti(k,5) verti(k,1)];
                ybox = [verti(k,2) verti(k,4) verti(k,8) verti(k,6) verti(k,2)];
                [xi,~] = polyxpoly(xline,yline,xbox,ybox);
                P = size(xi);
                if(P(1)>0)
                    flag2 = 1;
                    break;
                end
                
            end
            
            
        end
        if(flag2 ==0)
        adjacent = [goal;adjacent];
        end
        dim9 = size(adjacent);
        t=1;
        while(t<=dim9(1))
            
            flag2 = 0;
        xline = [initial_point(1) adjacent(t,1)];
        yline = [initial_point(2) adjacent(t,2)];
            for k = 2: dim_v(1)
                xbox = [verti(k,1) verti(k,3) verti(k,7) verti(k,5) verti(k,1)];
                ybox = [verti(k,2) verti(k,4) verti(k,8) verti(k,6) verti(k,2)];
                [xi,~] = polyxpoly(xline,yline,xbox,ybox);
                P = size(xi);
                if(P(1)>0)
                    flag2 = 1;
                    break;
                end
            end
            if(flag2)
                
                adjacent(t,:) = [];
                dim9 = dim9-1;
                t=t-1;
            end
             
             t=t+1;
        end
        adjacent( ~any(adjacent,2), : ) = [];
        if(isempty(adjacent))
            adjacent = initial_point;
        end
end

