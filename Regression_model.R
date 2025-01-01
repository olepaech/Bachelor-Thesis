title: "Regression"
author: "Ole Paech"
date: "2023-06-25"

library(readxl)
# setwd("C:/Users/olepa/OneDrive/Desktop/Bachelorarbeit/local_projections")
Data <- read_excel("Bachelor Thesis.xlsx", sheet="quarterly Tabelle") 
attach(Data)
EBP = EBP[10:196];
consume = (log(`real cons`[10:196])*100)-(log(`real cons`[9:195])*100);
output = (log(`real GDP`[10:196])*100)-(log(`real GDP`[9:195])*100);
investment = (log(`Fixed Investment (2017 chained)`[10:196])*100)-(log(`Fixed Investment (2017 chained)`[9:195])*100);
govexp = (log(`Gov. Exp. Bn`[10:196])*100) - (log(`Gov. Exp. Bn`[9:195])*100);
llag = 2;
investment[3:187]


outputll = output[1:(187-llag)];
outputl = output[2:(187-(llag-1))];
d = matrix(c(consume[3:187], EBP[3:187], outputl, outputll),ncol = 4);
Consumption = consume[3:187]
EBPs= EBP[3:187]
OutputL = outputl
OutputLL = outputll
Government = govexp[3:187]
Investment = investment[3:187]
colnames(d) = c("Consumption", "EBP", "Investment", "Output t-1", "Output t-2");
Output = output[3:187];
regression = lm(Output ~ Consumption + EBPs + Government + OutputL + OutputLL);
regression2 = lm(Output ~ Consumption + EBPs + Investment + Government + OutputL + OutputLL);
summary(regression);
summary(regression2);
