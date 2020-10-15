function plot_clusters_individual(clusters)
clusters_voronoi_cells = clusters.clusters_voronoi_cells;
clusters_areas = clusters.clusters_areas;
clusters_no_of_locs = clusters.clusters_no_of_locs;
figure()
set(gcf,'name','Voronoi Clusters','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.65])

if length(clusters_voronoi_cells)>1
    slider_step=[1/(length(clusters_voronoi_cells)-1),1];
    uicontrol('style','slider','units','normalized','position',[0,0,1,0.05],'value',1,'min',1,'max',length(clusters_voronoi_cells),'sliderstep',slider_step,'Callback',{@sld_callback});
end
slider_value=1;
plot_clusters_individual_inside(clusters_voronoi_cells{slider_value})

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        plot_clusters_individual_inside(clusters_voronoi_cells{slider_value})
    end

    function plot_clusters_individual_inside(data)
        ax = gca; cla(ax);
        hold on
        for i = 1:size(data,1)
            fill(data{i}(:,1),data{i}(:,2),'b');
        end
        axis off
        title({'',['Cluster ',num2str(slider_value),'/',num2str(length(clusters_voronoi_cells))],['Total Area = ',num2str(clusters_areas(slider_value))],['Number of Cells =',num2str(clusters_no_of_locs(slider_value))]},'interpreter','latex','fontsize',18)
    end
end