function [data_cells_nuclei,data_cells_water,data_intercellular_space]=calculate_data_dapi(folder)
    

    %% loading images

    % Load segmented dapi's channel
    [BWmax,BWmin]=Segmentation_dapi(folder);
    
    % Load images needed to segment dapi channel (images got from segmentation without DAPI)
    load([folder '\Data_cc.mat'],'contour_img','contour_water','improved_mask','cells_L')    

    
    
    [H,W]=size(cells_L);

    %% Calculate mask of centroids
    %label new regions
    L_mask_nuclei_peaks = bwlabel(BWmax,8);
    L=bwlabel(BWmin,8);

    %calculate an image with white dots (1) marking centroids from each object
    s  = regionprops(BWmax, 'centroid');
    centroids = cat(1, s.Centroid);
    centroids=fliplr(round(centroids));
    mask_centroids=zeros(H,W);
    for i=1:size(centroids,1)
        mask_centroids(centroids(i,1),centroids(i,2))=i;
    end




    %%Unify values tor each diferent file (ones with improved_mask labelled and another without that)
    L_mask_improved = bwlabel(improved_mask,8);
    L_mask_improved(L_mask_improved>0)=1;
    

    % Assign an intercellular space to closest cell.
    intercellular_space_assigned=1-contour_img-L_mask_improved;
    L_intercellular_space_assigned = intercellular_space_assigned.*cells_L;
    
    %labelling as cells_img_L
    L_mask_improved=L_mask_improved.*cells_L;
    
    s  = regionprops(cells_L, 'Area'); 
    Area_cells = cat(1, s.Area);
    s  = regionprops(L_mask_improved, 'Area');
    Area_cells_water = cat(1, s.Area);
    s  = regionprops(L_intercellular_space_assigned, 'Area');
    Area_intercellular_space = cat(1, s.Area);
    s  = regionprops(L, 'Area');
    Area_object = cat(1, s.Area);
    s  = regionprops(L_mask_nuclei_peaks, 'Area');
    Area_nodes = cat(1, s.Area);




    for i=1:max(max(cells_L))

        %% Calculating data of nuclei (objects and peaks) about cells

        aux=zeros(H,W);
        aux(cells_L==i)=1;
        %%Cell
        data_cells_nuclei{i,1}=i;

        %%nuclei object
        concatenation_cell_nuclei=aux.*L; %%concat nuclei and cells (Cell X is owner of Y objetcs nuclei in L)
        object_aux=unique(concatenation_cell_nuclei);
        object_aux=object_aux(object_aux~=0);
        data_cells_nuclei{i,2}=object_aux; %nuclei which are belongings of cell

        %%Nodes of nuclei
        concatenation_cell_nuclei_peaks=aux.*L_mask_nuclei_peaks; %nuclei peaks with cells.
        object_aux=unique(concatenation_cell_nuclei_peaks);
        object_aux=object_aux(object_aux~=0);
        data_cells_nuclei{i,3}=object_aux;

        %%Centroids
        object_aux=aux.*mask_centroids; %% concatenation of centroids of peak nuclei with cells
        object_aux=unique(object_aux);
        object_aux=object_aux(object_aux~=0);
        data_cells_nuclei{i,4}=centroids(object_aux,:);

        %%Area Cell
        data_cells_nuclei{i,5}=Area_cells(i);

        %%Area peak which is overlapping cell 'i'
        s  = regionprops(concatenation_cell_nuclei_peaks, 'Area');
        Area_node_cell = cat(1, s.Area);
        data_cells_nuclei{i,6}=Area_node_cell(data_cells_nuclei{i,3});

        %%Overlapping percentaje of total nuclei peaks in comparison with area of peaks belong to cell 'i'    
        data_cells_nuclei{i,7}=(data_cells_nuclei{i,6}./Area_nodes(data_cells_nuclei{i,3}))*100;

        %%Objects area overlapping with cell 'i'
        s  = regionprops(concatenation_cell_nuclei, 'Area');
        Area_object_cell = cat(1, s.Area);
        data_cells_nuclei{i,8}=Area_object_cell(data_cells_nuclei{i,2});

        %%Overlapping percentaje of nuclei object in comparison with total nuclei object
        data_cells_nuclei{i,9}=(data_cells_nuclei{i,8}./Area_object(data_cells_nuclei{i,2}))*100;



        %% Calculating data of nuclei (objects and peaks) about cells water

        aux=zeros(H,W);
        aux(L_mask_improved==i)=1;

        %%Cell Water
        data_cells_water{i,1}=i;


        %%Object
        concatenation_cell_nuclei=aux.*L; %%concatenation of object with cell water (No collagen)
        object_aux=unique(concatenation_cell_nuclei);
        object_aux=object_aux(object_aux~=0);
        data_cells_water{i,2}=object_aux;

        %%Node
        concatenation_cell_nuclei_peaks=aux.*L_mask_nuclei_peaks; %%concatenacion de cells_img originales con picos de nucleo
        object_aux=unique(concatenation_cell_nuclei_peaks);
        object_aux=object_aux(object_aux~=0);
        data_cells_water{i,3}=object_aux;

        %%Centroids
        object_aux=aux.*mask_centroids; 
        object_aux=unique(object_aux);
        object_aux=object_aux(object_aux~=0);
        data_cells_water{i,4}=centroids(object_aux,:);

        %%Area Water
        data_cells_water{i,5}=Area_cells_water(i);

        %%Area peak wich is overlapping with cell 'i'
        s  = regionprops(concatenation_cell_nuclei_peaks, 'Area');
        Area_node_cell = cat(1, s.Area);
        data_cells_water{i,6}=Area_node_cell(data_cells_water{i,3});

        %%Percentaje of node overlapping with total area of node
        data_cells_water{i,7}=(data_cells_water{i,6}./Area_nodes(data_cells_water{i,3}))*100;

        %%Object area overlapping with cell water 'i'
        concatenation_cell_nuclei=aux.*L;
        s  = regionprops(concatenation_cell_nuclei, 'Area');
        Area_object_cell = cat(1, s.Area);
        data_cells_water{i,8}=Area_object_cell(data_cells_water{i,2});

        %%Percentaje of object area overlapping cell water about total area of object
        data_cells_water{i,9}=(data_cells_water{i,8}./Area_object(data_cells_water{i,2}))*100;


        %% Calculating data in relation to intercellular space and the overlapping with nuclei cells 

        aux=zeros(H,W);
        aux(L_intercellular_space_assigned==i)=1;

        %%Intercellular space
        data_intercellular_space{i,1}=i;

        %%Objects in intercellular space
        concatenation_cell_nuclei=aux.*L; %concatenation with object nuclei
        object_aux=unique(concatenation_cell_nuclei);
        object_aux=object_aux(object_aux~=0);
        data_intercellular_space{i,2}=object_aux;

        %%Nodes in intercellular space
        concatenation_cell_nuclei_peaks=aux.*L_mask_nuclei_peaks; %concatenation with peaks of object nuclei
        object_aux=unique(concatenation_cell_nuclei_peaks);
        object_aux=object_aux(object_aux~=0);
        data_intercellular_space{i,3}=object_aux;

        %%Centroids
        object_aux=aux.*mask_centroids; %concatenation centroids and peaks of cells in intercellular space
        object_aux=unique(object_aux);
        object_aux=object_aux(object_aux~=0);
        data_intercellular_space{i,4}=centroids(object_aux,:);

        %%Area of intercellular space belonging to cell 'i'
        data_intercellular_space{i,5}=Area_intercellular_space(i);

        %%Area of peaks overlapping intercellular space 'i'
        s  = regionprops(concatenation_cell_nuclei_peaks, 'Area');
        Area_node_cell = cat(1, s.Area);
        data_intercellular_space{i,6}=Area_node_cell(data_intercellular_space{i,3});

        %%Overlapping percentage of nodes reganding node total area
        data_intercellular_space{i,7}=(data_intercellular_space{i,6}./Area_nodes(data_intercellular_space{i,3}))*100;

        %%Object area overlapping intercellular space 'i'
        concatenation_cell_nuclei=aux.*L;
        s  = regionprops(concatenation_cell_nuclei, 'Area');
        Area_object_cell = cat(1, s.Area);
        data_intercellular_space{i,8}=Area_object_cell(data_intercellular_space{i,2});

        %%Overlapping percentage of object regarding intercellular space
        data_intercellular_space{i,9}=(data_intercellular_space{i,8}./Area_object(data_intercellular_space{i,2}))*100;
    end


    %% saving data

    save([folder '\Data_channel_blue.mat'],'L','L_mask_nuclei_peaks','L_mask_improved','L_intercellular_space_assigned','centroids','data_cells_nuclei','data_cells_water','data_intercellular_space')

end