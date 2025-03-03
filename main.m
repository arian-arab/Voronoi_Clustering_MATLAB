clear;clc;close all
%-------------input parameters for voronoi tesselation--------------%
number_of_points = 1000; % number of scattered points to be constructed randomly
minimum_number_of_cells_per_cluster = 5; %voronoi-cells will be identified as clusters if at leat M-many cells are connected
area_threshold = 40; % threshold value on the voronoi-cells areas (percentile)


%----------simulating scattered points in two dimensions--------
x = rand(number_of_points,1);
y = rand(number_of_points,1);
%-------------------------------------------------------------------

vor = construct_voronoi_structure(x,y); % construct the voronoi object
clusters = get_clusters(vor,area_threshold,minimum_number_of_cells_per_cluster); %finds connected cells below the area-threshold
plot_voronoi(vor)

vor_below = vor_below_area_threshold(vor,area_threshold); %finds voronoi cells below the area threshold
plot_voronoi(vor_below)
caxis([min(log10(vor.voronoi_areas)) max(log10(vor.voronoi_areas))])
xlim([min(x) max(x)])
ylim([min(y) max(y)])

plot_voronoi_area(vor,100); % plots the histogram of the voronoi-cells areas, 100 is number of bins
plot_clusters(clusters) % plots the identified clusters
plot_clusters_points(clusters) % plot identified clusters boundary lines
plot_clusters_individual(clusters) % plots each cluster individually
scatter_clusters_area_locs(clusters); % scatters clusters area versus number of points inside each cluster