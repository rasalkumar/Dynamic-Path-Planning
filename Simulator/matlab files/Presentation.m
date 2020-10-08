%% Main Program for making Free space Map
clear;
close;
clc

display('Reading MAP.....');
map = imread('map.png');
display('MAP sucessfully Read.....!');
display('Extracing veritices from the MAP.......');
verti = extract_coor(map);
display('Vertices extraction successful.....!');
display('finding relations between vertices......');
 relation = find_relation(verti);
display('All relations found successfully....!'); 
display('Starting the refining of relations using K-Means Clustering.....!');
relations_refined =  refine_relation_k_means( verti,relation,1 );
display('Refining of relations done');
dim1 = size(relation);
dim2 = size(relations_refined);
reduction =(dim1(1)-dim2(1))/dim1(1)*100;
display(reduction);
display('Plotting free space MAP....');
plot_relation(relations_refined);

