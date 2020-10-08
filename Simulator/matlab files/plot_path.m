function [ ] = plot_path( type , data , set1, start,goal )
% function to plot the path on 'map.png' map

dim1 = size(data);

if(type==1)      % Type one when this function is accessed by ACO Global
    data_set =[];
  for i=1:dim1(2)-1
    data_set = [data_set;set1(data(i)-1,5:6)];
  end

figure;
imshow('map.png');
hold

    data_set =[];
  for i=1:dim1(2)-1
    data_set = [data_set;set1(data(i)-1,5:6)];
  end

plot([[start(1) data_set(1,1)]';data_set(:,1);[data_set(dim1(2)-1,1) goal(1)]'],[[start(2) data_set(1,2)]';data_set(:,2);[data_set(dim1(2)-1,2) goal(2)]']);
plot([start(1) goal(1)]',[start(2) goal(2)]');
hold
legend('computed path','free path');
end
if(type == 2)               % Type two when it is accessed by ACO local
    data_set = data;
    figure;
imshow('map.png');
hold
plot([start(1);data_set(:,1); goal(1)],[start(2);data_set(:,2);goal(2)]);
end

end




