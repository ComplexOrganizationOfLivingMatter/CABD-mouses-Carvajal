%Pipeline
addpath('src')
addpath('src\lib')
load('D:\Pedro\Mouse muscle SOD1\PCA_data\Matrix_cc.mat')

%PCA_2_cc_Original(matrix1, matrix2, 'Class1', 'Class2');
PCA_2_cc_Original(matrixCONT60, matrixCONT80(:, 1:69), 'Control 60', 'Control 80');
PCA_2_cc_Original(matrixCONT60, matrixCONT100(:, 1:69), 'Control 60', 'Control 100');
PCA_2_cc_Original(matrixCONT60, matrixCONT120(:, 1:69), 'Control 60', 'Control 120');
PCA_2_cc_Original(matrixCONT80, matrixCONT100, 'Control 80', 'Control 100');
PCA_2_cc_Original(matrixCONT80, matrixCONT120, 'Control 80', 'Control 120');
PCA_2_cc_Original(matrixCONT100, matrixCONT120, 'Control 100', 'Control 120');
PCA_2_cc_Original(matrixG93A60, matrixG93A80(:, 1:69), 'G93A 60', 'G93A 80');
PCA_2_cc_Original(matrixG93A60, matrixG93A100(:, 1:69), 'G93A 60', 'G93A 100');
PCA_2_cc_Original_Aux(matrixG93A60, matrixG93A120(:, 1:69), matrixG93A130(:, 1:69), 'G93A 60', 'G93A 120');
PCA_2_cc_Original(matrixG93A80, matrixG93A100, 'G93A 80', 'G93A 100');
PCA_2_cc_Original_Aux(matrixG93A80, matrixG93A120, matrixG93A130, 'G93A 80', 'G93A 120');
PCA_2_cc_Original_Aux(matrixG93A100, matrixG93A120, matrixG93A130, 'G93A 100', 'G93A 120');
PCA_2_cc_Original(matrixWT80, matrixWT100, 'WT 80', 'WT 100');
PCA_2_cc_Original(matrixWT80, matrixWT120, 'WT 80', 'WT 120');
PCA_2_cc_Original(matrixWT100, matrixWT120, 'WT 100', 'WT 120');

PCA_2_cc_Original(matrixCONT60, matrixG93A60, 'Control 60', 'G93A 60');
PCA_2_cc_Original(matrixCONT80, matrixG93A80, 'Control 80', 'G93A 80');
PCA_2_cc_Original(matrixWT80, matrixCONT80, 'WT 80', 'Control 80');
PCA_2_cc_Original(matrixWT80, matrixG93A80, 'WT 80', 'G93A 80');
PCA_2_cc_Original(matrixCONT100, matrixG93A100, 'Control 100', 'G93A 100');
PCA_2_cc_Original(matrixWT100, matrixCONT100, 'WT 100', 'Control 100');
PCA_2_cc_Original(matrixWT100, matrixG93A100, 'WT 100', 'G93A 100');
PCA_2_cc_Original_Aux(matrixCONT120, matrixG93A120, matrixG93A130, 'Control 120', 'G93A 120');
PCA_2_cc_Original(matrixWT120, matrixCONT120, 'WT 120', 'Control 120');
 PCA_2_cc_Original_Aux(matrixWT120, matrixG93A120, matrixG93A130, 'WT 120', 'G93A 120');




