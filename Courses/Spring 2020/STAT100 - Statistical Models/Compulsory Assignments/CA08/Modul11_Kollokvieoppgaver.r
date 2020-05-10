# OPPGAVE 1

# Naa skal dere gjoere deres (kanskje) aller foerste lineaerregresjon. 
# Den er basert paa en lineaer modell som dere spesifiserer i oppgaven, 
# og kommandoen lm(...) betyr at vi ber R beregne en Lineaer Modell (lm)

# A)
# Det aller foerste vi alltid gjoer foer vi gjoer en lineaerregresjon er aa 
# beregne deskriptiv statistikk for variablene i analysen...
hist(bildatafil$alder)
summary(bildatafil$alder)
hist(bildatafil$km)
summary(bildatafil$km)
hist(bildatafil$pris)
summary(bildatafil$pris)
# Kommenter med en setning det du ser.

# B)
# ... og aa plotte sammenhengen mellom dem: 
plot(bildatafil$km,bildatafil$pris, pch=16)

# C) E)
# I denne oppgaven antar vi at pris avhenger av kilometerstanden, eller, om du vil,
# at variasjonen i pris fordeler seg ihht kilometerstanden til bilen. 
# La oss gjoere en lineaer regresjonsanalyse, altsaa tilpasse en lineaer modell: 
min_forste_lineaerregresjon <- lm(pris~km,data=bildatafil)

min_forste_lineaerregresjon
# Oeker eller synker prisen med oekende kjoerelengde? 
# Hvilken regresjonskoeffisient forteller deg dette? 

# I denne utskriften finner du estimater for alle de fire parameterene i modellen: 
# Hvor stor er R2 og hvordan tolker du den?
summary(min_forste_lineaerregresjon)

# D)
# Vi vil plotte data med den tilpassede regresjonslinja:
# Plotter foerst data...
plot(bildatafil$km,bildatafil$pris, pch=16)
# ... legger saa til en rett linje (abline) basert paa den lineaerregresjonen vi gjorde over: 
abline(min_forste_lineaerregresjon)

# Residualene er de estimerte feil-leddene og beregnes ogsaa i lm-analysen. 
# Du finner deskriptiv statistikk for residualene i utskriften fra:
summary(min_forste_lineaerregresjon)
# Alternativt kan du ogsaa beregne dette slik:
summary(min_forste_lineaerregresjon$residuals)
# Sjekk at du faar det samme. 
# Hvilken verdi har gjennomsnittet for residualene? Hvorfor? 
# Lag et histogram for residualene (hvilken fordeling boer det se ut som?)
hist(min_forste_lineaerregresjon$residuals)

# Er sigma lik i hele observasjonsomraadet? Det kan vi for eksempel sjekke 
# ved aa plotte residualene mot den estimerte responsen (y_hatt):
plot(min_forste_lineaerregresjon$fitted.values,min_forste_lineaerregresjon$residuals, pch=16)
abline(h=0)
# Kommenter.

# G)
# Lag en ny modell, men nå med alder som forklaringsvariabel for pris.
# Gjøre deloppgavene b-e om igjen, men med alder som forklaringsvariabel.
# Tips: bytt ut "km" med "alder" i koden
# Sammenlign R2 med tilsvarende for modellen med kjørelengde som forklaringsvariabel.
# Hvilken modell av de to du har tilpasset forklarer mest av variasjonen i pris?


# I) (ekstraoppgave)
# Multivariabel regresjon med kjoerelengde og alder som prediksjonsvariabler:
multivariabel_modell <- lm(pris ~ km + alder, data = bildatafil)
summary(multivariabel_modell)

# Vokser eller avtar R2 i forhold til de enkle modellene?
# Var dette som du forventet?