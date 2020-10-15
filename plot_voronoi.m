function plot_voronoi(vor)
voronoi_cells = vor.voronoi_cells;
voronoi_areas = vor.voronoi_areas;
figure()
set(gcf,'name','Voronoi Cells and Areas','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])
hold on
for i = 1:length(voronoi_cells)
    fill(voronoi_cells{i}(:,1),voronoi_cells{i}(:,2),log10(voronoi_areas(i)),'edgecolor','none')
end
x = vor.points(:,1);
y = vor.points(:,2);
scatter(x,y,5,'b','filled')
colormap(hot)
x_lim = [min(x) max(x)];
y_lim = [min(y) max(y)];
xlim(x_lim)
ylim(y_lim)
axis off
colorbar
pbaspect([1,1,1])
end