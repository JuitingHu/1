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
data1 <- read_dta("~/Desktop/Working from home-20190417/Attrition.dta")
View(data1)

### explore data
names(data1) 
data2<-data.frame(data1)
stargazer(data2,type="html",align=TRUE, out="table1.htm")  #Basically,around 25% quit the job.    

### explore the data graphically
plot(data2$quitjob,xlab ="Person ID", ylab = "Attrition", main= "Attrition by Person ID")
#Dependent variable(quitjob) takes only two values 0 or 1.

hist(data2$age,xlab ="Age", ylab = "Number of employee", main= "Age distribution in company ")
hist(data2$married,xlab ="Married", ylab = "Number of employee", main= "Married distribution in company")
histogram(~ married| D_quit, data=data2, nint =25)
barplot(prop.table(table(data2$married)))

data2<-within(data2,{D_quit<-ifelse(quitjob==1, "quit", "stayed")}) #create dummy 
histogram(~ age | D_quit, data=data2, nint =25) #young people more quit. 


### run OLS
ols1<-lm(quitjob ~age+children+men  , data=data2) #negative effect
ols2<-lm(quitjob ~married+children+men  , data=data2) #negative effect
ols3<-lm(quitjob ~age+married+children+men  , data=data2)
stargazer(ols1,ols2,ols3,type="text", align=TRUE)
#control wheather sb is a man or have children.
 
### do prediction - to predict Dependent variable
data2<-within(data2,{quitjobbyage_p<-predict(lm(quitjob ~ age, data=data2))})
stargazer(data2,type="text")

scat1<-ggplot(data2,aes(age)) + geom_line(aes(y=quitjobbyage_p, x=age),colour="blue") + 
  geom_point(aes(y=quitjob, x=age),colour="red")
scat1  

data2<-within(data2,{quitjobbymarried_p<-predict(lm(quitjob ~ married, data=data2))})
stargazer(data2,type="text")

scat2<-ggplot(data2,aes(married)) + geom_line(aes(y=quitjobbymarried_p, x=married),colour="blue") + 
  geom_point(aes(y=quitjob, x=married),colour="red")
scat2  
 

### run logit 
logit1<-glm(quitjob ~ age+children+men, data=data2,family=binomial(link="logit"))
logit2<-glm(quitjob ~ married+children+men, data=data2,family=binomial(link="logit"))
logit3<-glm(quitjob ~ age+married+children+men, data=data2,family=binomial(link="logit"))

stargazer(logit1,logit2,logit3,  type="text", align=TRUE)


### marginal effects

logit1_m<-margins(logit1)

summary(logit1_m)
summary(ols1)

stargazer(ols1,logit1_m,  type="text", align=TRUE)
 



