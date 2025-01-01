%% Ole Paech Interpolation
clear;
clc;

%% Interpolation private investment
data = readmatrix('Bachelor Thesis','Sheet','quarterly Tabelle','Range', 'D2:D197'); % private investment
quartale = 1:3:588; % quarters
Monate = 1:588; % months
interpol = interp1(quartale,data,Monate,'pchip'); % piecewise cubic Hermite interpolating polynomial 
T=table(interpol);
Start_Date = datetime(1971,1,1);
End_Date = datetime(2019,12,1);
Datum1 = Start_Date:calquarters(1):End_Date; % x achs for original data
Datum2 = Start_Date:calmonths(1):End_Date; % x achs for interpolated data
subplot(3,1,1)
plot(Datum1,log(data),'g-',Datum2,log(interpol),'k--');
set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'Private Fixed Investment: original vs. interpolated data'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Log Private Fixed Investment','FontWeight','Normal','FontName','Times','FontSize',9);
    legend('original Investment','interpolated Investment','Location','southeast');
    hold on;
%% Interpolation GDP
daten = readmatrix('Bachelor Thesis','Sheet','quarterly Tabelle','Range', 'E2:E197'); % real GDP
quartale = 1:3:588; % quarters
Monate = 1:588; % months
interpol2 = interp1(quartale,daten,Monate,'pchip'); % piecewise cubic Hermite interpolating polynomial
subplot(3,1,2)
plot(Datum1,log(daten),'g-',Datum2,log(interpol2),'k--');
set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'real GDP: original vs. interpolated data'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Log real GDP','FontWeight','Normal','FontName','Times','FontSize',9);
    legend('original GDP','interpolated GDP','Location','southeast');
    hold on;

%% Interpolation: GDP price deflator
Daten = readmatrix('Bachelor Thesis','Sheet','quarterly Tabelle','Range', 'F2:F197'); % GDP price deflator
quartale = 1:3:588; % quarters
Monate = 1:588; % months
interpol3 = interp1(quartale,Daten,Monate,'pchip'); % piecewise cubic Hermite interpolating polynomial
subplot(3,1,3)
plot(Datum1,log(Daten),'g-',Datum2,log(interpol3),'k--');
set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8);
    title({'GDP Price Deflator: original vs. interpolated data'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlabel('Year','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Log GDP Price Deflator','FontWeight','Normal','FontName','Times','FontSize',9);
    legend('original Price Deflator','interpolated Price Deflator','Location','southeast');
   


