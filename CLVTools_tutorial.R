# Package install & library
install.packages("CLVTools")
library(CLVTools)

# Demo Data
data("apparelTrans")
data("apparelDynCov")

apparelTrans
apparelDynCov

# Step1. CLV Data
clv.apparel <- clvdata(apparelTrans,
                       date.format = "ymd",
                       time.unit= "week",
                       estimation.split=40,
                       name.id="Id",
                       name.date="Date",
                       name.price="Price")

summary(clv.apparel)

# Step2. Model Fitting

## Estimate the PNBD model
est.pnbd<- pnbd(clv.data=clv.apparel)
## Estimate the BGNBD model
est.bgnbd <- bgnbd(clv.data=clv.apparel)

summary(est.pnbd)
summary(est.bgnbd)

## Set Dynamic covariates
clv.dyn <- SetDynamicCovariates(clv.data = clv.apparel,
                                data.cov.life = apparelDynCov,
                                data.cov.trans = apparelDynCov,
                                names.cov.life = c("Marketing", "Gender", "Channel"),
                                names.cov.trans = c("Marketing", "Gender", "Channel"),
                                name.id = "Id",
                                name.date = "Cov.Date")

# Estimate the PNBD with Covariates 
est.pnbd.dyn <- pnbd(clv.dyn)
summary(est.pnbd.dyn)

## Plotting
plot(est.pnbd)
plot(est.bgnbd)
plot(est.pnbd.dyn)


## Predict
predict(est.pnbd)
predict(est.bgnbd)
predict(est.pnbd.dyn)





