function vor = construct_voronoi_structure(x,y)
disp('=========voronoi structure calculation==========')
disp('calculating delaunay triangles')
dt = delaunayTriangulation(x,y);

disp('calculating voronoi vertices and connections')
[vertices,connections] = voronoiDiagram(dt);

disp('finding voronoi cells coordinates')
voronoi_cells = cellfun(@(x) vertices(x,:),connections,'UniformOutput',false);

disp('calculating voronoi areas')
voronoi_areas = cellfun(@(x) abs(sum( (x([2:end 1],1) - x(:,1)).*(x([2:end 2],2) + x(:,2)))*0.5),voronoi_cells,'UniformOutput',false);
idx = cell2mat(cellfun(@(x) isnan(x) | x == Inf,voronoi_areas,'UniformOutput',false));
cell_inf = cell(1);
cell_inf{1,1} = NaN;
voronoi_areas(idx) = cell_inf;

disp('finding voronoi neighbors')
connectivity_list = dt.ConnectivityList;
attached_triangles = vertexAttachments(dt);
neighbors = cellfun(@(x) connectivity_list(x,:),attached_triangles,'UniformOutput',false);
neighbors = cellfun(@(x) unique(x),neighbors,'uniformoutput',false);
for i = 1:length(neighbors)
    neighbors{i}(neighbors{i}==i) = [];
end

vor.neighbors = neighbors;
vor.voronoi_cells = voronoi_cells;
vor.voronoi_areas = cell2mat(voronoi_areas);
vor.points = [x,y];

% vor(:,1) = neighbors;
% vor(:,2) = voronoi_cells;
% vor(:,3) = voronoi_areas;
% vor(:,4) = num2cell(dt.Points(:,1));
% vor(:,5) = num2cell(dt.Points(:,2));
end