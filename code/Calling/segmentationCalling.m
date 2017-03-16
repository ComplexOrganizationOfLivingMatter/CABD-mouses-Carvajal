%Calling segmentation
addpath('..')
addpath('..\lib')
allPaths=getAllFiles('D:\Pedro\CABD mouses Carvajal\rawImages\');

parfor i=1:length(allPaths)
    
    path=allPaths{i};
    if isempty(strfind(lower(path),'40xg.jpg'))==0
        Segmentation(path)
    end
end