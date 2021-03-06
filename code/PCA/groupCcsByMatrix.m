%group ccs by matrix relative to genotype

path='D:\Pedro\CABD-mouses-Carvajal\processedImages\';

load([path 'pathProcessedImages.mat'])

%%SOL

solPath=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'SOL')), listPathProcessedImages,'UniformOutput',false));
solPath=listPathProcessedImages(find(solPath==1));
l1Path=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\L1\')), solPath,'UniformOutput',false));
l1Path=solPath(find(l1Path==1));
l2Path=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\L2\')), solPath,'UniformOutput',false));
l2Path=solPath(find(l2Path==1));
wtPath=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\WT\')), solPath,'UniformOutput',false));
wtPath=solPath(find(wtPath==1));

solL1_81=[];
solL2_81=[];
solWT_81=[];
for i=1:max([size(l1Path) size(l2Path) size(wtPath)])
    
    if i<size(l1Path,1)
        load([l1Path{i} '\Results_69_cc.mat']);
        load([l1Path{i} '\Results_dapi_12_cc.mat']);
        solL1_81=[solL1_81;Mean_Area,Std_Area,Mean_slow_cells_area,Std_slow_cells_area,Mean_fast_cells_area,Std_fast_cells_area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Std_neighbors_of_slow,Std_neighbors_of_fast,Mean_slow_neighbors_of_slow,Mean_fast_neighbors_of_slow,Mean_slow_neighbors_of_fast,Mean_fast_neighbors_of_fast,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_weights_fast_cells,Desv_weights_fast_cells,Mean_weights_slow_cells,Desv_weights_slow_cells,Mean_Coef_cluster,Desv_Coef_cluster,Mean_Coef_cluster_fast,Desv_Coef_cluster_fast,Mean_Coef_cluster_slow,Desv_Coef_cluster_slow,Mean_excentricity,Desv_excentricity,Mean_excentricity_fast,Desv_excentricity_fast,Mean_excentricity_slow,Desv_excentricity_slow,Mean_BC,Desv_BC,Mean_BC_fast,Desv_BC_fast,Mean_BC_slow,Desv_BC_slow,Mean_dist,Desv_dist,Mean_dist_fast_fast,Desv_dist_fast_fast,Mean_dist_fast_slow,Desv_dist_fast_slow,Mean_dist_slow_slow,Desv_dist_slow_slow,Mean_dist_slow_fast,Desv_dist_slow_fast,Average_slow_cells,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end

    if i<size(l2Path,1)
        load([l2Path{i} '\Results_69_cc.mat']);
        load([l2Path{i} '\Results_dapi_12_cc.mat']);
        solL2_81=[solL2_81;Mean_Area,Std_Area,Mean_slow_cells_area,Std_slow_cells_area,Mean_fast_cells_area,Std_fast_cells_area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Std_neighbors_of_slow,Std_neighbors_of_fast,Mean_slow_neighbors_of_slow,Mean_fast_neighbors_of_slow,Mean_slow_neighbors_of_fast,Mean_fast_neighbors_of_fast,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_weights_fast_cells,Desv_weights_fast_cells,Mean_weights_slow_cells,Desv_weights_slow_cells,Mean_Coef_cluster,Desv_Coef_cluster,Mean_Coef_cluster_fast,Desv_Coef_cluster_fast,Mean_Coef_cluster_slow,Desv_Coef_cluster_slow,Mean_excentricity,Desv_excentricity,Mean_excentricity_fast,Desv_excentricity_fast,Mean_excentricity_slow,Desv_excentricity_slow,Mean_BC,Desv_BC,Mean_BC_fast,Desv_BC_fast,Mean_BC_slow,Desv_BC_slow,Mean_dist,Desv_dist,Mean_dist_fast_fast,Desv_dist_fast_fast,Mean_dist_fast_slow,Desv_dist_fast_slow,Mean_dist_slow_slow,Desv_dist_slow_slow,Mean_dist_slow_fast,Desv_dist_slow_fast,Average_slow_cells,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end

    if i<size(wtPath,1)
        load([wtPath{i} '\Results_69_cc.mat']);
        load([wtPath{i} '\Results_dapi_12_cc.mat']);
        solWT_81=[solWT_81;Mean_Area,Std_Area,Mean_slow_cells_area,Std_slow_cells_area,Mean_fast_cells_area,Std_fast_cells_area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Std_neighbors_of_slow,Std_neighbors_of_fast,Mean_slow_neighbors_of_slow,Mean_fast_neighbors_of_slow,Mean_slow_neighbors_of_fast,Mean_fast_neighbors_of_fast,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_weights_fast_cells,Desv_weights_fast_cells,Mean_weights_slow_cells,Desv_weights_slow_cells,Mean_Coef_cluster,Desv_Coef_cluster,Mean_Coef_cluster_fast,Desv_Coef_cluster_fast,Mean_Coef_cluster_slow,Desv_Coef_cluster_slow,Mean_excentricity,Desv_excentricity,Mean_excentricity_fast,Desv_excentricity_fast,Mean_excentricity_slow,Desv_excentricity_slow,Mean_BC,Desv_BC,Mean_BC_fast,Desv_BC_fast,Mean_BC_slow,Desv_BC_slow,Mean_dist,Desv_dist,Mean_dist_fast_fast,Desv_dist_fast_fast,Mean_dist_fast_slow,Desv_dist_fast_slow,Mean_dist_slow_slow,Desv_dist_slow_slow,Mean_dist_slow_fast,Desv_dist_slow_fast,Average_slow_cells,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end

end

%%TA

taPath=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'TA')), listPathProcessedImages,'UniformOutput',false));
taPath=listPathProcessedImages(find(taPath==1));
l1Path=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\L1\')), taPath,'UniformOutput',false));
l1Path=taPath(find(l1Path==1));
l2Path=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\L2\')), taPath,'UniformOutput',false));
l2Path=taPath(find(l2Path==1));
wtPath=cell2mat(cellfun(@(x) 1-isempty(strfind(x,'\WT\')), taPath,'UniformOutput',false));
wtPath=taPath(find(wtPath==1));


taL1_46=[];
taL2_46=[];
taWT_46=[];
for i=1:max([size(l1Path) size(l2Path) size(wtPath)])
    
    if i<size(l1Path,1)
        load([l1Path{i} '\Results_34_cc.mat']);
        load([l1Path{i} '\Results_dapi_12_cc.mat']);
        taL1_46=[taL1_46;Mean_Area,Std_Area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_Coef_cluster,Desv_Coef_cluster,Mean_excentricity,Desv_excentricity,Mean_BC,Desv_BC,Mean_dist,Desv_dist,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end



    if i<size(l2Path,1)
        load([l2Path{i} '\Results_34_cc.mat']);
        load([l2Path{i} '\Results_dapi_12_cc.mat']);
        taL2_46=[taL2_46;Mean_Area,Std_Area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_Coef_cluster,Desv_Coef_cluster,Mean_excentricity,Desv_excentricity,Mean_BC,Desv_BC,Mean_dist,Desv_dist,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end

    if i<size(wtPath,1)
        load([wtPath{i} '\Results_34_cc.mat']);
        load([wtPath{i} '\Results_dapi_12_cc.mat']);
        taWT_46=[taWT_46;Mean_Area,Std_Area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Mean_neighbors,Std_neighbors,Mean_Relation_areas_neighborhood,Std_Relation_areas_neighborhood,Mean_relation_major_axis_neighbors,Std_relation_major_axis_neighbors,Mean_relation_minor_axis_neighbors,Std_relation_minor_axis_neighbors,Mean_relation_relation_axis_neighbors,Std_relation_relation_axis_neighbors,Mean_relation_Pix_convex_region_neighbors,Std_relation_Pix_convex_region_neighbors,Mean_relation_relation_areas_neighbors,Std_relation_relation_areas_neighbors,Mean_sum_weights,Desv_sum_weights,Mean_Coef_cluster,Desv_Coef_cluster,Mean_excentricity,Desv_excentricity,Mean_BC,Desv_BC,Mean_dist,Desv_dist,mean_peaks_cel_water_val,mean_peaks_collagen_val,mean_peaks_cell_total_val,desv_n_peaks_cwater,desv_n_peaks_collagen,desv_n_peaks_cel_total,Percentage_Area_Object_water_cell,Percentage_Area_Object_collagen,Percentage_Area_Object_cell,desv_area_obj_cwater,desv_area_obj_collagen,desv_area_obj_cel_total];
    end

end

save('D:\Pedro\CABD-mouses-Carvajal\PCA_data\matrix_cc.mat','solL1_81','solL2_81','solWT_81','taL1_46','taL2_46','taWT_46')