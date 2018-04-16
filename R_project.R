getwd()

#set our directory to where the dataset is stored
setwd("C:/Users/hegde/Desktop/business Analytics")

#loading the required library
library(mlogit)

#creating our data frame
data<-read.csv("C:/Users/hegde/Desktop/business Analytics/Hegde_Mangal_R dataset.csv")
data$GENDER<-as.factor(data$GENDER)
data$MARRIED<-as.factor(data$MARRIED)
data$Donate<-as.factor(data$Donate)


#creating the model where we are predicting probability of doation based on
#age, gender, marriage status and the no of events attended so far

model1 <- glm(Donate ~  AGE + GENDER + MARRIED + data$No.of.Events.Attended,
              data = data,
              family = binomial())

summary(model1)

#we see small value of deviance statistics, this indicates that the model is a good fit
#null deviance is 2772.6
#residual deviance is 2474.6
#there is a large diff between the two which indicates that the model is good at predicting whether someone will donated of not based on our attributes


#Model Chi-square statistic
model1_chi <- model1$null.deviance - model1$deviance

model1_chi

model1_chi_df <- model1$df.null - model1$df.residual 

model1_chi_df

model1_chisq.prob <- 1 - pchisq(model1_chi, model1_chi_df)

model1_chisq.prob

#we get a value of 0 (that is less than 0.005) 
#therefore we can reject the null hypothesis that the model is not better than the chance at predicting the outcome