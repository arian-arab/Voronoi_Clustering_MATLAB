function plot_voronoi_area(vor,number_of_bins)
figure()
set(gcf,'name','Voronoi Areas Histogram','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])
voronoi_areas = vor.voronoi_areas;
[y_log,x_log] = hist(log10(voronoi_areas),number_of_bins,'facecolor','b','edgecolor','none');
hist_log = [x_log;y_log]';
bar(x_log,y_log,'facecolor','b')
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
pbaspect([1,1,1])
xlabel('log10(Voronoi Areas)','interpreter','latex','fontsize',16)
ylabel('Counts','interpreter','latex','fontsize',16)
end