

function Segmentation(photoPath)

    
    %%% Variables
    Noise_background=500; % Delete noise
    DilateErode=50;
    Divide_cells=2; % Ratio used to divide cells
    Intercellular_espace=2; % Increase distances between cells, reduce artifacts and divide cells
    Delete_artifacts=1000; % It's depends of min size cell 


    %% SEGMENTATION

    %%Load images

    Img_g=imread(photoPath);

    % We modify G regarding intensity property. Get a threshold overlapping 3 diferent layers to obtein the most representative data. 
    G=rgb2gray(Img_g);
    J=adapthisteq(G);
    meanJ=mean(mean(J));
    h3=(meanJ/3); h15=(meanJ/1.5); h2=meanJ/2;

    BWmin3 = imextendedmin(G,h3);
    BWmin2 = imextendedmin(G,h2);
    BWmin15 = imextendedmin(G,h15);


    BWmin=BWmin15+BWmin3+BWmin2;

    %% DELETING NO CELLS

    % Noise 
    BWmin= bwareaopen(BWmin,Noise_background);
    BWmin= bwareaopen(1-BWmin,Noise_background);

    %% MORPHOLOGY. 

    %Dilatation and erosion
    se=strel('disk',DilateErode);
    BWdilate=imdilate(BWmin,se);
    BW=1-imdilate(1-BWdilate,se);

    % Openning to deleting dots and dividing cells
    se = strel('disk',Divide_cells);
    BW = imopen(BW,se);

    % Compacting cells
    se = strel('disk',2);
    BW = imclose(BW,se);

    % Separation between cells
    se = strel('disk',Intercellular_espace);
    BW = imerode(BW,se);

    BW = 1-bwareaopen(1-BW,Delete_artifacts);

    %% SAVING
    splittedPhotoPath=strsplit(photoPath,'\');
    segmententionFolderPath=strsplit(photoPath,'rawImages');
    photoName=splittedPhotoPath{end};
    
        
    if isdir([segmententionFolderPath{1} 'firstSegmentation\' splittedPhotoPath{end-1}])==0
       mkdir([segmententionFolderPath{1} 'firstSegmentation\' splittedPhotoPath{end-1}]); 
    end
       
    imwrite(BW,[segmententionFolderPath{1} 'firstSegmentation\' splittedPhotoPath{end-1} '\' photoName])

end