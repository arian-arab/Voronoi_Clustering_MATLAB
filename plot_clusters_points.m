function plot_clusters_points(clusters)
boundary_points = clusters.clusters_boundary_points;
figure()
set(gcf,'name','Scattered Points / Clusters','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])
x = clusters.points(:,1);
y = clusters.points(:,2);
scatter(x,y,1,'b','filled')
hold on
for i = 1:length(boundary_points)    
    plot(boundary_points{i}(:,1),boundary_points{i}(:,2),'color','r');
    clear data k   
end
title(['Total Number of Clusters = ',num2str(length(boundary_points))],'interpreter','latex','fontsize',18)
axis equal
axis off
x_lim = [min(x) max(x)];
y_lim = [min(y) max(y)];
xlim(x_lim)
ylim(y_lim)
end