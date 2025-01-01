%% Ole Paech - stock market responses
clear;
clc;

%% Monthly Excess Bond Premium - S&P500 Effects
data = readmatrix('Bachelor Thesis','Sheet','SP Tabelle','Range', 'B26:L589');
c= log(data(:,2))*100;       % log_consumption
i= log(data(:,3))*100;       % log_private investment
out= log(data(:,4))*100;     % log_real gdp
pi= log(data(:,5))*100;      % log_gdp price deflator
ebp= data(:,1);     % Excess Bond Premium
r=data(:,6);       % Excess Market return
y=data(:,7);       % 10y Treasury bonds
ffr=data(:,8);     % Fed Funds Rate 
my = log(data(:,9))*100 % log_monthly average high
high = log(data(:,10))*100 % log_monthly high
low = log(data(:,11))*100  % log_monthly low



H=37; % IRF horizon
llag=3;
X=[c,i,out,pi,ebp,r,y,ffr,my,high,low]; % data
Xlag=[X(1:end-llag-H,:), X(2:end-2-H,:) X(3:end-1-H,:)] % lag data
l_trend= (1:size(Xlag,1))'; % linear trend
q_trend= l_trend.^2 ; % quadric trend
shock= data(llag+1:end-H,1);   % EBP shock

IRFs=nan(H,size(X,2),3); % empty vector for impulse responses 
 
for kk=1:size(X,2)   
    for ii=1:H
        [~,se,beta]=hac([shock, Xlag, l_trend, q_trend ],X(llag+ii:end-H-1+ii,kk),'type','HC','display','off');       
        IRFs(ii,kk,:)=[beta(2,1)-2*se(2,1),beta(2,1),beta(2,1)+2*se(2,1)];           
    end
end



max_i=(IRFs(1,5,2));   
IRFs=IRFs./max_i;         % normalized EBP-shock (100 basis points) 
x_axis=0:1:H-1;           

figure(1)
set(0,'DefaultAxesColorOrder',[0 0 0],...
'DefaultAxesLineStyleOrder','--|-|--')    
    
subplot(2,2,1)               
    shadedplot(x_axis',IRFs(:,5,3)',IRFs(:,5,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,5,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'Excess Bond Premium'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,2,2)               
    shadedplot(x_axis',IRFs(:,9,3)',IRFs(:,9,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,9,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'S&P 500 monthly average high'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    ylim([-20 5]);
    yticks(-20:5:5);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;


subplot(2,2,3) 
    shadedplot(x_axis',IRFs(:,10,3)',IRFs(:,10,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,10,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'S&P 500 monthly high'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    ylim([-20 5]);
    yticks(-20:5:5);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,2,4)               
    shadedplot(x_axis',IRFs(:,11,3)',IRFs(:,11,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,11,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'S&P 500 monthly low'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    ylim([-20 5]);
    yticks(-20:5:5);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;