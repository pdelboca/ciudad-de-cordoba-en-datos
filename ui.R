library(shiny)
library(shinydashboard)
library(plotly)

shinyUI(dashboardPage(skin = "green",
  dashboardHeader(title = "Córdoba en Datos"),
  dashboardSidebar(sidebarMenu(
    menuItem("Plan de Metas", tabName = "dashboard", icon = icon("dashboard"))
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box("El plan de metas tiene 4 lineamientos estratégicos. Cada lineamiento tiene componentes. Cada componente tienen objetivos y estos a su vez tienen metas.",
                    br(),br(),
                    "Este instrumento constituye una herramienta de planificación interna y de articulación de esfuerzos para el desarrollo de la ciudad, que permite al ciudadano informarse en detalle sobre las metas y compromisos de la gestión municipal para los próximos cuatro años y realizar un seguimiento de los avances y logros alcanzados; y por otro lado, constituye un medio para identificar obstáculos y reorientar las acciones de gobierno en función de los objetivos definidos cuando fuere necesario.",
                    title = "Plan de Metas", 
                    footer = "Fuente: https://gobiernoabierto.cordoba.gob.ar",
                    width = 12)
                ),
              fluidRow(
                valueBoxOutput("valueBoxCordobaSustentable", width = 3),
                valueBoxOutput("valueBoxCordobaCompetitiva", width = 3),
                valueBoxOutput("valueBoxCordobaEquitativaEInclusiva", width = 3),
                valueBoxOutput("valueBoxDesarrolloInstitucional", width = 3)
              ),
              fluidRow(box(title = "Metas por Estado", width = 12)),
              fluidRow(
                valueBoxOutput("valueBoxMetasNoIniciadas", width = 3),
                valueBoxOutput("valueBoxMetasEnCurso", width = 3),
                valueBoxOutput("valueBoxMetasAlcanzadas", width = 3),
                valueBoxOutput("valueBoxMetasSuperadas", width = 3)
              ),
              fluidRow(
                box(plotlyOutput("plotEstadoMetasPorLineamiento"), title = "Cantidad de Metas por Estado y Lineamiento",width = 12)
              )
              )
      )
    )
  )
)
