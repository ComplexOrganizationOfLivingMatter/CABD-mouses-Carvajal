%This script is the main program which manages the total extraction of
%charasteristics from all segmented images



clear all
close all

addpath Ccs_extraction
addpath 'Ccs_extraction\aux_calculate_ccs'
addpath 'Ccs_extraction\Codigo_BCT'
addpath 'export_fig_master'
addpath 'Ccs_extraction\aux_calculate_ccs'
addpath 'Segmentation'

load('D:\Pedro\CABD-mouses-Carvajal\processedImages\pathProcessedImages.mat')

% listNamesProcessedImages
% listPathProcessedImages

parfor i=1:size(listNamesProcessedImages,1)
    
    if ~isempty(strfind(lower(listPathProcessedImages{i}),'sol'))
       valid_cells=Extraction_69ccs(listPathProcessedImages{i},listNamesProcessedImages{i});
    else
       valid_cells=Extraction_34ccs(listPathProcessedImages{i},listNamesProcessedImages{i});
    end
    
    Extraction_12ccs_dapi(listPathProcessedImages{i},listNamesProcessedImages{i},valid_cells); 
end