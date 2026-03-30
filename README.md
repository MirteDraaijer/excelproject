# MM-curve fitting applicatie

Een dashboard voor het fitten van MM-curves door gemeten datapunten, applicatie gemaakt op basis van Excel sheets van NHL Stenden & van Hall Larenstein.

## Auteur

-   Mirte Draaijer

## Beschrijving

In dit dashboard kan de gebruiker gemeten enzym concentraties + enzym activiteiten invoeren. Op basis hiervan zal een MM-curve gefit worden. Deze kan dan gebruikt worden voor verdere analyse en/of verslaglegging van de gemeten data.

## Systeem vereisten en installatie {#systeem-vereisten-en-installatie}

-   OS: windows 11, linux, MacOS
-   R: 4.5.0 of hoger

**Kloon de repository:**

``` bash
git clone git@github.com:MirteDraaijer/excelproject.git
```

**Installeer de benodigde R-packages:**

``` r
  install.packages(c(
    "shiny",
    "ggplot2",
    "renz",
    "minpack.lm"
  ))
```

### Versie details

De applicatie is gemaakt met R versie [4.5.0](https://cran.r-project.org/bin/windows/base/old/4.5.0/) en onderstaande R-packages zijn gebruikt in de applicatie:

| Package:                                         | Beschrijving:                                                  |Versie:|
|--------------------------------------------------|----------------------------------------------------------------|-------|
| [shiny](https://github.com/rstudio/shiny)        | Gebruikt voor het maken van de applicatie.                     |1.13.0 |
| [ggplot](https://github.com/tidyverse/ggplot2)   | Gebruikt voor het maken van de visualisaties.                  | 3.5.2 |
| [renz](https://github.com/jcaledo/renzGH)        | Gebruikt voor het fitten van de MM-curve door de data.         | 0.2.1 |
| [minpack.lm](https://github.com/cran/minpack.lm) | Gebruikt voor het fitten van substraat-inhibitie door de data. | 1.2-4 |

## De applicatie uitvoeren

Als de applicatie is geïnstalleerd zoals beschreven in [systeem vereisten en installatie](#systeem-vereisten-en-installatie) 
dan kan het bestand `app.R` geopend worden in RStudio. Na het openen van `app.R` 
in RStudio is er bovenaan het document een knop te zien: `Run App` als hierop 
wordt geklikt wordt de applicatie uitgevoerd.

Als de applicatie niet is geïnstalleerd kan deze gebruikt worden via de volgende 
URL: HIER DE LINK

## Gebruikershandleiding

NOG AANVULLEN MET SCREENSHOTS!

De MM-curve fitting applicatie heeft een aantal tabladen en functionaliteiten waaruit 
gekozen kan worden. In deze sectie zal elk tablad kort doorlopen worden, met waar nodig
instructies over hoe deze functionaliteit gebruikt kan worden.

### Welkomstpagina

Wanneer de app geopend wordt, beland je op het welkomst-scherm. Hier kan in de menubalk bovenin gekozen worden voor:

- Welkom: de pagina waarop je op dit moment bent.
- Enkele curve: op deze pagina kan een enkele curve gefit worden.
- Dubbele curve: op deze pagina kan een dubbele curve gefit worden.
- Substraat inhibitie: op deze pagina kan substraat inhibitie gefit worden.
- Info en contact: op deze pagina staat aanvullende informatie en de contactgegevens.

### Enkele curve

Op deze pagina kan een enkele curve geplot worden. Om dit te doen moeten de 
volgende stappen doorlopen worden:

1. Vul de gemeten concentraties in.
2. Vul de gemeten activiteiten in.
3. Vul de eenheid voor de concentratie in.
4. Vul de eenheid voor de activiteit in.
5. Klik op de 'Maak plot' knop.

### Dubbele curve

Op deze pagina kan een dubbele curve geplot worden. Om dit te doen moeten de 
volgende stappen doorlopen worden:

1. Vul de gemeten concentraties in voor dataset 1.
2. Vul de gemeten activiteiten in voor dataset 1.
3. Herhaal stap 1 en stap 2 voor dataset2.
4. Vul de eenheid voor de concentratie in.
5. Vul de eenheid voor de activiteit in.
6. Klik op de 'Maak plot' knop.

### Substraat inhibitie

Op deze pagina kan substraat inhibitie gefit worden. Om dit te doen moeten de 
volgende stappen doorlopen worden:

1. Vul de gemeten concentraties in.
2. Vul de gemeten activiteiten in.
3. Vul de eenheid voor de concentratie in.
4. Vul de eenheid voor de activiteit in.
5. Klik op de 'Maak plot' knop.

### Info en contact

Op deze pagina is extra informatie te vinden over hoe de verschillende fits tot 
stand komen. Ook zijn hier hyperlinks naar externe pagina's met aanvullende informatie 
over een aantal onderwerpen.

Verder staan de contactgegevens op deze pagina.

## Ondersteuning

In het geval van bugs of als er ondersteuning nodig is, open een issue op de [repository](https://github.com/MirteDraaijer/excelproject/issues).
