function vor = vor_below_area_threshold(vor,area_threshold)
area_threshold = prctile(vor.voronoi_areas,area_threshold);
I = vor.voronoi_areas>area_threshold;
vor.neighbors(I) = [];
vor.voronoi_cells(I) = [];
vor.voronoi_areas(I) = [];
vor.points(I,:) = [];

clear I
I = isnan(vor.voronoi_areas);
vor.neighbors(I) = [];
vor.voronoi_cells(I) = [];
vor.voronoi_areas(I) = [];
vor.points(I,:) = [];
end