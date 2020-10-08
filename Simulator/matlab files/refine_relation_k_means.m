function [ relation_refined2 ] = refine_relation_k_means( verti,relation,degree )

% function to refine the relations given in matrix relation using k - means
% clustering w.r.t. a degree which determines how many times the clustering
% needs to be done. The function also does refineing based on the angles
% between various relations originating from a single vertex. this
% eliminates the possiblities of redundant lines.

dim_r = size(relation);
dim_v = size(verti);
for i=2:dim_v
    for j=1:2:7
        mat =[];
        x1 = verti(i,j);
        y1 = verti(i,j+1);
        h=0;
        for k=1:dim_r
            if(relation(k,1) == x1 && relation(k,2) == y1 || relation(k,3) == x1 && relation(k,4) == y1)
                h=h+1;
                mat(h,:) = relation(k,:);
            end
        end
        relation_modified{i,(j+1)/2,:} = mat;
    end
end
dim2 = size(relation_modified);

for i = 2:dim2(1)
    for j=1:dim2(2)
        set_new{i,j} =  apply_clustering(relation_modified{i,j},verti,degree);
    end
end
v = 1;
for i=2:dim2(1)
    for j=1:dim2(2)
        dim3 = size(set_new{i,j});
        for t=1:dim3(1)
            relation_refined(v,:) = set_new{i,j}(t,:);
            v = v+1;
        end
    end
end

relation_refined2 = unique(relation_refined,'rows');

end

function [set3] = apply_clustering( set1, verti,degree)
dim_v = size(verti);
for j=1:degree
    dim_set = size(set1);
    dist = zeros(dim_set(1),1);
    for i=1:dim_set(1)
        dist(i) = sqrt((set1(i,1)-set1(i,3))^2+(set1(i,2)-set1(i,4))^2);
    end
    D = size(dist);
    if(D(1)>2)
        [idx,C] = kmeans(dist,2);                              % K- means clustering, grouping into 2 groups 
        g=1;
        if(C(1)>C(2))
            for i = 1:size(idx)
                if(idx(i) == 2)
                    set2(g,:) = set1(i,:);                     % eliminating the relations which fall in the cluster having larger lengths of relations which were found to be impractical and useless most of the time.
                    g=g+1;
                end
            end
        else
            for i = 1:size(idx)
                if(idx(i) == 1)
                    set2(g,:) = set1(i,:);
                    g=g+1;
                end
            end
            
        end
    else
        set2 = set1;
    end
    set1 = [];
    set1 = set2;
    set2 = [];
end
set2 = set1;

dim_set2 = size(set2);
set4 = zeros(dim_set2(1),5);
for i=1:dim_set2(1)
    set4(i,1:4) = set2(i,:);
    set4(i,5) = sqrt((set2(i,1)-set2(i,3))^2 + (set2(i,2)-set2(i,4))^2);
end
set4 = sort(set4,5);

set3 = [];
dim_set4=size(set4);
theta_min = 20;
if(dim_set4(1)>3)
    for i=1:dim_set4(1)
        if(set4(i,1) ~= 0)
            m1 = ((set4(i,4)-set4(i,2))/(set4(i,3)-set4(i,1)));
            for j=i+1:dim_set4(1)
                if(set4(j,1) ~= 0)
                    m2 = ((set4(j,4)-set4(j,2))/(set4(j,3)-set4(j,1)));
                    if(m2 ~=0)                                                          % removing lines which are at a smaller angle than another line from same vertex but shorter in length using a parameter thetha_min
                        theta = abs(m2-m1);
                        if(theta<theta_min)
                            set4(j,:) = [0 0 0 0 0];
                        end
                    end
                end
            end
        end
    end
end
k=1;
for i=1:dim_set4(1)
    if(set4(i,1) ~= 0)
        set3(k,:) = set4(i,:);
        k=k+1;
    end
end
end
