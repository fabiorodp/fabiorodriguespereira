# Datasettet inneholder målinger av volum av venstre hjertekammer
View(idrett)

# I oppgaven er i indeks for grupper og j indeks for individer. 
# I R er systemet alltid data[rad,kolonne], så 
idrett[1,2] # betyr rad 1 og kolonne 2 i datasettet idrett, se på datasettet med View og set at det stemmer

# Det betyr at Y_32 som det spørres etter i oppgaven er 
# hjertevolum for individ nr 2 i idrett nr 3, og det finner vi ved  
idrett[2,4]  # (Hvorfor?) 

# Se på datasettet ved å skrive 
idrett
# Hvilket tall får du hvis du skriver 
ncol(idrett) 

# Hva får du hvis du skriver
idrett[,-1]
# Hvilket tall får du hvis du skriver 
ncol(idrett[,-1]) 

k <- ncol(idrett[,-1])
k
n <- nrow(idrett)
n

# Estimater for my_1, my_2, my_3 og my_4:
my_1_hatt <- mean(idrett$svomming)
my_2_hatt <- mean(idrett$loping)
my_3_hatt <- mean(idrett$langrenn)
my_4_hatt <- mean(idrett$bryting)

# Gruppenes standardavvik og varianser. Kommenter tallene. 
sd(idrett$svomming)
var(idrett$svomming)
sd(idrett$loping)
var(idrett$loping)
sd(idrett$langrenn)
var(idrett$langrenn)
sd(idrett$bryting)
var(idrett$bryting)



# Datasettet du har lest inn har data ved siden av hjerandre for ulike grupper. Dette gir mening hvis det 
# er like mange individer i hver gruppe. Men selv om gruppene hadde hatt ulik størrelse, ville det vært 
# lett å se hvordan vi regner ut gjennomsnitt og empirisk standardavvik (og varians) i hver gruppe. 
# Når vi skal analysere forskjeller mellom grupper, er dette første steg.

# For å gå videre og gjøre en statistisk test for gruppesammenligningen: 
# H_0: Alle gruppene er like, mot
# H_1: Ikke alle gruppene er like, 
# må data være organisert litt annerledes. 
# Nå må hver linje i datasettet være data for én person.
# På R-språk kalles dette "stackede data", og dere som har tatt STIN100 vet hva dere må gjøre nå. 
# For dere andre har jeg valgt å skrive det på en så forståelig måte (håper jeg) som mulig: 
# Jeg lager rett og slett tre variabler: 
# en som indikerer id for de 40 personene i studien,
# en som indikerer hvilken idrett de driver med, og 
# en som er de målte hjertevolumene. Denne siste er Y_ij

id <- c(1:10,1:10,1:10,1:10) # Skjønte du ikke dette, prøv å skrive 1:10 i console-vinduet

idrettsgren <- 
  c("svomming","svomming","svomming","svomming","svomming","svomming","svomming","svomming","svomming","svomming",
    "loping","loping","loping","loping","loping","loping","loping","loping","loping","loping",
    "langrenn","langrenn","langrenn","langrenn","langrenn","langrenn","langrenn","langrenn","langrenn","langrenn",
    "bryting","bryting","bryting","bryting","bryting","bryting","bryting","bryting","bryting","bryting")

hjertevolum <- c(idrett$svomming,idrett$loping,idrett$langrenn,idrett$bryting)

mean(hjertevolum)
sd(hjertevolum)

boxplot(hjertevolum~idrettsgren)

# Forklar denne R-koden til hverandre: 
aov(hjertevolum~idrettsgren)
min_analyse <- aov(hjertevolum~idrettsgren)
summary(min_analyse)
