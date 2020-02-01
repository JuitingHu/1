rm(list=ls())

### Packages
install.packages("margins")  # to calculate marginal effects
library(foreign)
library(stargazer)
library(haven)
library(ggplot2)
library(Hmisc)
library(chron)
library(lattice)
library(dummies)
library(lfe)
library(sandwich)
library(lmtest)
library(miceadds)
library(multiwayvcov)
library(margins)

### load data
data1 <- read_dta("~/Desktop/WFH data/Attrition.dta")
View(data1)

### explore data
names(data1) 
data2<-data.frame(data1)
stargazer(data2,type="text",title =,align=TRUE) #Basically,around 25% quit the job.
#stargazer(data2,type="html",align=TRUE, out="table1.htm") #Save pic.

### explore the data graphically
plot(data2$quitjob,xlab ="Person ID", ylab = "Attrition", main= "Table 2 : Attrition by Person ID",col="red")
#Dependent variable(quitjob) takes only two values 0 or 1.

hist(data2$age,xlab ="Age", ylab = "Number of employee", ylim=c(0,45),main= "Table 3 : Age distribution in company ",col="light blue",breaks=24)
#hist(data2$children,xlab ="children", ylab = "Number of employee", main= "Table 4:Having children distribution in company",col="light blue",breaks =10 )
barplot(table(data2$married),col="light blue",ylim=c(0,249),xlab ="children", ylab = "Number of employee", main= " Table 4 : Having children distribution in company")
# barplot這個比較適合binary variable

data2<-within(data2,{D_quit<-ifelse(quitjob==1, "quit", "stay")}) #create dummy 
histogram(~ age | D_quit, data=data2, nint =25,main="Table 5 : The pecent of quit and stay by age") #young people more quit. 
histogram(~ children | D_quit, data=data2, nint =25,main="Table 6 : The pecent of quit and stay by children")

### run OLS
ols1<-lm(quitjob ~age+married+men  , data=data2) #negative effect
ols2<-lm(quitjob ~children+married+men  , data=data2) #positive effect
ols3<-lm(quitjob ~age+children+married+men  , data=data2)
stargazer(ols1,ols2,ols3,type="text", align=TRUE,title = "Table 7 : Attrition in OLS model")
#stargazer(ols1,ols2,ols3,type="html",align=TRUE,out="OLS.htm",title = "Table 7 : Attrition in OLS model")
#control wheather sb is a man or marriage.

plot(data2$age,data2$quitjob,xlab ="Age", ylab = "Attrition",col="red",main = "Table 8 : Attrition by Age in OLS model")
abline(ols1,col="blue")
#using the OLS on binary variable, the probability might greater than 1 or less than 0. 

### run logit 
logit1<-glm(quitjob ~ age+married+men, data=data2,family=binomial(link="logit"))
logit2<-glm(quitjob ~ children+married+men, data=data2,family=binomial(link="logit"))
logit3<-glm(quitjob ~ age+children+married+men, data=data2,family=binomial(link="logit"))
stargazer(logit1,logit2,logit3,  type="text", align=TRUE)

### marginal effects
logit1_m<-margins(logit1)
logit2_m<-margins(logit2)
logit3_m<-margins(logit3)
summary(logit1_m)
summary(logit2_m)
summary(logit3_m)
