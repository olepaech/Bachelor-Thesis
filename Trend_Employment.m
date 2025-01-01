%% Ole Paech Trends
clear;
clc;

%% Trend components for selected variables 

Data = readmatrix("trend_metrics.xlsx",'Sheet','Trend variables','Range','B2:G197');
Empr = 100*Data(:,1); % Labor participation rate
GDP = log(Data(:,2)); % log_real GDP
Pop = log(Data(:,3)); % log_Population (in thousand)
EmpPop = (Data(:,4))*100; % Employment-Population rate
men = Data(:,5)*100; % Men: Employment-Population rate
women = Data(:,6)*100; % Women: Employment-Population rate

TabTre = table(Empr,GDP,Pop,EmpPop,men,women,'VariableNames', {'Employment','GDP','Population','Employment-Population','Men Employment-Population','Women Employment-Population'});
[Trends,Cyclical] = hpfilter(TabTre,1600); % Trend component_ lambda=1600


Start_Date = datetime(1971,1,1);
End_Date = datetime(2019,12,1);
Datum = Start_Date:calquarters(1):End_Date; % timeline

g = exp(Trends{:,"GDP"});
rg = diff(g) ./ g(1:end-1) * 100; % growth_rate for GDP trend

St = datetime(1971,4,1);
En = datetime(2019,12,1);
Da = St:calquarters(1):En; % timeline for growth GDP trend

subplot(3,2,1)
plot(Datum, Trends{:, 'Employment'},'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Labor Participation Rate'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    xline(Datum(1,97), 'r--');
subplot(3,2,2)
plot(Da,rg,'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Growth GDP-Trend'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    xline(Datum(1,97), 'r--');
    ylim([0 1.2]);
    yticks([0:0.3:1.2]);
subplot(3,2,3)
plot(Datum',Trends{:,"Population"},'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Population'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Log-Value','FontWeight','Normal','FontName','Times','FontSize',9);
    xline(Datum(1,97), 'r--');
subplot(3,2,4)
plot(Datum,Trends{:,"Employment-Population"},'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Employment-Population ratio'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    xline(Datum(1,97), 'r--');
subplot(3,2,5)
plot(Datum,Trends{:,"Men Employment-Population"},'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Men: Employment-Population ratio'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    ylim([37 78]);
    xline(Datum(1,97), 'r--');
subplot(3,2,6)
plot(Datum,Trends{:,"Women Employment-Population"},'LineStyle','-','Color', 'b');
hold on;   
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Women: Employment-Population ratio'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    ylim([37 78]);
    xline(Datum(1,97), 'r--');
