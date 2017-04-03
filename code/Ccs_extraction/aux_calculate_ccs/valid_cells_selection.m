%%Select valid, no valid cells, valid_cells 4' and 5'

function [valid_cells,no_valid_cells,valid_cells_neigh_of_neigh,no_valid_cells_neigh_of_neigh,valid_cells_4,valid_cells_5] = valid_cells_selection (L_img,neighs_real)

      
    %Create mask to find border cells
    [H,W]=size(L_img);
    mask=zeros(H,W);
    mask(:,1)=1;
    mask(:,W)=1;
    mask(1,:)=1;
    mask(H,:)=1;
    
    border_cells=unique(L_img.*mask);
    
    %General valid and no valid cells
    valid_cells_preview= setxor(unique(L_img),border_cells);
    border_cells=border_cells(border_cells~=0); %delete cell 0
    no_valid_cells_preview=border_cells;
    
    valid_cells=[];
    no_valid_cells=[];
    
    %% Labelling as no valid cells isolated valid cells (rounded by border no valid cells)
    flag=0;

    for j=1:length(valid_cells_preview) % Bucle que recorre todas celulas validas para comprobar
        neig_cel_j=neighs_real{valid_cells_preview(j)};
        no_match=[];
        for i=1:length(neig_cel_j)% neigh loop
            no_match(i)=isempty(find(neig_cel_j(i)==no_valid_cells_preview, 1)); %Variable que vale 1 si no existe coincidencia de la celula j con alguna de las celulas no validas
        end
        if sum(no_match)==0
            valid_cells=valid_cells_preview(valid_cells_preview~=valid_cells_preview(j));
            no_valid_cells=sort([valid_cells_preview(j);no_valid_cells_preview]);
            flag=1;
        end
    end
    
    if isempty(no_valid_cells)==1
        valid_cells=valid_cells_preview;
        no_valid_cells=no_valid_cells_preview;
    end
    
    %% Calculating valid cells without neighbours of no valid valid. It necessary for features neighs of neighs
   
    valid_cells_neigh_of_neigh=[];
    no_valid_cells_neigh_of_neigh=[];
    
    for i=1:length(no_valid_cells)
        
        no_valid_cells_neigh_of_neigh=[no_valid_cells_neigh_of_neigh;cell2mat(neighs_real(no_valid_cells(i)))];
    
    end
    no_valid_cells_neigh_of_neigh=union(unique(no_valid_cells_neigh_of_neigh),no_valid_cells);
    valid_cells_neigh_of_neigh=setxor(union(valid_cells,no_valid_cells),no_valid_cells_neigh_of_neigh);
    
    
    
    
    %% Create adjacency matrix to know the distance to no valid cells from
    adj_matrix=zeros(size(neighs_real,2));

    for i=1:size(neighs_real,2)
        neighs=neighs_real{1,i};
        adj_matrix(i,neighs)=1;
    end

    %Distance matrix since adjacency matrix
    [dist_matrix] = graphallshortestpaths(sparse(adj_matrix));
    
    dist_valid_to_no_valid=dist_matrix(valid_cells,no_valid_cells);
    
    closest_no_valid_cell=min(dist_valid_to_no_valid');

    
    
    %% Get valid cells necessary to execute graphlets
    valid_cells_4=valid_cells(closest_no_valid_cell>=3);
    valid_cells_5=valid_cells(closest_no_valid_cell>=4);
    
    
    
    
end