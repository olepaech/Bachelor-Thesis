%% Ole Paech - effects on monthly benchmark variables
clear;
clc;
%% Monthly Excess Bond Premium - Prolonged till 12 2019
data = readmatrix('Bachelor Thesis','Sheet','monthly Tabelle','Range', 'B26:I589');
c= log(data(:,2))*100;       % log_Consumption
i= log(data(:,3))*100;       % log_private investment
out= log(data(:,4))*100;     % log_real gdp
pi= log(data(:,5))*100;      % log_gdp price deflator
ebp= data(:,1);     % Excess Bond Premium
r=data(:,6);       % Excess Market return
y=data(:,7);       % 10y Treasury bonds
ffr=data(:,8);     % Fed Funds Rate


H=37; % IRF horizon
llag=3;
X=[c,i,out,pi,ebp,r,y,ffr]; % data
Xlag=[X(1:end-llag-H,:), X(2:end-2-H,:) X(3:end-1-H,:)]; % lag data
l_trend= (1:size(Xlag,1))'; % linear trend
q_trend= l_trend.^2 ; % quadric trend
shock= data(llag+1:end-H,1);   % EBP Shock

IRFs=nan(H,size(X,2),3);  % empty vector for impulse responses 
 
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
    
subplot(2,4,1)               
    shadedplot(x_axis',IRFs(:,1,3)',IRFs(:,1,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,1,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'real Consumption Expenditures'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,4,2)               
    shadedplot(x_axis',IRFs(:,2,3)',IRFs(:,2,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,2,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'Private Fixed Investment'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,4,3) 
    shadedplot(x_axis',IRFs(:,3,3)',IRFs(:,3,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,3,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'real GDP'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,4,4)               
    shadedplot(x_axis',IRFs(:,4,3)',IRFs(:,4,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,4,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'GDP Price Deflator'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

 subplot(2,4,5)               
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
    
subplot(2,4,6)               
    shadedplot(x_axis',IRFs(:,6,3)',IRFs(:,6,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,6,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'Excess Market Return'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

subplot(2,4,7)               
    shadedplot(x_axis',IRFs(:,7,3)',IRFs(:,7,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,7,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'10y Treasury Bond yields'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;

 subplot(2,4,8)               
    shadedplot(x_axis',IRFs(:,8,3)',IRFs(:,8,1)','color',[45 134 89]./255 );
    hold on;
    plot(x_axis,IRFs(:,8,2),'-', 'color', [0 0 180/255],'Linewidth',2);
    hold on; 
    plot(x_axis,x_axis*0,'-k','Linewidth',1);    
    set(gca, 'FontWeight','Normal','FontName','Times','FontSize',8,'XTick',0:6:H-1);
    title({'nominal Federal Funds Rate'},'FontWeight','Normal','FontName','Times','FontSize',12);
    xlim([0 H-1]);
    xlabel('Months','FontWeight','Normal','FontName','Times','FontSize',9);
    ylabel('Percent','FontWeight','Normal','FontName','Times','FontSize',9);
    grid on;