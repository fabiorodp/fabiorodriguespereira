# Oppgave 1


# 1D)
# Foerst lager vi individdataene for de 200 personene i undersoekelsen. 
sex <- c(rep("M",100),rep("F",100))
sex
smk <- c(rep(1,80),rep(0,20),rep(1,60),rep(0,40))
smk

contingencytable <- table(smk, sex)
contingencytable

# 1E)
# Saa tester vi om det er forskjell paa de to gruppene.
chisq.test(contingencytable)
# Les dokumentet "Halvkorreksjon.pdf" paa canvas. Denne kjikvadrattesten er med halvkorreksjon
# (Yates' continuity correction)
# Naar dere regner for haand er det uten halvkorreksjon
# For aa utfoere kjikvadrattest i R uten halvkorreksjon:
chisq.test(contingencytable, correct = FALSE)

# p-verdien fra en saann test er bare paalitelig hvis det er et tilstrekkelig antall observasjoner 
# og disse er godt fordelt utover i tabellen. 
# Dette undersoeker vi ikke ved aa se paa de faktiske observasjonene i tabellen, men derimot 
# ved aa se paa de forventede antallene, ...$expected og se om alle disse er stoerre enn 5
# Saann faar vi tak i dem: 
min_tabellanalyse <- chisq.test(contingencytable)
min_tabellanalyse$expected



# Oppgave 2

# Foerst lager vi individdataene for personene i undersoekelsen. 
svarte_paa_evaluering <- c(rep("Nei",82),rep("Ja",133))
personlighetstyper <- c(rep("CE",22),rep("CI",20),rep("DE",19),rep("DI",21), 
                        rep("CE",25),rep("CI",32),rep("DE",25),rep("DI",51))
# Deretter lager vi krysstabellen: 
contingencytable2 <- table(svarte_paa_evaluering,personlighetstyper)
contingencytable2

# 2C)
barplot(contingencytable2, beside=TRUE, xlab="Personlighetstype", ylab="Antall svar",
        legend=rownames(contingencytable2))

# 2D)
# Saa tester vi om det er en sammenheng mellom radene og kolonnene i tabellen, altsaa
# om det er en forskjell i fordelingen av personlighetstyper mellom de som besvarte evalueringen
# og de som ikke gjorde det, eller alternativt, om det er en forskjell i svarprosenten mellom 
# de fire personlighetstypegruppene.
chisq.test(contingencytable2)

# p-verdien fra en saann test er bare paalitelig hvis det er et tilstrekkelig antall observasjoner 
# og disse er godt fordelt utover i tabellen. 
# Dette undersoeker vi ikke ved aa se paa de faktiske observasjonene i tabellen, men derimot 
# ved aa se paa de forventede antallene, ...$expected og se om alle disse er stoerre enn 5
# Saann faar vi tak i dem: 
min_tabellanalyse2 <- chisq.test(contingencytable2)
min_tabellanalyse2$expected

# E)
# Forventet antall svar for kombinasjonen "Svar: Nei" og "DI" under H0
# Henter ut verdien i rad 2, kolonne 4
min_tabellanalyse2$expected[2,4]

# F)
# Bidrag til testobservatoren fra DI-studenter som ikke svarte paa evalueringen:
# Se paa tabellene under for aa finne forventet verdi og regn ut for haand ved formelen:
# (observert-forventet)^2 /forventet
contingencytable2
min_tabellanalyse2$expected

# Kan ogsaa regne ut i Rstudio: 
((contingencytable2[2,4]-min_tabellanalyse2$expected[2,4])^2)/min_tabellanalyse2$expected[2,4]

# eller du kan regne ut chi-square verdiene for hele tabellen for deretter aa lese av for "DI" og "Nei": 
((contingencytable2-min_tabellanalyse2$expected)^2)/min_tabellanalyse2$expected


# 2G)
gruppeprosess <- c(rep("1-3",37),rep("4-5",96))
personlighetstyper <- c(rep("CE",10),rep("CI",13),rep("DE",3),rep("DI",11), 
                        rep("CE",15),rep("CI",19),rep("DE",22),rep("DI",40))
contingencytable3 <- table(gruppeprosess,personlighetstyper)
contingencytable3

# Er det signifikant effekt av personlighet paa hvor godt studentene oppfattet at statistikkgruppen sin fungerte?
chisq.test(contingencytable3)

# Forventede verdier
min_tabellanalyse3 <- chisq.test(contingencytable3)
min_tabellanalyse3$expected

# Chi-square verdier:
((contingencytable3-min_tabellanalyse3$expected)^2)/min_tabellanalyse3$expected
