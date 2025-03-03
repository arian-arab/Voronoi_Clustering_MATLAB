# Clustering using Voronoi Tessellations

This code generates clusters of point-pattern data using Voronoi tessellations in super-resolution microscopy. It follows the methodology described in this article: https://www.nature.com/articles/srep24084

To see the implementation in action, run the MATLAB script "main.m", which demonstrates the method.

The key steps are as follows:

1) Generate Random Points in 2D space:
Here, number_of_points is set to 1000 as an example.

2) Compute Voronoi Tessellations: function "construct_voronoi_structure.m" computes the Voronoi diagram, extracting the coordinates of each Voronoi cell along with their corresponding areas.
![untitled](https://github.com/user-attachments/assets/5326e16e-caba-4bde-9138-3eb156121ff3)

3) Determine the Area Threshold: The third step defines an area_threshold based on the distribution of Voronoi cell areas. In this example, the threshold is set to the 40th percentile, meaning that Voronoi cells with areas exceeding this value will be excluded from the clustering analysis.
![untitled1](https://github.com/user-attachments/assets/d7a7ce52-152b-4957-b404-75b2a6f3cf8f)
![untitled2](https://github.com/user-attachments/assets/fc349182-a9b8-43f2-a6de-61d1b3ebea4d)

4) Cluster Detection: The remaining code identifies connected Voronoi cells and filters out clusters containing fewer than min_number_of_localizations cells. In this example, min_number_of_localizations is set to 5, ensuring that clusters with fewer than 5 cells are discarded.

![untitled3](https://github.com/user-attachments/assets/730bea5e-edef-4662-99e1-83d5d784a4c4)
