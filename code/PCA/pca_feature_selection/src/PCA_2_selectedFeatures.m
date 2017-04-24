%%PCA_2_cc
function PCA_2_selectedFeatures(m_t1,m_t2,n_t1,n_t2,selectedFeatures,indexes)

   
    %Asignation to groups by matrixes
    % Group 1
    matrixT1=m_t1(:,selectedFeatures);
    nImgType1=size(matrixT1,1);

    % Group 2
    matrixT2=m_t2(:,selectedFeatures);
    nImgType2=size(matrixT2,1);

    %All ccs matrix
    matrixAllCCs=[matrixT1;matrixT2];

    %Number of images and ccs
    n_images=nImgType1+nImgType2;
    n_totalCcs=length(selectedFeatures);

    %Unitary matrix by type. A column by class
    unitaryMatrixByType=zeros([n_images,2]);
    unitaryMatrixByType(1:nImgType1,1)=1;
    unitaryMatrixByType(nImgType1+1:n_images,2)=1;

    %% Calculate all trios of characteristics
    nIteration=1;
    W={};eigenvectors={};Ratio_pca=[];
     %Normalizing each cc
     for cc=1:n_totalCcs
        matrixAllCCs(:,cc)=matrixAllCCs(:,cc)-min(matrixAllCCs(:,cc));
        matrixAllCCs(:,cc)=matrixAllCCs(:,cc)/max(matrixAllCCs(:,cc));  
     end

     %3 cc for all images
     matrixAllCCs(isnan(matrixAllCCs))=0;% Do 0 all NaN

    %Calculate proyections, eigenvectors and ratios of PCA
    [W,eigenvectors,Ratio_pca]=calculatePCAValues(matrixAllCCs,nIteration,nImgType1,nImgType2,W,eigenvectors,Ratio_pca,selectedFeatures);


    Proy = W{1};
    eigenvectors=eigenvectors{1};
    bestPCA = Ratio_pca(1);
    indexesSelected=indexes(selectedFeatures);

    save( ['D:\Pedro\CABD-mouses-Carvajal\PCA_data\PCA_data_by_groups\PCA_' n_t1 '_' n_t2 '_complementary'], 'Proy', 'bestPCA','indexesSelected', 'eigenvectors')

    
    switch lower(n_t1(end-1:end))
        
        case 'wt'
            color1=[0,1,0];
        case 'l1'
            color1=[0,0,1];
        case 'l2'
            color1=[1,0,0];
    end
    
    switch lower(n_t2(end-1:end))
        
        case 'wt'
            color2=[0,1,0];
        case 'l1'
            color2=[0,0,1];
        case 'l2'
            color2=[1,0,0];
    end
    
    if strcmp(n_t1(end-1:end),n_t2(end-1:end))==1
        color2=color1/2;
    end
    
    %%Represent Luisma format
    Proyecc=Proy;
    h=figure; plot(Proyecc(1,1:nImgType1),Proyecc(2,1:nImgType1),'.','Color',color1,'MarkerSize',30)
    hold on, plot(Proyecc(1,nImgType1+1:nImgType1+nImgType2),Proyecc(2,nImgType1+1:nImgType1+nImgType2),'.','Color',color2,'MarkerSize',30)

    %stringres=strcat(num2str(indexesCcsSelected));
    stringres=strcat('PCA analysis selected features:',num2str(indexesSelected),' Descriptor: ',num2str(bestPCA));
    title(stringres)
    legend(n_t1,n_t2, 'Location', 'bestoutside')
    saveas(h,['D:\Pedro\CABD-mouses-Carvajal\PCA_data\PCA_data_by_groups\PCA_' n_t1 '_' n_t2 '_complementary.jpg'])

    close all
end
