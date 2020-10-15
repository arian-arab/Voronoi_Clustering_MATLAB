function scatter_clusters_area_locs(clusters)
figure()
set(gcf,'name','Voronoi Clusters Area Locs','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])
scatter(clusters.clusters_areas,clusters.clusters_no_of_locs,10,'b','filled')
xlabel('Cluster Area','interpreter','latex','fontsize',16)
ylabel('Number of Localizations','interpreter','latex','fontsize',16)
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
box on
pbaspect([1,1,1])
end