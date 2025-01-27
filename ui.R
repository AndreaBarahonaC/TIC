suppressMessages(suppressWarnings(library(shiny)))
suppressMessages(suppressWarnings(library(lubridate)))
suppressMessages(suppressWarnings(library(lifecontingencies)))
suppressMessages(suppressWarnings(library(openxlsx)))
suppressMessages(suppressWarnings(library(readxl)))
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(suppressWarnings(library(data.table)))
suppressMessages(suppressWarnings(library(shinythemes)))
suppressMessages(suppressWarnings(library(shinydashboard)))
suppressMessages(suppressWarnings(library(shinyWidgets)))
suppressMessages(suppressWarnings(library(highcharter)))
suppressMessages(suppressWarnings(library(DT)))
suppressMessages(suppressWarnings(library(kableExtra)))
suppressMessages(suppressWarnings(library(ggplot2)))
suppressMessages(suppressWarnings(library(scales)))
suppressMessages(suppressWarnings(library(reactable)))
suppressMessages(suppressWarnings(library(shinyvalidate)))


# cerulean, cosmo, cyborg, darkly, flatly, journal, 
# lumen, paper, readable, sandstone, simplex, slate, 
# spacelab, superhero, united, yeti.

ui <- fluidPage(
  useShinydashboard(),
  theme = shinytheme("paper"),
  
  fluidRow(
    column(3, img(src = "logo_epn.png", height = "100px", align = "right")),
    column(6, align = "center",
           h4("Escuela Politécnica Nacional - Trabajo de Integración Curricular"),
           h6("Evaluación de las propuestas de Reforma al Sistema de Pensiones Ecuatoriano"),
           h6("Profesor: Diego Paúl Huaraca Shagñay"),
           h6("Estudiantes: Andrea Barahona, Tayna Ruiz, Ammy Párraga")
    ),
    column(3, img(src = "logo_fc.png", height = "100px"))
  ),
  
  br(),
  
  tabPanel(
    "TIC",
    fluidRow(
      column(2,
             wellPanel(
               radioButtons("sexo", "Seleccione su sexo:",
                            c("Hombre" = "M", "Mujer" = "F"), selected = "F"),
               numericInput("edad_inicio", "Edad de inicio de cotizaciones (años):", value = 25, min = 18, max = 100),
               numericInput("anio_inicio", "Año de inicio de cotizaciones :", value = 2010, min = 1960, max = 2080),
               numericInput("interes", "Interés (%):", value = 6.25, min = 0),
               numericInput("inflacion", "Inflación (%):", value = 1.826, min = 0),
               numericInput("salario", "Primer sueldo al iniciar las cotizaciones:", value = 600, min = 0),
               numericInput("edad_jubilacion", "Edad de jubilación (años):", value = 60, min = 60, max = 100),
               textOutput("minjub")
             )),
      column(10, 
             tabsetPanel(
               tabPanel(
                 "Sistema Actual",
                 fluidRow(
                   infoBoxOutput("ahorro", width = 4),
                   infoBoxOutput("pension_teorica_actual", width = 4),
                   infoBoxOutput("tasa_reemplazo", width = 4)
                   
                 ),
                 fluidRow(
                   infoBoxOutput('VApension', width = 4),
                   infoBoxOutput("pensionpromedio", width = 4),
                   infoBoxOutput("cobertura", width = 4)
                 ),
                 fluidRow(
                   column(6,
                          highchartOutput("evolucion_reservas_con_aporte", height = "300px"),
                          highchartOutput("deficit_porcentaje", height = "300px"),
                   ),
                   column(6,
                          fluidRow(
                            highchartOutput("tiempo_sss", height = "300px") 
                          ),
                          fluidRow(
                            highchartOutput("porc_cobertura", height = "300px")
                          )
                   )
                 ),
                 fluidRow(
                   reactableOutput("tabla_pensiones")
                 )
               ),
               
               
               tabPanel(
                 "Reforma Andrea Barahona",
                 fluidPage(
                   h4("Reforma: Cálculo en la fórmula de cálculo de la pensión por vejez"),
                   p("Según el Art 199 del Cap. 6 del Anteproyecto de Ley, a partir de la fecha de publicación de la Ley de Pensiones y Ahorro para la 
                     Vejez que reforma la presente Ley de Seguridad Social, la cuantía para el cálculo de la pensión de jubilación 
                     se basará en el promedio mensual de los seis mejores años de ingresos que el afiliado haya aportado, y se incrementará gradualmente
                     a razón de un año por cada año posterior a la reforma hasta alzcanzar un promedio mensual de los 30 mejores años."),
                   fluidRow(
                     sliderInput("anios_calculo_pension", "Número de años considerados para el cálculo de la pensión (años):", value = 8, max = 30, min = 5, width = "35%")
                   ),
                   fluidRow(infoBoxOutput("tasa_reemplazo_reforma", width = 3),  
                            infoBoxOutput("cobertura_reforma", width = 3),
                            infoBoxOutput("pension_teorica_actual_reforma", width = 3),
                            infoBoxOutput('VApension_reforma', width = 3)
                   ),
                   fluidRow(column(6,
                                   #highchartOutput("evolucion_reservas_con_aporte_sin_reforma", height = "300px"),
                                   highchartOutput("evolucion_reservas_con_aporte_con_reforma", height = "300px")
                   ),
                   column(6,
                          highchartOutput("pension_vs_años_con_reforma", height = "300px")
                   )
                   ), 
                   fluidRow(
                     reactableOutput("tabla_pensiones_reformaABC")
                   )
                 )
               ),
               
               tabPanel(
                 "Análisis Tayna Ruiz",
                 fluidPage(
                   h3("Explicación Ley"),
                   p("Aquí puedes agregar más funcionalidades o información adicional.")
                 )
               ),
               
               tabPanel(
                 "Análisis Ammy Párraga",
                 fluidPage(
                   h4("Reforma: Cotización sobre el décimo tercer y cuarto sueldo."),
                   p("El Artículo 182.- Recursos del Seguro de Pensiones, del Anteproyecto de Ley para la Reforma
                     al Sistema de Pensiones, establece que la aportación obligatoria que corresponde al afiliado
                     con relación de dependencia, equivale al 11.06% sobre su remuneración imponible, y esta aportación
                     obligatoria deberá hacerse también sobre el décimo tercer y el décimo cuarto sueldo.
                     Además, El Seguro General de Pensiones, contará con la contribución financiera obligatoria del 40% para
                     el pago de pensiones."),
                   p(""),
                   fluidRow(
                     column(6,
                            highchartOutput("comparación_ahorro_total", height = "300px",width = "400px")
                            ),
                     column(6,
                            highchartOutput("num_coti_chart", height = "300px",width = "400px"))
                   ),
                   tabsetPanel(
                     tabPanel(
                       tags$strong("Escenario Real: Mayor Ahorro y Misma Pensión"),
                       p(""),
                       p(HTML("Actualmente, el valor de la pensión depende únicamente
                              del número de años aportados y del promedio de los cinco
                              mejores años de sueldos o salarios sobre los cuales se
                              realizaron aportes. Por lo tanto, el valor de la pensión
                              seguirá siendo igual al que recibiría el individuo antes
                              de las reformas. <strong>Sin embargo, se observarán cambios en
                              el ahorro, en el tiempo que le tome al ahorro total
                              agotarse (si llegara a hacerlo), y en el aporte del
                              Estado Ecuatoriano a las pensiones del individuo.</strong>")),
                       p(""),
                       fluidRow(infoBoxOutput("VApension_01", width = 3),  
                                infoBoxOutput("pension_teorica_actual_01", width = 3),
                                infoBoxOutput("tasa_reemplazo_01", width = 3),
                                infoBoxOutput('cobertura_01', width = 3)
                       ),
                       p(""),
                       h5(HTML(" Analicemos la Evolución de las reservas del individuo:")),
                       p(""),
                      #  fluidRow(column(6,
                      #                  highchartOutput("evolucion_reservas_con_aporte_sin_decimos", height = "300px")
                      #           ),
                      #           column(6,
                      #                  highchartOutput("evolucion_reservas_con_aporte_con_decimos", height = "300px")
                      #           )
                      # ),
                      # fluidRow(column(6,
                      #                 highchartOutput("evolucion_reservas_sin_aporte_sin_decimos", height = "300px")
                      #           ),
                      #           column(6,
                      #                 highchartOutput("evolucion_reservas_sin_aporte_con_decimos", height = "300px")
                      #           )
                      # ),
                      fluidRow(column(6,
                                      highchartOutput("evolucion_reservas_con_y_sin_aporte_sin_decimos", height = "500px",width = "400px")),
                               column(6,
                                      highchartOutput("evolucion_reservas_con_y_sin_aporte_con_decimos", height = "500px",width = "400px"))
                               ),
                      fluidRow(column(6,
                                      highchartOutput("deficit_porcentaje_01", height = "300px")),
                               column(6,
                                      highchartOutput("porc_cobertura_01",height = "300px"))),
                      fluidRow(
                        reactableOutput("tabla_pensiones_01")
                      )
                     ),
                     tabPanel(
                       tags$strong("Escenario Alternativo: Mayor Ahorro y Propuesta de Nueva Pensión"),
                       textOutput("pen1"),
                       textOutput("pen2"),
                       textOutput("pen3"),
                       textOutput("pen4")
                     )
                     
                   )
                   
                 )
               )
             )
      )
    )
  )
)
