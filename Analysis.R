source('functions.R')
library(ggplot2)
#load data
data <- read.table('TimePilot3.dat', head = T)
data$Subject<-as.factor(data$Subject)
data$Range<-as.factor(data$Range)


#plot averages per Range 
summary<-summary_se_within(data,"Error",idvar="Subject",betweenvars=c("Range"))
print(summary)
summary$Range<-as.factor(summary$Range)
plot<-ggplot(summary, aes(x=Range, y=abs(Error))) + 
  geom_point(size=3, shape=21, fill="white")+
  geom_errorbar(aes(ymin=abs(Error)-SE, ymax=abs(Error)+SE),
                width=.2, 
                position=position_dodge(.9))+
  expand_limits(y=0)+
  theme_classic()
plot


#plot individual scatterplots per Range
plot=ggplot(data, aes(x=RealTime, y=abs(Error), colour=Range)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE)  +
  theme_classic() +
  facet_grid(~Subject~Range)
plot

#plot individual linear trend on pooled data 
plot=ggplot(data, aes(x=RealTime, y=abs(Error), colour=Subject)) + 
  geom_point(alpha=0.2) + 
  geom_smooth(method = "lm", se = F)  +
  theme_classic()
plot


##lmer - Fixed factors Range and Time, slopes and intercepts vary per participant
library(lme4)
library(lmerTest)
data$Error<-abs(data$Error)
mod<-lmer(abs(Error) ~ Range * RealTime + (Range|Subject),data=data, REML = FALSE) 
summary(mod)

