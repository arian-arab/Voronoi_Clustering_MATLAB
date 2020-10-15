function clusters = get_clusters(vor,area_threshold,min_number_of_localizations)
voronoi_areas = vor.voronoi_areas;
neighbors = vor.neighbors;
area_threshold = prctile(voronoi_areas,area_threshold);
keep_points = voronoi_areas <= area_threshold;
counter = 0;
number_of_points = size(voronoi_areas,1);
used_points = zeros(number_of_points,1);
for i = 1:number_of_points
    if keep_points(i) && ~used_points(i)        
        seed_neighbors = neighbors{i}(keep_points(neighbors{i}));
        if ~isempty(seed_neighbors)
            size_one = 0;
            size_two = length(seed_neighbors);            
            while size_two ~= size_one
                size_one = length(seed_neighbors);
                idx_all = unique(cell2mat(neighbors(seed_neighbors)));
                if ~any(builtin('_ismemberhelper',idx_all,seed_neighbors))
                    seed_neighbors = sort([idx_all;seed_neighbors]);
                else
                    seed_neighbors = idx_all;
                end
                seed_neighbors = seed_neighbors(keep_points(seed_neighbors));
                size_two = length(seed_neighbors);
            end
        else
            seed_neighbors = i;
        end
        used_points(seed_neighbors) = 1;
        if length(seed_neighbors) >= min_number_of_localizations
            counter = counter+1;
            clusters.clusters_neighbors{counter,1} = vor.neighbors(seed_neighbors);
            clusters.clusters_voronoi_cells{counter,1} = vor.voronoi_cells(seed_neighbors);
            clusters.clusters_voronoi_areas{counter,1} = vor.voronoi_areas(seed_neighbors);
            clusters.clusters_points{counter,1} = vor.points(seed_neighbors,:);
            k = boundary(clusters.clusters_points{counter,1}(:,1),clusters.clusters_points{counter,1}(:,2),1);
            boundary_points = clusters.clusters_points{counter,1}(k,:);
            clusters.clusters_boundary_points{counter,1} = boundary_points;
            clusters.clusters_centers(counter,:) = mean(boundary_points);
            clusters.clusters_no_of_locs(counter,1) = length(seed_neighbors);
            clusters.clusters_areas(counter,1) = sum(clusters.clusters_voronoi_areas{counter,1});
            clear k boundary_points
        end
    end
end
clusters.points = vor.points;
end