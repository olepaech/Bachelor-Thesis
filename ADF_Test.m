%% Ole Paech ADF test
clear;
clc;
%% ADF test for Excess Bond Premium

ebp = readmatrix('Bachelor Thesis','Sheet','monthly Tabelle','Range', 'B26:B589'); % Excess Bond Premium

[h, pValue, stat, cValue, reg] = adftest(ebp);


fprintf('ADF Test Results:\n');
fprintf('Hypothesis Rejection (h): %d\n', h);
fprintf('p-Value: %f\n', pValue);
fprintf('Test Statistic: %f\n', stat);
fprintf('Critical Value: %f\n', cValue);



if h == 1
    fprintf('The time series is stationary.\n');
else
    fprintf('The time series is not stationary.\n');
end
