library(shiny)
library(readr)
library(dplyr)
library(stringr)
library(ggplot2)
library(plotly)

plan_metas <- read_csv("https://gobiernoabierto.cordoba.gob.ar/plan-de-metas/plan-1-metas.csv")
colnames(plan_metas) <- tolower(colnames(plan_metas))
colnames(plan_metas) <- str_replace(colnames(plan_metas)," ", "_")
colnames(plan_metas)[11] <- "lineamiento"

cant_estado_metas <- plan_metas %>% 
  group_by(estado_meta) %>% 
  summarise(cant_estado_meta = n())

metas_por_lineamiento_y_estado <- plan_metas %>%
  group_by(id_lineamiento, lineamiento, estado_meta) %>%
  count() %>%
  ungroup()

shinyServer(function(input, output) {
  # Metas por Lineamiento
  output$valueBoxCordobaSustentable <- renderValueBox({
    cant_metas <- plan_metas %>%
      filter(id_lineamiento == 5) %>%
      count()
    valueBox(
      cant_metas$n, "Metas Córdoba Sustentable", icon = icon("list"),
      color = "green"
    )
  })
  output$valueBoxCordobaCompetitiva <- renderValueBox({
    cant_metas <- plan_metas %>%
      filter(id_lineamiento == 6) %>%
      count()
    valueBox(
      cant_metas$n, "Metas Córdoba Competitiva", icon = icon("list"),
      color = "blue"
    )
  })
  output$valueBoxCordobaEquitativaEInclusiva <- renderValueBox({
    cant_metas <- plan_metas %>%
      filter(id_lineamiento == 7) %>%
      count()
    valueBox(
      cant_metas$n, "Metas Equitativa e Inclusiva", icon = icon("list"),
      color = "red"
    )
  })
  output$valueBoxDesarrolloInstitucional <- renderValueBox({
    cant_metas <- plan_metas %>%
      filter(id_lineamiento == 8) %>%
      count()
    valueBox(
      cant_metas$n, "Desarrollo Institucional", icon = icon("list"),
      color = "orange"
    )
  })
  
  # Estado de las Metas
  output$valueBoxMetasEnCurso <- renderValueBox({
    valueBox(
      cant_estado_metas[cant_estado_metas$estado_meta == "En curso", ]$cant_estado_meta, 
      cant_estado_metas[cant_estado_metas$estado_meta == "En curso", ]$estado_meta, 
      icon = icon("list"),
      color = "green"
    )
  })
  output$valueBoxMetasAlcanzadas <- renderValueBox({
    valueBox(
      cant_estado_metas[cant_estado_metas$estado_meta == "Meta alcanzada", ]$cant_estado_meta, 
      cant_estado_metas[cant_estado_metas$estado_meta == "Meta alcanzada", ]$estado_meta,
      icon = icon("list"),
      color = "blue"
    )
  })
  output$valueBoxMetasSuperadas <- renderValueBox({
    valueBox(
      cant_estado_metas[cant_estado_metas$estado_meta == "Meta superada", ]$cant_estado_meta, 
      cant_estado_metas[cant_estado_metas$estado_meta == "Meta superada", ]$estado_meta, 
      icon = icon("list"),
      color = "orange"
    )
  })
  output$valueBoxMetasNoIniciadas <- renderValueBox({
    valueBox(
      cant_estado_metas[cant_estado_metas$estado_meta == "No iniciado", ]$cant_estado_meta, 
      cant_estado_metas[cant_estado_metas$estado_meta == "No iniciado", ]$estado_meta, 
      icon = icon("list"),
      color = "red"
    )
  })
  
  # Estado Metas por Lineamiento
  output$plotEstadoMetasPorLineamiento <- renderPlotly({
    plot <- metas_por_lineamiento_y_estado %>%
      mutate(lineamiento = factor(lineamiento, levels = unique(lineamiento)),
             estado_meta = factor(estado_meta, levels = c("Meta superada", "Meta alcanzada", "En curso", "No iniciado"))) %>%
      ggplot() +
      geom_col(aes(x = lineamiento, y = n, fill = estado_meta), position = position_fill()) + 
      coord_flip() + 
      scale_x_discrete(limits = rev(levels(metas_por_lineamiento_y_estado$lineamiento))) +
      scale_fill_manual(values = c("orange", "blue", "green", "red")) +
      xlab("") + ylab("")
    
      ggplotly(plot)
  })
  
})
