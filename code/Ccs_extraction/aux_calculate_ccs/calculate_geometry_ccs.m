function [Mean_Area,Std_Area,Mean_slow_cells_area,Std_slow_cells_area,Mean_fast_cells_area,Std_fast_cells_area,Mean_major_axis,Mean_minor_axis,Mean_relation_axis,Std_relation_axis,Mean_Pix_convex_region,Std_Pix_convex_region,Mean_relation_areas,Std_relation_areas,Average_slow_cells,cell_area,major_axis,minor_axis,Pix_convex_region,Relation_valid_areas]=calculate_geometry_ccs(cellular_mask,Cells_Img,valid_cells,contour_watershed,slow_cells,fast_cells)

%This is an auxiliar function to calculate geometry properties from our
%images

    % CC1 and CC2
    s=regionprops(Cells_Img,'Area');
    cell_area=cat(1,s.Area);

    Area_valid_cells=cell_area(valid_cells);
    Mean_Area=mean(Area_valid_cells);
    Std_Area=std(Area_valid_cells);
  
    % Number of slow and fast cells 
    n_slow_cells=length(slow_cells);
    n_fast_cells=length(fast_cells);

    % CC69
    Average_slow_cells=n_slow_cells/(n_fast_cells+n_slow_cells);

    % CC3-CC6
    %Slow and fast cells area
    Mean_slow_cells_area=mean(cell_area(slow_cells));
    Std_slow_cells_area=std(cell_area(slow_cells));
    Mean_fast_cells_area=mean(cell_area(fast_cells));
    Std_fast_cells_area=std(cell_area(fast_cells));

    % CC7-CC10
    %elongation (major and minor axis cells)
    major_axis = regionprops(cellular_mask,'MajorAxisLength');
    major_axis = cat(1, major_axis.MajorAxisLength);
    Mean_major_axis = mean(major_axis(valid_cells));

    minor_axis = regionprops(cellular_mask,'MinorAxisLength');
    minor_axis = cat(1, minor_axis.MinorAxisLength);
    Mean_minor_axis = mean(minor_axis(valid_cells));

    Relation_axis=major_axis./minor_axis;
    Mean_relation_axis=mean(Relation_axis(valid_cells));
    Std_relation_axis=std(Relation_axis(valid_cells));

    % CC11-CC12
    %convex hull
    Pix_convex_region=regionprops(cellular_mask,'Solidity');
    Pix_convex_region=cat(1, Pix_convex_region.Solidity);
    Mean_Pix_convex_region=mean(Pix_convex_region(valid_cells));
    Std_Pix_convex_region=std(Pix_convex_region(valid_cells));

    %Area water
    L_contour_water = bwlabel(contour_watershed,8);
    area_water = regionprops(L_contour_water, 'Area');
    area_water = cat(1, area_water.Area);
    [value,ix]=max(area_water);
    contour_watershed(L_contour_water==ix)=0;
    contour_watershed(contour_watershed~=0)=1;

    L_contour_water = contour_watershed.*Cells_Img;
    area_water = regionprops(L_contour_water, 'Area');
    area_water = cat(1, area_water.Area);
    cellular_mask=im2bw(cellular_mask,0.5);


    %Go around the cells to clean the remaining connections
    for i=1:max(max(L_contour_water))
        v=find(cellular_mask(L_contour_water==i)==0);
        prob_deleting=(length(v)/area_water(i))*100; %% If a cell in cellular_mask is really small in comparison with a cell of cells
        if prob_deleting>80
            contour_watershed(L_contour_water==i)=0;
        end
    end
    L_contour_water = bwlabel(contour_watershed,8);
    L_contour_water(L_contour_water>0)=1;
    L_contour_water=L_contour_water.*Cells_Img;

    s  = regionprops(L_contour_water, 'Area');
    Area_water = cat(1, s.Area);

    % CC13-CC14
    %Relation between cells areas (cells) and real cells areas (cellular_mask)
    Relation_valid_areas=Area_water(valid_cells)./cell_area(valid_cells);

    Mean_relation_areas=mean(Relation_valid_areas);
    Std_relation_areas=std(Relation_valid_areas);


end

