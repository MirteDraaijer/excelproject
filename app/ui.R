library(shiny)

ui <- fluidPage(
  theme = "lumen",
  
  div(
    style = "background-color:#2C3E50; padding:25px; border-radius:10px; margin-bottom:20px; margin-top:20px;",
    h2("MM-curve fitting applicatie",
       style = "color:#F8F9FA; margin:0; font-weight:600;")
    ),
  
  tabsetPanel(
    tabPanel("Welkom",
    p("In deze applicatie kun je een MM-curve fitten door gemeten datapunten. Er is keuze uit een
      enkele curve en een dubbele curve.")),
    
    tabPanel("Enkele curve",
    p("Gebaseerd op gemeten activiteiten \\((v)\\) bij gegeven concentraties \\((S)\\) wordt een MM-curve
      gefit door de datapunten."),
    p("! Gebruik een '.' als decimaalteken."),
    wellPanel(
      textInput("new_conc", "Voer concentratie in (gescheiden door komma):", placeholder = "Voorbeeld: 1.25, 0.90, 0.60, 0.31, 0.16, 0.08, 0.04, 0.02, 0.01", width = "100%"),
      textInput("new_act", "Voer activiteit in (gescheiden door komma):", placeholder = "Voorbeeld: 1.12e-01, 9.90e-02, 1.10e-01, 9.66e-02, 7.27e-02, 4.80e-02, 2.75e-02, 0.00e00, 6.71e-03", width = "100%"),
      fluidRow(
        column(6, textInput("single_conc_unit", "Concentratie eenheid:")),
        column(6, textInput("single_act_unit", "Activiteit eenheid:"))
        ),
      actionButton("fit_single", "Maak plot")
      ),
    
    br(),
    plotOutput("single_plot", height = "400px")
    ),
    
    tabPanel("Dubbele curve",
    p("Gebaseerd op gemeten activiteiten \\((v)\\) bij gegeven concentraties \\((S)\\) wordt een MM-curve gefit
      voor twee sets aan gemeten datapunten."),
    p("! Gebruik een '.' als decimaalteken."),
    wellPanel(
      textInput("new_conc1", "Voer concentratie in voor dataset 1 (gescheiden door komma):", placeholder =
                  "Voorbeeld: 1.25, 0.90, 0.60, 0.31, 0.16, 0.08, 0.04, 0.02, 0.01", width = "100%"),
      textInput("new_act1", "Voer activiteit in voor dataset 1 (gescheiden door komma):", placeholder =
                  "Voorbeeld: 1.12e-01, 9.90e-02, 1.10e-01, 9.66e-02, 7.27e-02, 4.80e-02, 2.75e-02, 0.00e00, 6.71e-03", width = "100%"),
      textInput("new_conc2", "Voer concentratie in voor dataset 2 (gescheiden door komma):", placeholder =
                  "Voorbeeld: 1.25, 0.90, 0.60, 0.31, 0.16, 0.08, 0.04, 0.02, 0.01", width = "100%"),
      textInput("new_act2", "Voer activiteit in voor datatset 2 (gescheiden door komma):",
                placeholder = "Voorbeeld: 1.12e-01, 9.90e-02, 1.10e-01, 9.66e-02, 7.27e-02, 4.80e-02, 2.75e-02, 0.00e00, 6.71e-03", width = "100%"),
      fluidRow(
        column(6, textInput("double_conc_unit", "Concentratie eenheid:")),
        column(6, textInput("double_act_unit", "Activiteit eenheid:"))
        ),
      actionButton("fit_double", "Maak plot")
      ),
    
    br(),
    plotOutput("double_plot", height = "400px")
    ),
    
    tabPanel("Info en contact",
             h3("Hoe komt de fit tot stand?"),
             p("De Michaelis-Menten vergelijking wordt in deze applicatie gefit met behulp van non linear
             least-squares fitting. Deze methode bepaalt de waarden \\(V_{max}\\) en \\(K_m\\) waarbij het verschil
             tussen de gemeten reactiesnelheden en de door het model voorspelde waarden zo klein mogelijk wordt
               gemaakt. De berekening wordt uitgevoerd met de functie", code("dir.MM()"), "uit de R-package",
               a("Renz", href = "https://cran.r-project.org/web/packages/renz/index.html"), "."),
             p("De", a("Michaelis-Menten vergelijking", href =
             "https://nl.wikipedia.org/wiki/Michaelis-Mentenvergelijking"), "beschrijft de
             enzymkinetiek aan de hand van onderstaand model:"),
             p("$$v = \\frac{V_{\\max}[S]}{K_m + [S]}$$"),
             p("Parameters:"),
             withMathJax(
             HTML("
             <ul>
             <li>\\(V_{\\max}\\): de maximale reactiesnelheid</li>
             <li>\\(K_m\\): een maat voor affiniteit van het enzym voor het substraat</li>
             <li>\\(S\\): de substraatconcentratie</li>
             </ul>
                  ")
             ),
             
             h3("Contactgegevens"),
             p("Deze applicatie is ontwikkeld door Mirte Draaijer gedurende de minor DNA sequencing en biologische
             data-analyse bij NHL Stenden & Van Hall Larenstein.
               Voor contact verwijs ik graag naar de",
               a("github", href = "https://github.com/MirteDraaijer/excelproject/tree/main", target = "_blank"),
               "van deze applicatie of naar mijn",
               a("LinkedIn pagina", href = "https://www.linkedin.com/in/mirte-draaijer-394a58385/"), target =
                 "_blank", ".")
             )
  )
)