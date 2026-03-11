# MM-curve fitting applicatie
Een dashboard voor het fitten van MM-curves door gemeten datapunten, applicatie
gemaakt op basis van Excel sheets van NHL Stenden & van Hall Larenstein.

## Auteur

- Mirte Draaijer

## Beschrijving

In dit dashboard kan de gebruiker gemeten enzym concentraties + enzym activiteiten 
invoeren. Op basis hiervan zal een MM-curve gefit worden. Deze kan dan gebruikt
worden voor verdere analyse en/of verslaglegging van de gemeten data.

## Systeem vereisten en installatie

- OS: windows 11, linux, MacOS
- R: 4.5.0 of hoger

**Kloon de repository:**

```bash
git clone git@github.com:MirteDraaijer/excelproject.git
```

**Installeer de benodigde R-packages:**

```r
  install.packages(c(
    "ggplot2",
    "renz"
  ))
```

### Versie details

De applicatie is gemaakt met R versie [4.5.0 ](https://cran.r-project.org/bin/windows/base/old/4.5.0/) en onderstaande R-packages zijn gebruikt in de applicatie:

| Package:                                       | Beschrijving:                                          | Versie: |
|------------------------------------------------|--------------------------------------------------------|---------|
| [ggplot](https://github.com/tidyverse/ggplot2) | Gebruikt voor het maken van de visualisaties.          | 3.5.2   |
| [renz](https://github.com/jcaledo/renzGH)      | Gebruikt voor het fitten van de MM-curve door de data. | 0.2.1   |

## De applicatie uitvoeren

Als de applicatie is geïnstalleerd zoals beschreven in [systeem vereisten en installatie](#systeem-vereisten-en-installatie) dan kan het bestand `app.Rmd` geopend worden in RStudio.
Na het openen van `app.Rmd` in RStudio is er bovenaan het document een knop te zien: `Run Document` als hierop wordt geklikt wordt de applicatie uitgevoerd.

Als de applicatie niet is geïnstalleerd kan deze gebruikt worden via de volgend URL: HIER DE LINK

## Gebruikershandleiding

Even stap voor stap alles doorlopen.

## Ondersteuning

In het geval van bugs of als er ondersteuning nodig is, open een issue op de [repository](https://github.com/MirteDraaijer/excelproject/issues).
