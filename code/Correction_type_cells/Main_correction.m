function Main_correction(folder,name)
%This function is necessary in cases where velocity property is bad
%labelled in network cell. This process has in account that segmentation
%process is checked



   
    load([folder '\Data_cc.mat'])

    %this function let modify type of cells
    [slow_cells,fast_cells,old_slow_cells,old_fast_cells]=pick_type_cells(folder, name,fast_cells,slow_cells,valid_cells,improved_mask);

    

    % Calculate 15 geometry ccs: CC1-CC14 & CC69
    [Mean_Area,Std_Area,Mean_slow_cells_area,Std_slow_cells_area,Mean_fast_cells_area,Std_fast_cells_area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Average_slow_cells,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas]=calculate_geometry_ccs(improved_mask,cells_L,valid_cells,contour_water,slow_cells,fast_cells);
    
      
    
    %% Calculate ccs of network. CC15-68
    [Mean_neighbors,Std_neighbors,Std_neighbors_of_slow,Std_neighbors_of_fast,Mean_slow_neighbors_of_slow,Mean_fast_neighbors_of_slow,Mean_slow_neighbors_of_fast,Mean_fast_neighbors_of_fast,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_weights_fast_cells,Desv_weights_fast_cells,Mean_weights_slow_cells,Desv_weights_slow_cells,Mean_Coef_cluster,Desv_Coef_cluster,Mean_Coef_cluster_fast,Desv_Coef_cluster_fast,Mean_Coef_cluster_slow,Desv_Coef_cluster_slow,Mean_excentricity,Desv_excentricity,Mean_excentricity_fast,Desv_excentricity_fast,Mean_excentricity_slow,Desv_excentricity_slow,Mean_BC,Desv_BC,Mean_BC_fast,Desv_BC_fast,Mean_BC_slow,Desv_BC_slow,Mean_dist,Desv_dist,Mean_dist_fast_fast,Desv_dist_fast_fast,Mean_dist_fast_slow,Desv_dist_fast_slow,Mean_dist_slow_slow,Desv_dist_slow_slow,Mean_dist_slow_fast,Desv_dist_slow_fast ] = calculate_network_ccs(valid_cells,valid_cells_neigh_of_neigh,neighs_real,sides_cells,improved_mask,contour_img,cells_L,slow_cells,fast_cells,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas,folder,name);


    
    
    
    
    %% SAVING

    %%Save 69 cc (There are more feature extracted, you could save what you want)

    stringres=[folder '\Results_69_cc.mat'];
    save (stringres,'Mean_Area','Std_Area','Mean_slow_cells_area','Std_slow_cells_area','Mean_fast_cells_area','Std_fast_cells_area','Mean_major_axis','Mean_minor_axis','Mean_relation_axis','Std_relation_axis','Mean_Pix_convex_region','Std_Pix_convex_region','Mean_relation_areas','Std_relation_areas','Mean_neighbors','Std_neighbors','Std_neighbors_of_slow','Std_neighbors_of_fast','Mean_slow_neighbors_of_slow','Mean_fast_neighbors_of_slow','Mean_slow_neighbors_of_fast','Mean_fast_neighbors_of_fast','Mean_Relation_areas_neighborhood','Std_Relation_areas_neighborhood','Mean_relation_major_axis_neighbors','Std_relation_major_axis_neighbors','Mean_relation_minor_axis_neighbors','Std_relation_minor_axis_neighbors','Mean_relation_relation_axis_neighbors','Std_relation_relation_axis_neighbors','Mean_relation_Pix_convex_region_neighbors','Std_relation_Pix_convex_region_neighbors','Mean_relation_relation_areas_neighbors','Std_relation_relation_areas_neighbors','Mean_sum_weights','Desv_sum_weights','Mean_weights_fast_cells','Desv_weights_fast_cells','Mean_weights_slow_cells','Desv_weights_slow_cells','Mean_Coef_cluster','Desv_Coef_cluster','Mean_Coef_cluster_fast','Desv_Coef_cluster_fast','Mean_Coef_cluster_slow','Desv_Coef_cluster_slow','Mean_excentricity','Desv_excentricity','Mean_excentricity_fast','Desv_excentricity_fast','Mean_excentricity_slow','Desv_excentricity_slow','Mean_BC','Desv_BC','Mean_BC_fast','Desv_BC_fast','Mean_BC_slow','Desv_BC_slow','Mean_dist','Desv_dist','Mean_dist_fast_fast','Desv_dist_fast_fast','Mean_dist_fast_slow','Desv_dist_fast_slow','Mean_dist_slow_slow','Desv_dist_slow_slow','Mean_dist_slow_fast','Desv_dist_slow_fast','Average_slow_cells')

    %%Save some important data
    stringres=[folder '\Data_cc.mat'];
    save (stringres,'slow_cells','fast_cells','old_slow_cells','old_fast_cells','cells_L','valid_cells','no_valid_cells','valid_cells_neigh_of_neigh','no_valid_cells_neigh_of_neigh','valid_cells_4','valid_cells_5','neighs_real','sides_cells','-append')
    


end

