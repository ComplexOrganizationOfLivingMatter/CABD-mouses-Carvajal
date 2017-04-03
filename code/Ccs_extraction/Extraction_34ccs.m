function [valid_cells]=Extraction_34ccs(folder,name)

  
    %% create necessary images from segmented image
    imgAux=imread([folder '\' name 'g_edited.jpg']);
    imgAux=rgb2gray(imgAux);
    imgAux=bwareaopen(im2bw(imgAux,0.5),50,8);
    
    %Create improved_mask
    improved_mask=1-imgAux;
    improved_mask=bwareaopen(improved_mask,50,8);
    imgAux=1-improved_mask;
    
    %Create contour_water image
    se=strel('disk',1);
    contour_water=1-logical(watershed(imdilate(bwmorph(imgAux,'remove'),se)));
    
    %Create cells_L and label improved_mask
    cells_L=double(watershed(imgAux));
    improved_mask=cells_L.*improved_mask;
    
    %Create contour_img
    contour_img=1-logical(cells_L);
    
    %load real image
    pathImgRaw=strrep(folder,'processedImages','photos\rawImages');
    Img_r=imread([pathImgRaw 'r.jpg']);
    Img_g=imread([pathImgRaw 'g.jpg']);
    Img_b=imread([pathImgRaw 'b.jpg']);
    Img=Img_r+Img_g+Img_b; 
    
    imwrite(Img,[folder '\' name '.jpg']);
    
    %% Calculate neighbors
    [neighs_real,sides_cells]=calculate_neighbours(cells_L);
       
    %% Selection of valid cells
    [valid_cells,no_valid_cells,valid_cells_neigh_of_neigh,no_valid_cells_neigh_of_neigh,valid_cells_4,valid_cells_5] = valid_cells_selection (cells_L,neighs_real);
   
    %% Calculate 10 geometry ccs: CC1-2 CC7-14 & CC69
    [Mean_Area,Std_Area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas] = calculate_geometry_ccs_withoutSlowFastCells(improved_mask,cells_L,valid_cells );

    %% Calculate ccs of network. CC15-16 CC23-36 CC41-42 CC47-48 CC53-54 CC59-60
    [Mean_neighbors,Std_neighbors,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_Coef_cluster,Desv_Coef_cluster,Mean_excentricity,Desv_excentricity,Mean_BC,Desv_BC,Mean_dist,Desv_dist] = calculate_network_ccs_withoutSlowFastCells(valid_cells,valid_cells_neigh_of_neigh,neighs_real,sides_cells,improved_mask,contour_img,cells_L,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas,folder,name);


    %% SAVING

    %%Save 34 cc (There are more feature extracted, you could save what you want)
    stringres=[folder '\Results_34_cc.mat'];
    save (stringres,'Mean_Area','Std_Area','Mean_major_axis','Mean_minor_axis','Mean_relation_axis','Std_relation_axis','Mean_Pix_convex_region','Std_Pix_convex_region','Mean_relation_areas','Std_relation_areas','Mean_neighbors','Std_neighbors','Mean_Relation_areas_neighborhood','Std_Relation_areas_neighborhood','Mean_relation_major_axis_neighbors','Std_relation_major_axis_neighbors','Mean_relation_minor_axis_neighbors','Std_relation_minor_axis_neighbors','Mean_relation_relation_axis_neighbors','Std_relation_relation_axis_neighbors','Mean_relation_Pix_convex_region_neighbors','Std_relation_Pix_convex_region_neighbors','Mean_relation_relation_areas_neighbors','Std_relation_relation_areas_neighbors','Mean_sum_weights','Desv_sum_weights','Mean_Coef_cluster','Desv_Coef_cluster','Mean_excentricity','Desv_excentricity','Mean_BC','Desv_BC','Mean_dist','Desv_dist')

    %%Save some important data
    stringres=[folder '\Data_cc.mat'];
    save (stringres,'improved_mask','contour_water','contour_img','Img','cells_L','valid_cells','no_valid_cells','valid_cells_neigh_of_neigh','no_valid_cells_neigh_of_neigh','valid_cells_4','valid_cells_5','neighs_real','sides_cells')
    
    
    
end
