library(shiny)
library(shinydashboard)
library(plotly)

shinyUI(dashboardPage(skin = "green",
  dashboardHeader(title = "Córdoba en Datos"),
  dashboardSidebar(sidebarMenu(
    menuItem("Introducción", tabName = "introduccion", icon = icon("thumbs-up")),
    menuItem("Plan de Metas", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Permisionarios Urbanos", tabName = "permisionariosUrbanos", icon = icon("car"))
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "introduccion",
              fluidRow(
                box(h4("El Objetivo de Córdoba en Datos es visualizar datos de interés de la Ciudad de Córdoba en un portal amigable para el usuario final."),
                    title = "INTRODUCCIÓN",
                    width = 8),
                box(tags$img(src="https://github.com/OpenDataCordoba/opendatacordoba.github.io/raw/master/logos/nuevos-logos-hackatONG-2016/ODC%20isologo.png",
                             width = "339px", height = "100px"),
                    width = 4))
              ),
      tabItem(tabName = "dashboard",
              fluidRow(
                box("El plan de metas tiene 4 lineamientos estratégicos. Cada lineamiento tiene componentes. Cada componente tienen objetivos y estos a su vez tienen metas.",
                    br(),br(),
                    "Este instrumento constituye una herramienta de planificación interna y de articulación de esfuerzos para el desarrollo de la ciudad, que permite al ciudadano informarse en detalle sobre las metas y compromisos de la gestión municipal para los próximos cuatro años y realizar un seguimiento de los avances y logros alcanzados; y por otro lado, constituye un medio para identificar obstáculos y reorientar las acciones de gobierno en función de los objetivos definidos cuando fuere necesario.",
                    br(),br(),
                    valueBoxOutput("valueBoxCordobaSustentable", width = 3),
                    valueBoxOutput("valueBoxCordobaCompetitiva", width = 3),
                    valueBoxOutput("valueBoxCordobaEquitativaEInclusiva", width = 3),
                    valueBoxOutput("valueBoxDesarrolloInstitucional", width = 3),
                    title = "Plan de Metas",
                    width = 12)
                ),
              fluidRow(
                box(valueBoxOutput("valueBoxMetasNoIniciadas", width = 3),
                    valueBoxOutput("valueBoxMetasEnCurso", width = 3),
                    valueBoxOutput("valueBoxMetasAlcanzadas", width = 3),
                    valueBoxOutput("valueBoxMetasSuperadas", width = 3),
                    title = "Metas por Estado", width = 12)
                ),
              fluidRow(
                box(plotlyOutput("plotEstadoMetasPorLineamiento"), 
                    title = "Cantidad de Metas por Estado y Lineamiento",width = 12)
              )
              ),
      tabItem(tabName = "permisionariosUrbanos",
              fluidRow(
                box("Estadísticas sobre los Permisionarios Urbanos Habilitados encargados de cobrar y controlar el estacionamiento en la ciudad de Córdoba (comúnmente mal llamados naranjitas).",
                    title = "Permisionarios Urbanos", 
                    width = 9),
                valueBoxOutput("cantidadTotalPermisionarios", width = 3)
              ),
              fluidRow(
                box(plotlyOutput("permisionariosPorCooperativa"), 
                    title = "Cantidad de Permisionarios por Cooperativa", 
                    width = 6),
                box(tags$iframe(src="https://www.google.com/maps/d/embed?mid=1dZ8XX2nP9XX24CyzsbbR9gQUuwA&hl=es", 
                                height = "600", width = "100%"),
                width = 6)
              )
          )
      )
    )
  )
)
