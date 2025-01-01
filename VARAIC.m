%% Ole Paech AIC/BIC 
clear;
clc;

%% AIC/BIC - quarterly model
data = readmatrix('Bachelor Thesis','Sheet','quarterly Tabelle','Range', 'B10:I197');

c = diff(log(data(:,2)))*100;       % log_dif_consumption
i = diff(log(data(:,3)))*100;       % log_dif_private investment
out = diff(log(data(:,4)))*100;     % log_dif_real GDP
pi = diff(log(data(:,5)))*100;      % log_dif_GDP price deflator
ebp = data(2:end,1);                % Excess Bond Premium
r = data(2:end,6);                  % Market return
y = data(2:end,7);                  % 10y Treasury bonds
ffr = data(2:end,8);                % Fed Funds Rate 

start = datetime(1973,4,1);
end_date = datetime(2019,10,1);
dateline = start:calquarters(1):end_date; % create timeline


Dataframe = array2timetable([c,i,out,pi,ebp,r,y,ffr],'RowTimes',dateline,'VariableNames',{'c','i','out','pi','ebp','r','y','ffr'});


numseries = 8;
seriesnames = {'consumption','investment','output','prices','ebp','market return','bond yields','funds rate'};

VARmodels = cell(1, 5); % create VAR models
for p = 1:5
    VARmodels{p} = varm(numseries, p);
    VARmodels{p}.SeriesNames = seriesnames;
end


Datapre = 1:5;
T = size(Dataframe, 1);
Dataest = 6:T;

LogL = zeros(1, 5); % vector for log Likelihoods
np = zeros(1, 5); % up to five parameters 
for p = 1:5
    [estMdl, estSE, LogL(p), E] = estimate(VARmodels{p}, Dataframe{Dataest, :}, 'Y0', Dataframe{Datapre, :});
    results = summarize(estMdl);
    np(p) = results.NumEstimatedParameters;
end


AIC = aicbic(LogL, np, T); % AIC


[minAIC, optimalLag1] = min(AIC);
disp(['AIC ' num2str(optimalLag1)]);


[~, BIC] = aicbic(LogL, np, T); % BIC


[minBIC, optimalLag2] = min(BIC);
disp(['BIC: ' num2str(optimalLag2)]);


plot(AIC);
 set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'AIC/BIC Criterion for Quarterly Data'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Number of Parameters','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('AIC/BIC Value','FontWeight','Normal','FontName','Times','FontSize',9);
hold on
plot(BIC);
xline(optimalLag1, 'b--');
xline(optimalLag2,'r--');
legend('AIC','BIC',['Minimum AIC: ' num2str(optimalLag1)], ['Minimum BIC: ' num2str(optimalLag2)],'Location','northeast');
xlim([1 5]);
xticks(1:1:5);


%% AIC/BIC monthly data
data = readmatrix('Bachelor Thesis','Sheet','monthly Tabelle','Range', 'B26:I589');

c = diff(log(data(:,2)))*100;       % log_dif_consumption
i = diff(log(data(:,3)))*100;       % log_dif_private investment
out = diff(log(data(:,4)))*100;     % log_dif_real GDP
pi = diff(log(data(:,5)))*100;      % log_dif_GDP price deflator
ebp = data(2:end,1);                % Excess Bond Premium
r = data(2:end,6);                  % Excess market return
y = data(2:end,7);                  % 10y treasury bonds
ffr = data(2:end,8);                % Fed Funds Rate 

start = datetime(1973,2,1);
end_date = datetime(2019,12,1);
dateline = start:calmonths(1):end_date; % create timeline


Dataframe = array2timetable([c,i,out,pi,ebp,r,y,ffr],'RowTimes',dateline,'VariableNames',{'c','i','out','pi','ebp','r','y','ffr'});


numseries = 8;
seriesnames = {'consumption','investment','output','prices','ebp','market_return','bond_yields','funds_rate'};

VARmodels = cell(1, 15); % create VAR models
for p = 1:15
    VARmodels{p} = varm(numseries, p);
    VARmodels{p}.SeriesNames = seriesnames;
end

Datapre = 1:15;
T = size(Dataframe, 1);
Dataest = 16:T;

LogL = zeros(1, 15); % vecotr for log likelihoods
np = zeros(1, 15); % up to 15 parameters
for p = 1:15
    [estMdl, estSE, LogL(p), E] = estimate(VARmodels{p}, Dataframe{Dataest, :}, 'Y0', Dataframe{Datapre, :});
    results = summarize(estMdl);
    np(p) = results.NumEstimatedParameters;
end

AIC = aicbic(LogL, np, T); % AIC

[minAIC, optimalLag1] = min(AIC);
disp(['AIC: ', num2str(optimalLag1)]);

[~, BIC] = aicbic(LogL, np, T); % BIC

[minBIC, optimalLag2] = min(BIC);
disp(['BIC: ', num2str(optimalLag2)]);

plot(AIC);
 set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'AIC/BIC Criterion for Monthly Data'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Number of Parameters','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('AIC/BIC Value','FontWeight','Normal','FontName','Times','FontSize',9);
hold on
plot(BIC);
xline(optimalLag1, 'b--');
xline(optimalLag2,'r--');
legend('AIC','BIC',['Minimum AIC: ' num2str(optimalLag1)], ['Minimum BIC: ' num2str(optimalLag2)],'Location','northeast');
xlim([1 15]);
xticks(1:1:15);
%% AIC/BIC Exchange Rates

data = readmatrix('Bachelor Thesis','Sheet','xRates','Range', 'B338:L589');

c = diff(log(data(:,2)))*100;       % log_dif_consumption
i = diff(log(data(:,3)))*100;       % log_dif_private investment
out = diff(log(data(:,4)))*100;     % log_dif_real GDP
pi = diff(log(data(:,5)))*100;      % log_dif_GDP price deflator
ebp = data(2:end,1);                % Excess Bond Premium
r = data(2:end,6);                  % Excess market return
y = data(2:end,7);                  % 10y Treasury bonds
ffr = data(2:end,8);                % Fed Funds Rate
gbp = diff(log(data(:,9)))*100;     % log_dif_USD/GBP
eur = diff(log(data(:,10)))*100;    % log_dif_USD/EUR

start = datetime(1999,2,1);
end_date = datetime(2019,12,1);
dateline = start:calmonths(1):end_date; % create timeline

Dataframe = array2timetable([c,i,out,pi,ebp,r,y,ffr,gbp,eur], 'RowTimes', dateline, ...
    'VariableNames', {'c','i','out','pi','ebp','r','y','ffr','gbp','eur'});


numseries = 10;
seriesnames = {'consumption','investment','output','prices','ebp','market_return','bond_yields','funds_rate','usd_gbp','usd_eur'};

VARmodels = cell(1, 20);
for p = 1:20    % create VAR models
    VARmodels{p} = varm(numseries, p);
    VARmodels{p}.SeriesNames = seriesnames;
end


Datapre = 1:20;
T = size(Dataframe, 1);
Dataest = 21:T;

LogL = zeros(1, 20); % vector for log likelihoods
np = zeros(1, 20); % up to 20 parameters
for p = 1:20
    [estMdl, estSE, LogL(p), E] = estimate(VARmodels{p}, Dataframe{Dataest, :}, 'Y0', Dataframe{Datapre, :});
    results = summarize(estMdl);
    np(p) = results.NumEstimatedParameters;
end

[~, BIC] = aicbic(LogL, np, T); % BIC

[minBIC, optimalLag1] = min(BIC);
disp(['BIC: ', num2str(optimalLag1)]);

[AIC,~] = aicbic(LogL, np, T); % AIC
[minAIC, optimalLag2] = min(AIC);
disp(['AIC: ', num2str(optimalLag2)]);

plot(AIC);
 set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'AIC/BIC Criterion for Exchange Rates'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Number of Parameters','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('AIC/BIC Value','FontWeight','Normal','FontName','Times','FontSize',9);
hold on
plot(BIC);
xline(optimalLag2, 'b--');
xline(optimalLag1,'r--');
legend('AIC','BIC',['Minimum AIC: ' num2str(optimalLag2)], ['Minimum BIC: ' num2str(optimalLag1)],'Location','northeast');
xlim([1 20]);
xticks(1:1:20);
%% AIC/BIC S&P 500

data = readmatrix('Bachelor Thesis','Sheet','SP Tabelle','Range', 'B26:L589');

c = diff(log(data(:,2)))*100;       % log_dif_consumption
i = diff(log(data(:,3)))*100;       % log_dif_private investment
out = diff(log(data(:,4)))*100;     % log_dif_real GDP
pi = diff(log(data(:,5)))*100;      % log_dif_GDP price deflator
ebp = data(2:end,1);                % Excess Bond Premium
r = data(2:end,6);                  % Excess Market return
y = data(2:end,7);                  % 10y Treasury bonds
ffr = data(2:end,8);                % Fed Funds Rate
my = diff(log(data(:,9))*100);      % log_dif_average high
high = diff(log(data(:,10))*100);   % log_dif_monthly high
low = diff(log(data(:,11))*100);    % log_dif_monthly low

start = datetime(1973,2,1);
end_date = datetime(2019,12,1);
dateline = start:calmonths(1):end_date; % create timeline

Dataframe = array2timetable([c,i,out,pi,ebp,r,y,ffr,my,high,low], 'RowTimes', dateline, ...
    'VariableNames', {'c','i','out','pi','ebp','r','y','ffr','my','high','low'});

numseries = 11;
seriesnames = {'consumption','investment','output','prices','ebp','market_return','bond_yields','funds_rate','mittelwert','high','low'};

VARmodels = cell(1, 15); % create VAR model
for p = 1:15
    VARmodels{p} = varm(numseries, p);
    VARmodels{p}.SeriesNames = seriesnames;
end


Datapre = 1:15;
T = size(Dataframe, 1);
Dataest = 16:T;

LogL = zeros(1, 15); % vector for log likelihoods
np = zeros(1, 15); % up to 15 parameters
for p = 1:15
    [estMdl, estSE, LogL(p), E] = estimate(VARmodels{p}, Dataframe{Dataest, :}, 'Y0', Dataframe{Datapre, :});
    results = summarize(estMdl);
    np(p) = results.NumEstimatedParameters;
end


[~, BIC] = aicbic(LogL, np, T); % BIC

[minBIC, optimalLag1] = min(BIC);
disp(['BIC: ', num2str(optimalLag1)]);

[AIC,~] = aicbic(LogL, np, T); % AIC
[minAIC, optimalLag2] = min(AIC);
disp(['AIC: ', num2str(optimalLag2)]);

plot(AIC);
 set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'AIC/BIC Criterion for Stock Prices'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Number of Parameters','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('AIC/BIC Value','FontWeight','Normal','FontName','Times','FontSize',9);
hold on
plot(BIC);
xline(optimalLag2, 'b--');
xline(optimalLag1,'r--');
legend('AIC','BIC',['Minimum AIC: ' num2str(optimalLag2)], ['Minimum BIC: ' num2str(optimalLag1)],'Location','northeast');
xlim([1 15]);
xticks(1:1:15);