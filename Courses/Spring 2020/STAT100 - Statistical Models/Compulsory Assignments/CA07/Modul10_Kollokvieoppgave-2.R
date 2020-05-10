# OPPGAVE 1 
# Last ned og last inn beerf via Import Dataset -> From Excel...

# 9 personer har smakt pa ol, og tre typer ol er vurdert med poengsum. 
# Ser forst pa alle de 9 poengsummene samlet
# Forst bor vi plotte data (alltid!) for å få en oversikt.
hist(beerf$Poeng)
boxplot(beerf$Poeng,horizontal=TRUE)

# Forklar hva disse kommandoene gjor, og hva tallene du far, betyr.
mean(beerf$Poeng)
sd(beerf$Poeng)
summary(beerf$Poeng)

# Hvor mange data har vi i hver gruppe? (Se pa datafila.)

# Kommenter folgende plott: 
par(mfrow=c(1,1))
dotchart(beerf$Poeng, as.factor(beerf$type))
dotchart(beerf$Poeng, as.factor(beerf$type),col=as.numeric(as.factor((beerf$type))),pch=16,cex=1.5)
boxplot(Poeng~type,data=beerf)
boxplot(Poeng~type,data=beerf,col=1:3)

# OPPGAVE 1C)
# Dere som ikke har tatt STIN100 og lert tidyverse kan fa deskriptiv statistikk for hver gruppe fra 
# pakken psych:  
install.packages("psych")
library(psych)
# Estimater for my
describeBy(beerf$Poeng, beerf$type)
# Estimat for sigma: se variansanalysen nedenfor ("Residual standard error")

dotchart(beerf$Poeng, as.factor(beerf$type),col=as.numeric(as.factor((beerf$type))),pch=16,cex=1.5)
abline(v=mean(beerf$Poeng[beerf$type=="A"]),col=1)
abline(v=mean(beerf$Poeng[beerf$type=="S"]),col=3)
abline(v=mean(beerf$Poeng[beerf$type=="L"]),col=2)

# Er det egentlig anbefalt a gjore en analyse med sa lite data? 

# OPPGAVER 1C), 1D), 1F), 1I), 1J) (dere far bruk for opplysningene fra variansanalysen i alle disse oppgavene)
# La oss vere litt ville og gale og gjore det allikevel:
# Forklar hvilken analyse som gjores og hvilke resultater du far
aov(Poeng ~ type, data = beerf)
min_egen_analyse <- aov(Poeng ~ type, data = beerf)
summary(min_egen_analyse)

# Er det forskjell pa responsen (poengsummene) til de tre oltypene?

# Sa skal vi sammenligne de to typene lager-ol, altsa "L" og "S"
# Det gjor vi ved en sakalt kontrast-analyse. Les fila kontraster.pdf pa Canvas for a lere mer. 
# For a gjore analysen i R trenger vi en egen pakke, gmodels: 
install.packages("gmodels")
library(gmodels, pos = 25)

# Les avsnittene Details og Value i hjelpefila for fit.contrasts:
?fit.contrast
?contr.helmert

# OPPGAVE 1J)
# Pa bakgrunn av dette, hvilken analyse gjor du nar du skriver: 
fit.contrast(model = min_egen_analyse, varname = "type", df = TRUE, coeff = c(0,-1, 1), conf.int = 0.95)
fit.contrast(model = min_egen_analyse, varname = "type", df = TRUE, coeff = c(0, 1,-1), conf.int = 0.95)
# Hvorfor blir standardfeilen og p-verdien den samme for begge tester? Hint: |T|

# Sammenlign dette resultatet med det du far ved a kjore en to-utvalgs t-test for a sammenligne
# gruppe "L" mot gruppe "S" (altsa alle olpoengsummer som ikke er "A")
t.test(beerf$Poeng[beerf$type!="A"] ~ beerf$type[beerf$type!="A"])

# Hvorfor kan du ofte forvente a fa lavere p-verdi i en kontrast-analyse? 
# (svaret har med n a gjore, og det finner du pa siste side i kontraster.pdf)

# Hvorfor far du allikevel lavere p-verdi i t-testen her? 
# (svaret har med det totale standardavviket a gjore, jfr det du nettopp leste pa siste side i kontraster.pdf)



# OPPGAVE 2

# Last ned og last inn fila beerm og gjenta analysene i Oppgave 1. 



# OPPGAVE 3 

aar <- seq(1946,1950,by=1)
aar
stork <- c(100,130,151,170,180)
barn <- c(51,54,58,61,62)

plot(stork,barn)
plot(stork,barn,pch=8)
plot(stork,barn,pch=16)

cor(barn,stork)



# Oppgave 4
# Last ned og last inn Body1 via File -> Open File...

View(Body1)
plot(Body1$skj1,Body1$vekt,pch=16)

# OPPGAVE 4C)
cor(Body1$skj1,Body1$vekt)

# OPPGAVE 4D)
# Folgende kommando setter sammen (binder sammen) ("column-binding", leser jeg inni meg)
# kolonnene vekt og de 9 forste colonnene i Body1, som er de 9 skjelettvariablene: 
vekt_og_skjelett <- cbind(Body1$vekt,Body1[,1:9])
cor(vekt_og_skjelett)
# Gjor det samme, men med litt ferre desimaler (runder av til 2 desimaler etter komma)
round(cor(vekt_og_skjelett),2)

# Gjor det samme for omkretsvariablene: 
vekt_og_omkrets <- cbind(Body1$vekt,Body1[,10:21])
cor(vekt_og_omkrets)
round(cor(vekt_og_omkrets),2)

# Bruk feiekosten i Environment-vinduet til a slette tidligere data
# Last deretter ned Body2.RData pa egen maskin og apne det i RStudio

View(Body2)
plot(Body2$skj1,Body2$vekt,pch=16)

# OPPGAVE 4E)
cor(Body2$skj1,Body2$vekt)

# Folgende kommando setter sammen (binder sammen) ("column-binding", leser jeg inni meg)
# kolonnene vekt og de 9 forste colonnene i Body2, som er de 9 skjelettvariablene: 
vekt_og_skjelett <- cbind(Body2$vekt,Body2[,1:9])
cor(vekt_og_skjelett)
# Gjor det samme, men med litt ferre desimaler (runder av til 2 desimaler etter komma)
round(cor(vekt_og_skjelett),2)

# Gjor det samme for omkretsvariablene: 
vekt_og_omkrets <- cbind(Body2$vekt,Body2[,10:21])
cor(vekt_og_omkrets)
round(cor(vekt_og_omkrets),2)
