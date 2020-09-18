clear;clc;close all
npt = 1000;
minimum_number_of_cells_per_cluster = 5;
area_threshold_percentile = 30;

x = 20*rand(npt,1);
y = 20*rand(npt,1);
x_lim = [min(x) max(x)];
y_lim = [min(y) max(y)];

disp('calculating voronoi vertices and connections')
[vertices,connections] = voronoin([x,y]);

idx = cell2mat(cellfun(@(x) any(x==1),connections,'UniformOutput',false));
connections(idx) = [];
clear idx
cells(:,1) = connections;
cells(:,2) =  cellfun(@(x) vertices(x,:),connections,'UniformOutput',false);
cells(:,3) = cellfun(@(x) abs(sum( (x([2:end 1],1) - x(:,1)).*(x([2:end 2],2) + x(:,2)))*0.5),cells(:,2),'UniformOutput',false);
cells(:,4) = cellfun(@(x) [mean(x(:,1)) mean(x(:,2))],cells(:,2),'UniformOutput',false);
clear vertices connections

voronoi_areas = cell2mat(cells(:,3));
area_threshold = prctile(voronoi_areas,area_threshold_percentile);
idx = voronoi_areas<area_threshold;
cells = cells(idx,:);
clear idx voronoi_areas

i= 0;
while size(cells,1)>1
    disp(num2str(size(cells,1)))
    i = i+1;
    [clusters{i,1},cells] = find_clusters_knn_algorithm(cells);
end

idx = cellfun(@(x) size(x,1),clusters);
idx = idx>=minimum_number_of_cells_per_cluster;
clusters = clusters(idx);
clear idx

plot_clusters(clusters,x_lim,y_lim)
plot_clusters_points(clusters,x_lim,y_lim,x,y)

function [clusters,cells] = find_clusters_knn_algorithm(cells)
clusters{1}(1,:) = cells(1,:);
cells(1,:) = [];
[cells,intersection] = check_intersection(cells,clusters{1});
if isempty(intersection)~=1
    j = 0;
    while isempty(intersection)~=1
        j = j+1;
        for i = 1:size(intersection,1)
            clusters{j}(i+1,:) = intersection(i,:);
            [cells,out{i,1}] = check_intersection(cells,intersection(i,:));
        end
        clear intersection
        out = out(~cellfun('isempty',out));
        out = vertcat(out{:});
        intersection = out;
        clear out;
    end
    clear intersection
    clusters = vertcat(clusters{:});    
    clusters = clusters(~cellfun('isempty',clusters(:,1)),:);
end
end

function [cells,intersection] = check_intersection(cells,to_check)
idx = knnsearch(cell2mat(cells(:,4)),to_check{1,4},'k',10);
I = ~cellfun(@isempty,cellfun(@(x) intersect(to_check{1,1},x),cells(idx,1),'UniformOutput',false));
idx = idx(I);
intersection = cells(idx,:);
cells(idx,:) = [];
end

function plot_clusters(clusters,x_lim,y_lim)
figure()
set(gcf,'name','Voronoi Clusters','NumberTitle','off','color','w','units','normalized','position',[0.35 0.25 0.4 0.6],'menubar','none')
set(1,'defaultfiguretoolbar','figure');

hold on
cmap = colormap('hsv');
cmap_interp = interp1(1:256,cmap,linspace(1,256,length(clusters)));
for i = 1:length(clusters)
    data = clusters{i};
    for j = 1:size(data,1)
        fill(data{j,2}(:,1),data{j,2}(:,2),cmap_interp(i,:));    
    end
    clear data    
end
title(['Total Number of Clusters = ',num2str(length(clusters))],'interpreter','latex','fontsize',18)
axis equal
axis off
xlim(x_lim)
ylim(y_lim)
end

function plot_clusters_points(clusters,x_lim,y_lim,x,y)
figure()
set(gcf,'name','Points Clusters','NumberTitle','off','color','w','units','normalized','position',[0.35 0.25 0.4 0.6],'menubar','none')
set(1,'defaultfiguretoolbar','figure');

scatter(x,y,1,'b','filled')
hold on
for i = 1:length(clusters)
    data = clusters{i}(:,4);
    data = vertcat(data{:});
    k = boundary(data(:,1),data(:,2));
    plot(data(k,1),data(k,2),'color','k');
    clear data k   
end
title(['Total Number of Clusters = ',num2str(length(clusters))],'interpreter','latex','fontsize',18)
axis equal
axis off
xlim(x_lim)
ylim(y_lim)
end
