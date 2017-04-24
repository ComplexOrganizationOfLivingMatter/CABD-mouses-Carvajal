%Pipeline
addpath('src')
addpath('src\lib')
load('D:\Pedro\CABD-mouses-Carvajal\PCA_data\Matrix_cc.mat')
indTa=[1,2,7,8,9,10,11,12,13,14,15,16,23,24,25,26,27,28,29,30,31,32,33,34,35,36,41,42,47,48,53,54,59,60,70,71,72,73,74,75,76,77,78,79,80,81];
indSol=1:81;
indTaGeo=[1,2,7,8,9,10,11,12,13,14];
indSolGeo=[1:14,69];


% %PCA_2_cc_Original(matrix1, matrix2, 'Class1', 'Class2');
% PCA_2_cc_Original(solL1_81, solL2_81, 'Sol L1', 'Sol L2');
% PCA_2_cc_Original(solWT_81, solL1_81, 'Sol WT', 'Sol L1');
% PCA_2_cc_Original(solWT_81, solL2_81, 'Sol WT', 'Sol L2');
% PCA_2_cc_Original(taL1_46, taL2_46, 'Ta L1', 'Ta L2');
% PCA_2_cc_Original(taWT_46, taL1_46, 'Ta WT', 'Ta L1');
% PCA_2_cc_Original(taWT_46, taL2_46, 'Ta WT', 'Ta L2');

% PCA_2_cc_geometric(solL1_81, solL2_81, 'Sol L1', 'Sol L2');
% PCA_2_cc_geometric(solWT_81, solL1_81, 'Sol WT', 'Sol L1');
% PCA_2_cc_geometric(solWT_81, solL2_81, 'Sol WT', 'Sol L2');
% PCA_2_cc_geometric(taL1_46, taL2_46, 'Ta L1', 'Ta L2');
% PCA_2_cc_geometric(taWT_46, taL1_46, 'Ta WT', 'Ta L1');
% PCA_2_cc_geometric(taWT_46, taL2_46, 'Ta WT', 'Ta L2');

% PCA_2_selectedFeatures(solWT_81, solL1_81, 'Sol WT', 'Sol L1',[28,76,80,55,37,2,5],indSol);
% PCA_2_selectedFeatures(solWT_81, solL2_81, 'Sol WT', 'Sol L2',[5,39,42,2,43,7,72],indSol);
% PCA_2_selectedFeatures(taWT_46, taL1_46, 'Ta WT', 'Ta L1',[find(indTa==2),find(indTa==27),find(indTa==79),find(indTa==78),find(indTa==77),find(indTa==11),find(indTa==70)],indTa);
% PCA_2_selectedFeatures(taWT_46, taL2_46, 'Ta WT', 'Ta L2',[find(indTa==7),find(indTa==11),find(indTa==35),find(indTa==13),find(indTa==30),find(indTa==1),find(indTa==27)],indTa);

PCA_2_selectedFeatures(solWT_81, solL1_81, 'Sol WT', 'Sol L1',[3,5,8,14],indSolGeo);
PCA_2_selectedFeatures(solWT_81, solL2_81, 'Sol WT', 'Sol L2',[3,5,8],indSolGeo);
PCA_2_selectedFeatures(taWT_46, taL1_46, 'Ta WT', 'Ta L1',[find(indTaGeo==1),find(indTaGeo==2),find(indTaGeo==7),find(indTaGeo==13)],indTaGeo);
PCA_2_selectedFeatures(taWT_46, taL2_46, 'Ta WT', 'Ta L2',[find(indTaGeo==1),find(indTaGeo==2),find(indTaGeo==7),find(indTaGeo==9),find(indTaGeo==12),find(indTaGeo==10)],indTaGeo);
