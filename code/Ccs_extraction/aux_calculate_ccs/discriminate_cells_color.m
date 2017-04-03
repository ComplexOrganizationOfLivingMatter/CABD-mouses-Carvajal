function [slow_cells,fast_cells]=discriminate_cells_color(cellular_mask, Img,valid_cells)

    %We want adquire information about channel R intensity in cellular regions
    %to classify cells as slow or fast cell.
    R=Img(:,:,1);
    R(cellular_mask==0)=0;
    R=imadjust(R); %enhance
    
    
    %Get intensity for each cellular region
    Mean_R = regionprops(cellular_mask, R, 'MeanIntensity'); 
    Mean_R = cat(1, Mean_R.MeanIntensity);

    %A cell will be a slow cell if the 15% of RED intensity of cellular region
    %is >=100, or his average is > 65.(this values could be modified depends of
    %the intensity image), else cell will be a fast cell.
    for i=1:max(max(cellular_mask))
        Intensities=R(cellular_mask==i);
        n_int=length(find(Intensities>=100));
        perc_intense_slow(i)=n_int/length(Intensities);
    end
    Mean_R_valid_cells=Mean_R(valid_cells);
    perc_intense_slow_valid_cells=perc_intense_slow(valid_cells);

    slow_cells=valid_cells(unique([find(Mean_R_valid_cells>65)' find(perc_intense_slow_valid_cells>=0.15)]));
    fast_cells=setxor(slow_cells,valid_cells);
    
end

