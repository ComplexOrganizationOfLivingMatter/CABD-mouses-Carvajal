function [Mean_Area,Std_Area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas] = calculate_geometry_ccs_withoutSlowFastCells(improved_mask,cells_L,valid_cells )

improved_mask=bwareaopen(improved_mask,10);

% CC1 and CC2
    s=regionprops(improved_mask,'Area');
    Area_water=cat(1,s.Area);
    Mean_Area=mean(Area_water);
    Std_Area=std(Area_water);

% CC3 - CC6
    %elongation (major and minor axis cells) abd relation between them
    major_axis = regionprops(improved_mask,'MajorAxisLength');
    major_axis = cat(1, major_axis.MajorAxisLength);
    Mean_major_axis = mean(major_axis);

    minor_axis = regionprops(improved_mask,'MinorAxisLength');
    minor_axis = cat(1, minor_axis.MinorAxisLength);
    Mean_minor_axis = mean(minor_axis);

    Relation_axis=major_axis./minor_axis;
    Mean_relation_axis=mean(Relation_axis);
    Std_relation_axis=std(Relation_axis);

% CC7 & CC8
    %convex hull
    Pix_convex_region=regionprops(improved_mask,'Solidity');
    Pix_convex_region=cat(1, Pix_convex_region.Solidity);
    Mean_Pix_convex_region=mean(Pix_convex_region);
    Std_Pix_convex_region=std(Pix_convex_region);

% CC9-CC10
    %Relation between cells areas (cells) and real cells areas (cellular_mask)
    s  = regionprops(cells_L, 'Area');
    cell_area = cat(1, s.Area);
    Relation_valid_areas=Area_water(valid_cells)./cell_area(valid_cells);
    Mean_relation_areas=mean(Relation_valid_areas);
    Std_relation_areas=std(Relation_valid_areas);

 
  
end

