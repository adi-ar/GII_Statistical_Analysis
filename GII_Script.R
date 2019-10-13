library(reshape)
library(car)

data = readxl::read_excel("Stats\\GII_Cleaned.xlsx", na = "..")
names(data)[1]= "Country"
corcountries = data$Country
edu_ratio = read.csv("Stats\\SYB61_T06_Ratio of Girls to Boys in Education.csv", skip = 1)
selectCountries = which(edu_ratio[,2] %in% c(corcountries))
edu_ratio = edu_ratio[c(selectCountries),c(2:5)]
names(edu_ratio)=c("Country","Year","Series","Value")
edu_ratio = cast(edu_ratio, Country + Series ~ Year, value = "Value") 
edu_ratio_2005 = cast(edu_ratio[,c(1,2,5)], Country ~ Series, value = "2005")
data = merge(data, edu_ratio_2005, by = "Country", all.x  = T)


hist(data$`Adolescent birth rate`, xlab = "Adoloscent Birth Rate", main = "Adoloscent Birth Rate Histogram")
hist(data$`Share of seats in parliament`,xlab = "Seats in parliament", main = "Parliament Histogram")
hist(data$`Population with at least some secondary education`,xlab = "Secondary education", main = "Secodary Education Histogram")
hist(data$`Labour force participation rate `,xlab = "Labour force Participation", main = "Labour force Histogram")

names(data)[1:5] = c("Country", "ABR", "PARL", "SEC","LABF")

par(mfrow=c(2,2))
plot(data$ABR, data$PARL, xlab = "Adoloscent Birth Rate", ylab = "Share of Parliament Seat")
plot(data$ABR, data$SEC, xlab = "Adoloscent Birth Rate", ylab = "% with Secondary Education")
plot(data$ABR, data$LABF, xlab = "Adoloscent Birth Rate", ylab = "Labour Force Participation")

parl_av = read.csv("Stats\\Pariliament averag.csv")

gii_data = merge(data, parl_av, by.y = "Country", by.x = "Country", all.x =T)
names(gii_data)[6] = c("PRIM")
names(gii_data)[9] = c("PARL_2005")

par(mfrow=c(2,2))
hist(gii_data$PARL_AV ,xlab = "Average share Women in Parliament", main = "Average share Women in Parliament")
hist(gii_data$PARL_2005 ,xlab = "Share Women in Parliament 2005", main = "Share Women in Parliament 2005")
hist(gii_data$PRIM, xlab = "Ratio of girls in Primary Education", main = "Ratio of girls in Primary Education")


GiiVars = gii_data[,-c(1)]
cor(GiiVars, use = "complete.obs")

par(mfrow = c(2,2))
#Scatterplots to inspect linearity
plot(gii_data$ABR, gii_data$PARL, xlab = "Adolescent Birth Rate", ylab = "Current Share of Parliament Seat")
plot(gii_data$ABR, gii_data$SEC, xlab = "Adolescent Birth Rate", ylab = "% with Secondary Education")
plot(gii_data$ABR, gii_data$LABF, xlab = "Adolescent Birth Rate", ylab = "Labour Force Participation")
plot(gii_data$PARL_AV, gii_data$LABF, xlab = "Adolescent Birth Rate", ylab = "Average Share of Parliament Seat")
plot(gii_data$PARL_2005, gii_data$LABF, xlab = "Adolescent Birth Rate", ylab = "Average Share of Parliament Seat 2005")
plot(gii_data$PRIM, gii_data$LABF, xlab = "Adolescent Birth Rate", ylab = "Ratio of Girls in Primary Education")
# shapiro.test(res)

GiiVars_2 = GiiVars[,-c(2,6)]
cor(GiiVars_2, use = "complete.obs")
# plot(testmodel$residuals)
# densityplot(testmodel$residuals)
# durbinWatsonTest(testmodel$residuals) #what
# vif(testmodel)
# acf(testmodel$residuals)
# durbinWatsonTest(testmodel)
# par(mfrow=c(2,2)) # init 4 charts in 1 panel
# plot(testmodel)

par(mfrow = c(2,2))
plot(model_ABR)

#Log tranformaion on PRIM
gii_data$PRIM_LOG = log(gii_data$PRIM)
par(mfrow= c(1,1))
plot(gii_data$ABR, gii_data$PRIM_LOG, xlab = "Adolescent Birth Rates", ylab = "Log of Ratio of girls in Primary Education")

model_ABR = lm(ABR ~ SEC + LABF + PRIM_LOG, data = gii_data)

#Visual summary of model
par(mfrow = c(2,2))
plot(model_ABR)

model_ABR = lm(ABR ~ SEC + LABF, data = gii_data)
summary(model_ABR)
par(mfrow = c(2,2))
plot(model_ABR)

#VIF Test for multicollinearity
vif(model_ABR)
par(mfrow= c(1,1))
#Histogram of Residuals
hist(model_ABR$residuals, breaks = 20, xlab = "Residuals", main = "Histogram of Residuals")

#Test residuals normality
shapiro.test(model_ABR$residuals)

#Test independence of errors
durbinWatsonTest(model_ABR)

#Test homoscedasticity
ncvTest(model_ABR)

glm_data = readxl::read_excel ("Stats\\Logistic data.xlsx")
glm_data = glm_data[,-c(1)]
names(glm_data)=c("country","HDI","HDIL","GII","GIIL","SEC","PRIMR","PRIML","SECR","TERR")
glm_data$HDI = as.factor(glm_data$HDI)
glm_data$PRIML = as.factor(glm_data$PRIML)
glm_data$HDIL = as.factor(glm_data$HDIL)
glm_model = glm(HDI ~ GII+PRIML, data = glm_data, family = "binomial")
summary(glm_model)

plot(glm_data$SEC, glm_data$PRIMR)
plot(glm_data$SEC, glm_data$SECR)
plot(glm_data$SEC, glm_data$TERR)

glm_data$PRIML = c()
for(i in 1:nrow(glm_data)){
  if (gml_data$PRIMR[i] == ' ' || isNA(glm_data[i])
  if (glm_data$PRIMR[i] > 0.8) {
    PRIML = "High"
  } else glm_data$PRIML = "Low"
}
# glm_test = readxl::read_excel("Logistic data.xlsx", na = "..")
# glm_test$HDI = as.factor(glm_test$HDI)
# glm_test$PRIML = as.factor(glm_test$PRIML)
# glm_test$GIIL = as.factor((glm_test$GIIL))

model_test = glm(GIIL ~ HDI + TERR, data = glm_data, family = "binomial")
 summary(model_test)

#Classification Table
classification_table(glm_model, glm_model$model[,1])

#Operating Characteristics of model
glm_pred = predict(glm_model, type = "response")
ROCPred = prediction(glm_pred, glm_data$HDIL)
ROCPerf = performance(ROCPred, "tpr", "fpr")
plot(ROCPerf, colorize = T)

generalhoslem::logitgof(glm_data$HDIL, fitted(glm_model))


newdata3 <- cbind(glm_data, predict(glm_model, newdata = glm_data, type = "link",
                                    se = TRUE))
newdata3 <- within(newdata3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

## view first few rows of final dataset
head(newdata3)

