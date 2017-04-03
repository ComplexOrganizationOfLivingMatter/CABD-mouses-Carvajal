function [slow_cells,fast_cells,old_slow_cells,old_fast_cells]=pick_type_cells(folder, name,fast_cells,slow_cells,valid_cells,improved_mask)
    
%Clicking over cells in the network image, we chage the type of cell. Click
%over red dot cells(slow cells) -> slow cells become into fast cells. And vice versa  

    load([folder '\Data_cc.mat'],'Img');     
    Img_network=imread([folder '\' name '_network.jpg']);

   
    R=Img(:,:,1);
    R(improved_mask==0)=0; %delete red intensity of collagen      
    R_adjust=imadjust(R); %enhance
    R_adjust(:,:,2)=0;%Necessary to show -> imshow
    R_adjust(:,:,3)=0;
    
    flag = 0;
    
    while flag ~=1
    
        f=figure;
        imshow([Img_network,R_adjust])

        [y,x]=getpts(f);
        x=round(x);y=round(y);

        picked_cells=[];
        for i=1:length(x)
            picked_cells=[picked_cells,improved_mask(x(i),y(i))];
        end

        picked_cells=unique(picked_cells(picked_cells~=0)');
        picked_cells=intersect(picked_cells,valid_cells');

        slow2fast=intersect(picked_cells,slow_cells);
        fast2slow=intersect(picked_cells,fast_cells);

        new_fast_cells=sort([setxor(picked_cells,fast_cells);slow2fast]);
        new_slow_cells=sort([setxor(picked_cells,slow_cells);fast2slow]);

        flag=input('if are you sure insert 1: ');
    
        close all
    
    end
    
    old_slow_cells=slow_cells;
    old_fast_cells=fast_cells;
    
    slow_cells=unique(new_slow_cells);
    fast_cells=unique(new_fast_cells);
    
    save([folder '\slow_fast_cells_correction.mat'],'slow_cells','fast_cells','old_slow_cells','old_fast_cells')
    
    
end

