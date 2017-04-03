function [Mean_neighbors,Std_neighbors,Std_neighbors_of_slow,Std_neighbors_of_fast,Mean_slow_neighbors_of_slow,Mean_fast_neighbors_of_slow,Mean_slow_neighbors_of_fast,Mean_fast_neighbors_of_fast,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_weights_fast_cells,Desv_weights_fast_cells,Mean_weights_slow_cells,Desv_weights_slow_cells,Mean_Coef_cluster,Desv_Coef_cluster,Mean_Coef_cluster_fast,Desv_Coef_cluster_fast,Mean_Coef_cluster_slow,Desv_Coef_cluster_slow,Mean_excentricity,Desv_excentricity,Mean_excentricity_fast,Desv_excentricity_fast,Mean_excentricity_slow,Desv_excentricity_slow,Mean_BC,Desv_BC,Mean_BC_fast,Desv_BC_fast,Mean_BC_slow,Desv_BC_slow,Mean_dist,Desv_dist,Mean_dist_fast_fast,Desv_dist_fast_fast,Mean_dist_fast_slow,Desv_dist_fast_slow,Mean_dist_slow_slow,Desv_dist_slow_slow,Mean_dist_slow_fast,Desv_dist_slow_fast ] = calculate_network_ccs(valid_cells,valid_cells_neigh_of_neigh,neighs_real,sides_cells,improved_mask,contour_img,cells_L,slow_cells,fast_cells,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas,folder,name)

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
    h=figure('Visible', 'on');%imshow(with_red)
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

        % Neighbors of slow and fast cells

        %Slow cells if conditions are true, and add a slow marker to Figure
        if ismember(n_cell,slow_cells)
            plot(round(centers(n_cell,1)),round(centers(n_cell,2)),'.r','MarkerSize',20)
            index_cell_slow=index_cell_slow+1;
            n_neighbors_of_slow(index_cell_slow)=sides_cells(n_cell);  
            if ~isempty(neighs_real{n_cell})
                n_slow_neighbors_of_slow(index_cell_slow)=length(intersect(cell2mat(neighs_real(n_cell))',slow_cells));
                n_fast_neighbors_of_slow(index_cell_slow)=length(intersect(cell2mat(neighs_real(n_cell))',fast_cells));
            end
            
        %Fast cells, add fast marker to Figure.    
        else
            plot(round(centers(n_cell,1)),round(centers(n_cell,2)),'.g','MarkerSize',20)
            index_cell_fast=index_cell_fast+1;
            n_neighbors_of_fast(index_cell_fast)=sides_cells(n_cell);
            if ~isempty(neighs_real{n_cell})
                n_slow_neighbors_of_fast(index_cell_fast)=length(intersect(cell2mat(neighs_real(n_cell))',slow_cells));
                n_fast_neighbors_of_fast(index_cell_fast)=length(intersect(cell2mat(neighs_real(n_cell))',fast_cells));
            end
        end

        for ii=1:(length(neighbors_network))
            graph_binary(n_cell,neighbors_network(ii))=1;
            graph_binary(neighbors_network(ii),n_cell)=1;
        end

        for ii=1:(length(neighbors_network))
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



    %CC17-22
    %Features slow cells - neighbors
    if index_cell_slow>0
        Mean_neighbors_of_slow=mean(n_neighbors_of_slow);
        Std_neighbors_of_slow=std(n_neighbors_of_slow);
        Mean_slow_neighbors_of_slow=mean(n_slow_neighbors_of_slow);
        Std_slow_neighbors_of_slow=std(n_slow_neighbors_of_slow);
        Mean_fast_neighbors_of_slow=mean(n_fast_neighbors_of_slow);
        Std_fast_neighbors_of_slow=std(n_fast_neighbors_of_slow);
    else
        Mean_neighbors_of_slow=0;
        Std_neighbors_of_slow=0;
        Mean_slow_neighbors_of_slow=0;
        Std_slow_neighbors_of_slow=0;
        Mean_fast_neighbors_of_slow=0;
        Std_fast_neighbors_of_slow=0;
    end

    %Features fast cells - neighbors
    if index_cell_fast>0
        Mean_neighbors_of_fast=mean(n_neighbors_of_fast);
        Std_neighbors_of_fast=std(n_neighbors_of_fast);
        Mean_slow_neighbors_of_fast=mean(n_slow_neighbors_of_fast);
        Std_slow_neighbors_of_fast=std(n_slow_neighbors_of_fast);
        Mean_fast_neighbors_of_fast=mean(n_fast_neighbors_of_fast);
        Std_fast_neighbors_of_fast=std(n_fast_neighbors_of_fast);
    else
        Mean_neighbors_of_fast=0;
        Std_neighbors_of_fast=0;
        Mean_slow_neighbors_of_fast=0;
        Std_slow_neighbors_of_fast=0;
        Mean_fast_neighbors_of_fast=0;
        Std_fast_neighbors_of_fast=0;
    end

    
    % Network features
    graph_rect=graph(valid_cells,valid_cells);


    %CHANGE THE DIRECTORY LOOKING FOR 'CODIGO BCT' to apply Prueba_brain
    %function
    addpath('Codigo_BCT')
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
    
    
    %CC37-38,43-44,49-50,55-56
    if isempty(fast_cells)

        Mean_weights_fast_cells=0;
        Desv_weights_fast_cells=0;
        Mean_Coef_cluster_fast=0;
        Desv_Coef_cluster_fast=0;
        Mean_excentricity_fast=0;
        Desv_excentricity_fast=0;
        Mean_BC_fast=0;
        Desv_BC_fast=0;

    else

        Mean_weights_fast_cells=mean(Sum_weights_each_node((fast_cells)));
        Desv_weights_fast_cells=std(Sum_weights_each_node((fast_cells)));
        Mean_Coef_cluster_fast=mean(Coef_cluster(fast_cells));
        Desv_Coef_cluster_fast=std(Coef_cluster(fast_cells));
        Mean_excentricity_fast=mean(ecc(fast_cells));
        Desv_excentricity_fast=std(ecc(fast_cells));
        Mean_BC_fast=mean(BC(fast_cells));
        Desv_BC_fast=std(BC(fast_cells));


    end


    %CC39-40,45-46,51-52,57-58
    if isempty(slow_cells)
        Mean_weights_slow_cells=0;
        Desv_weights_slow_cells=0;
        Mean_Coef_cluster_slow=0;
        Desv_Coef_cluster_slow=0;
        Mean_excentricity_slow=0;
        Desv_excentricity_slow=0;
        Mean_BC_slow=0;
        Desv_BC_slow=0;
    else

        Mean_weights_slow_cells=mean(Sum_weights_each_node((slow_cells)));
        Desv_weights_slow_cells=std(Sum_weights_each_node((slow_cells)));
        Mean_Coef_cluster_slow=mean(Coef_cluster(slow_cells));
        Desv_Coef_cluster_slow=std(Coef_cluster(slow_cells));
        Mean_excentricity_slow=mean(ecc(slow_cells));
        Desv_excentricity_slow=std(ecc(slow_cells));
        Mean_BC_slow=mean(BC(slow_cells));
        Desv_BC_slow=std(BC(slow_cells));

    end


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

    %CC61-62
    if ~isempty(fast_cells) 
        M1=triu(Matrix_shortest_distances_all_nodes(fast_cells,fast_cells));
        Mean_dist_fast_fast=mean(M1(M1~=0));
        Desv_dist_fast_fast=std(M1(M1~=0));
    else
        Mean_dist_fast_fast=0;
        Desv_dist_fast_fast=0;
    end

    %CC63-64
    if ~isempty(slow_cells) 
        M3=triu(Matrix_shortest_distances_all_nodes(slow_cells,slow_cells));
        Mean_dist_slow_slow=mean(M3(M3~=0));
        Desv_dist_slow_slow=std(M3(M3~=0));
    else
        Mean_dist_slow_slow=0;
        Desv_dist_slow_slow=0;
    end

    %CC65-CC68
    if ~isempty(slow_cells) && ~isempty(fast_cells)
        M2=triu(Matrix_shortest_distances_all_nodes(fast_cells,slow_cells));
        Mean_dist_fast_slow=mean(M2(M2~=0));
        Desv_dist_fast_slow=std(M2(M2~=0));

        M4=triu(Matrix_shortest_distances_all_nodes(slow_cells,fast_cells));
        Mean_dist_slow_fast=mean(M4(M4~=0));
        Desv_dist_slow_fast=std(M4(M4~=0));

    else 
        Mean_dist_fast_slow=0;
        Desv_dist_fast_slow=0;

        Mean_dist_slow_fast=0;
        Desv_dist_slow_fast=0;
    end

    
end

