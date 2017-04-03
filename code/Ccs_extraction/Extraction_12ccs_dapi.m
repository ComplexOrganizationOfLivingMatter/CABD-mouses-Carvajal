function Extraction_12ccs_dapi(folder,name,valid_cells)

%Calculate data of dapi
[data_cells_nuclei,data_cells_water,data_intercellular_space]=calculate_data_dapi(folder);




%% Extraction cc blue channel

%Num nuclei in cell water %cc 1
peaks_centroid_cell_water=data_cells_water(:,4); %%nº centroid of peaks into cell water (no collagen), include no valid cells
peaks_centroid_cell_water_valid=peaks_centroid_cell_water(valid_cells,1);
n_peaks_cell_water=cell2mat(cellfun(@(x) numel(x), peaks_centroid_cell_water_valid, 'UniformOutput', false))/2;
Peaks_centr_cell_water=sum(n_peaks_cell_water);
mean_peaks_cel_water_val=Peaks_centr_cell_water/length(valid_cells);

%Num of nuclei in collagen belonging to cell %cc 2
peaks_centroid_collagen=data_intercellular_space(:,4);
peaks_centroid_collagen_valid=peaks_centroid_collagen(valid_cells,1);
n_peaks_collagen=cell2mat(cellfun(@(x) numel(x), peaks_centroid_collagen_valid, 'UniformOutput', false))/2;
Peaks_centr_collagen=sum(n_peaks_collagen);
mean_peaks_collagen_val=Peaks_centr_collagen/length(valid_cells);


%Num of nuclei in total cell (c.water + collagen) %cc3
peaks_centroid_cell_total=data_cells_nuclei(:,4);
peaks_centroide_cell_total_valid=peaks_centroid_cell_total(valid_cells,1);
n_peaks_valid=cell2mat(cellfun(@(x) numel(x), peaks_centroide_cell_total_valid, 'UniformOutput', false))/2;
Peaks_centr_cell_total=sum(n_peaks_valid);
mean_peaks_cell_total_val=Peaks_centr_cell_total/length(valid_cells);



%Standard desviation of number of peaks in cell water %%cc4

desv_n_peaks_cwater=std(n_peaks_cell_water);

%Standard desviation of number of peaks in collagen %%cc5

desv_n_peaks_collagen=std(n_peaks_collagen);

%Standard desviation of number of peaks in cell water + collagen %%cc6

desv_n_peaks_cel_total=std(n_peaks_valid);



%object's percentage in cell water %cc 7
area_object_cell_water=data_cells_water(:,8);
area_object_cell_water_valid=cell2mat(area_object_cell_water(valid_cells,1));
area_cell_water=data_cells_water(:,5);
area_cell_water_valid=cell2mat(area_cell_water(valid_cells,1));
area_total_object_water=sum(area_object_cell_water_valid);
area_total_water=sum(area_cell_water_valid);

Percentage_Area_Object_water_cell=(area_total_object_water/area_total_water)*100;

%object's percentage in collagen %cc 8
area_object_collagen=data_intercellular_space(:,8);
area_object_collagen_valid=cell2mat(area_object_collagen(valid_cells,1));
area_collagen=data_intercellular_space(:,5);
area_collagen_valid=cell2mat(area_collagen(valid_cells,1));
area_total_object_collagen=sum(area_object_collagen_valid);
area_total_collagen=sum(area_collagen_valid);

Percentage_Area_Object_collagen=(area_total_object_collagen/area_total_collagen)*100;

%object's percentage in total cell %cc 9
area_object_cell=data_cells_nuclei(:,8);
area_object_cell_valid=cell2mat(area_object_cell(valid_cells,1));
area_cell=data_cells_nuclei(:,5);
area_cell_valid=cell2mat(area_cell(valid_cells,1));
area_total_object=sum(area_object_cell_valid);
area_total=sum(area_cell_valid);

Percentage_Area_Object_cell=(area_total_object/area_total)*100;



%Standard desviation object area in water cells %%cc10

desv_area_obj_cwater=std(area_object_cell_water_valid);

%Standard desviation object area in collagen %%cc11

desv_area_obj_collagen=std(area_object_collagen_valid);

%Standard desviation object area in cells+collagen %%cc12

desv_area_obj_cel_total=std(area_object_cell_valid);



%%Save 12 ccs of nuclei

stringres=strcat(folder,'\', 'Results_dapi_12_cc.mat');
save (stringres,'mean_peaks_cel_water_val','mean_peaks_collagen_val','mean_peaks_cell_total_val','desv_n_peaks_cwater','desv_n_peaks_collagen','desv_n_peaks_cel_total','Percentage_Area_Object_water_cell','Percentage_Area_Object_collagen','Percentage_Area_Object_cell','desv_area_obj_cwater','desv_area_obj_collagen','desv_area_obj_cel_total')




end

