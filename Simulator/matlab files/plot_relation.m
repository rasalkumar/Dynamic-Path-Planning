function [ ] = plot_relation(relation )
% function to plot all the relations from matrix relation onto the map
% 'map.png'
dim = size(relation);
imshow('map.png');
    hold
    plot([relation(1,1) relation(1,3)] ,[relation(1,2) relation(1,4)]);
    for i=2:dim(1)
        plot([relation(i,1) relation(i,3)],[relation(i,2) relation(i,4)]);
    end


end

