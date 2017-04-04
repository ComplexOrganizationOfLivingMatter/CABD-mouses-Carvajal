%Pipeline
addpath('src')
addpath('src\lib')
load('D:\Pedro\CABD-mouses-Carvajal\PCA_data\Matrix_cc.mat')

%PCA_2_cc_Original(matrix1, matrix2, 'Class1', 'Class2');
PCA_2_cc_Original(solL1_81, solL2_81, 'Sol L1', 'Sol L2');
PCA_2_cc_Original(solWT_81, solL1_81, 'Sol WT', 'Sol L1');
PCA_2_cc_Original(solWT_81, solL2_81, 'Sol WT', 'Sol L2');
PCA_2_cc_Original(taL1_46, taL2_46, 'Ta L1', 'Ta L2');
PCA_2_cc_Original(taWT_46, taL1_46, 'Ta WT', 'Ta L1');
PCA_2_cc_Original(taWT_46, taL2_46, 'Ta WT', 'Ta L2');

