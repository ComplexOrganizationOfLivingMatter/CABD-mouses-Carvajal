function [Mean_neighbors,Std_neighbors,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_Coef_cluster,Desv_Coef_cluster,Mean_excentricity,Desv_excentricity,Mean_BC,Desv_BC,Mean_dist,Desv_dist] = calculate_network_ccs_withoutSlowFastCells(valid_cells,valid_cells_neigh_of_neigh,neighs_real,sides_cells,improved_mask,contour_img,cells_L,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas,folder,name)

    [H,W]=size(cells_L);

    % CC15-16
    %Mean of neighbors
    n_valid_neighbors=sides_cells(valid_cells);
    Mean_neighbors=mean(n_valid_neighbors);
    Std_neighbors=std(n_valid_neighbors);
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %Represent cellular network with a red background%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Create mask to overwrite network
    aux=improved_mask;
    aux(aux~=0)=1;
    aux2=aux+contour_img;
    pi_contour_img=find(aux2==0);
    pi_contour_img2=find(contour_img==1);
    R_c=ones(H,W);G_c=ones(H,W);B_c=ones(H,W);

    R_c(pi_contour_img)=1;G_c(pi_contour_img)=0;B_c(pi_contour_img)=0;
    R_c(pi_contour_img2)=0.8;G_c(pi_contour_img2)=0.8;B_c(pi_contour_img2)=0.8;

    with_red=cat(3,R_c,G_c,B_c);
    h=figure('Visible', 'off');%imshow(with_red)
    image(with_red)


    hold on
    % Building network, we are going to add links between valid cells centroids
    % overwriting a watershed image with RED background.
    
    %centers
    center = regionprops(improved_mask,'Centroid'); 
    centers = cat(1, center.Centroid);
    
    index_cell_slow=0;
    index_cell_fast=0;
    relation_area_neighbors=zeros(1,1);
    relation_major_axis_neighbors=zeros(1,1);
    relation_minor_axis_neighbors=zeros(1,1);
    relation_relation_axis_neighbors=zeros(1,1);
    relation_Pix_region_convex_neighbors=zeros(1,1);
    relation_Relation_areas_neighbors=zeros(1,1);
    graph_binary=zeros(size(centers,1),size(centers,1));
    graph=zeros(size(centers,1),size(centers,1));
    n_neighbors_of_slow=zeros(1);
    n_slow_neighbors_of_slow=zeros(1);
    n_fast_neighbors_of_slow=zeros(1);
    n_neighbors_of_fast=zeros(1);
    n_slow_neighbors_of_fast=zeros(1);
    n_fast_neighbors_of_fast=zeros(1);

    for i=1:length(valid_cells_neigh_of_neigh)
        n_cell=valid_cells_neigh_of_neigh(i);
        neighbors_network=neighs_real{n_cell};

        % calculate: X of each cell/[ mean(X neighbors cells) + std(X neighbors cells)]
        relation_area_neighbors(i)=cell_area(n_cell)/(mean(cell_area(neighbors_network))+std(cell_area(neighbors_network)));
        relation_major_axis_neighbors(i)=major_axis(n_cell)/(mean(major_axis(neighbors_network))+std(major_axis(neighbors_network)));
        relation_minor_axis_neighbors(i)=minor_axis(n_cell)/(mean(minor_axis(neighbors_network))+std(minor_axis(neighbors_network)));
        relation_relation_axis_neighbors(i)=(major_axis(n_cell)./minor_axis(n_cell))/(mean((major_axis(neighbors_network))./minor_axis(neighbors_network)));
        relation_Pix_region_convex_neighbors(i)=Pix_convex_region(n_cell)/(mean(Pix_convex_region(neighbors_network))+std(Pix_convex_region(neighbors_network)));
        relation_Relation_areas_neighbors(i)=Relation_valid_areas(i)/(mean(Relation_valid_areas(i))+std(Relation_valid_areas));

    end


    for i=1:length(valid_cells)
        n_cell=valid_cells(i);
        neighbors_network=neighs_real{n_cell};
        
        %Create adjacency matrix and weighted graph
        for ii=1:(length(neighbors_network))
            graph_binary(n_cell,neighbors_network(ii))=1;
            graph_binary(neighbors_network(ii),n_cell)=1;
            graph(n_cell,neighbors_network(ii))=sqrt((centers(n_cell,1)-centers(neighbors_network(ii),1))^2+(centers(n_cell,2)-centers(neighbors_network(ii),2))^2);
            graph(neighbors_network(ii),n_cell)=sqrt((centers(n_cell,1)-centers(neighbors_network(ii),1))^2+(centers(n_cell,2)-centers(neighbors_network(ii),2))^2);
        end

        %Draw graph connections between neighbors
        for k=1:length(neighbors_network)
            plot([round(centers(n_cell,1)),round(centers(neighbors_network(k),1))], [round(centers(n_cell,2)),round(centers(neighbors_network(k),2))],'Color','black')
        end


    end

    %Save the network figure with same dimension than original Image. Use
    %export_fig_master packet and resizing after that
    stringres=strcat(folder,'\',name,'_network.jpg');

    set(gca,'visible','off')
    set(gca,'XtickLabel',[],'YtickLabel',[]);
    addpath('..\export_fig_master')
    
    export_fig(stringres, '-native');
    
    fig_read=imread(stringres);
	fig_read=imresize(fig_read,[H,W]);
    imwrite(fig_read,stringres);
    
    hold off
    close all
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    % Network features
    graph_rect=graph(valid_cells,valid_cells);


    %CHANGE THE DIRECTORY LOOKING FOR 'CODIGO BCT' to apply Prueba_brain
    %function
    [n_connection_each_nodes, Sum_weights_each_node, Correlation_between_grades_nodes, Densidad_conexiones, Coef_cluster, T, optime_structure,max_modularity, Matrix_shortest_distances_all_nodes,lambda,efficiency,ecc,radius,diameter, BC]=Prueba_brain(graph,graph_binary,graph_rect,valid_cells);

    Sum_weights=Sum_weights_each_node(valid_cells);

    % CC23-CC34
    Mean_Relation_areas_neighborhood=mean(relation_area_neighbors);
    Std_Relation_areas_neighborhood=std(relation_area_neighbors);
    Mean_relation_major_axis_neighbors=mean(relation_major_axis_neighbors);
    Std_relation_major_axis_neighbors=std(relation_major_axis_neighbors);
    Mean_relation_minor_axis_neighbors=mean(relation_minor_axis_neighbors);
    Std_relation_minor_axis_neighbors=std(relation_minor_axis_neighbors);
    Mean_relation_relation_axis_neighbors=mean(relation_relation_axis_neighbors);
    Std_relation_relation_axis_neighbors=std(relation_relation_axis_neighbors);
    Mean_relation_Pix_convex_region_neighbors=mean(relation_Pix_region_convex_neighbors);
    Std_relation_Pix_convex_region_neighbors=std(relation_Pix_region_convex_neighbors);
    Mean_relation_relation_areas_neighbors=mean(relation_Relation_areas_neighbors);
    Std_relation_relation_areas_neighbors=std(relation_Relation_areas_neighbors);
    
    
    %CC35-CC36
    Mean_sum_weights=mean(Sum_weights);
    Desv_sum_weights=std(Sum_weights);
        
    % CC41-CC42, CC47-CC48, CC53-CC54
    Mean_Coef_cluster=mean(Coef_cluster);
    Desv_Coef_cluster=std(Coef_cluster);
    Mean_excentricity=mean(ecc(valid_cells));
    Desv_excentricity=std(ecc(valid_cells));
    Mean_BC=mean(BC(valid_cells));
    Desv_BC=std(BC(valid_cells));

    %CC59-CC60
    M=triu(Matrix_shortest_distances_all_nodes(valid_cells,valid_cells));
    Mean_dist=mean(M(M~=0));
    Desv_dist=std(M(M~=0));

        
end

