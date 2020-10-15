function plot_clusters(clusters)
voronoi_cells = clusters.clusters_voronoi_cells;
figure()
set(gcf,'name','Voronoi Clusters','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])
hold on
cmap = colormap('hsv');
cmap_interp = interp1(1:256,cmap,linspace(1,256,length(voronoi_cells)));
for i = 1:length(voronoi_cells)    
    for j = 1:length(voronoi_cells{i})
        fill(voronoi_cells{i}{j}(:,1),voronoi_cells{i}{j}(:,2),cmap_interp(i,:));    
    end
    clear data    
end
title(['Total Number of Clusters = ',num2str(length(voronoi_cells))],'interpreter','latex','fontsize',18)
x = clusters.points(:,1);
y = clusters.points(:,2);
x_lim = [min(x) max(x)];
y_lim = [min(y) max(y)];
xlim(x_lim)
ylim(y_lim)
axis equal
axis off
end