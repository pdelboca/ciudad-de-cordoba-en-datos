library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(readr)
library(dplyr)
library(stringr)
source("./data/data.R")

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
  
  ##################################################################################################
  # Permisionarios
  output$permisionariosPorCooperativa <- renderPlotly({
    plot <- permisionarios %>%
      mutate(cooperativa = str_replace(cooperativa, "Cooperativa de Trabajo", ""),
             cooperativa = str_replace_all(cooperativa, "\"", ""),
             cooperativa = str_replace(cooperativa, "Ltda.", "")) %>% 
      group_by(cooperativa) %>%
      count() %>%
      ungroup() %>%
      ggplot() +
      geom_col(aes(x=cooperativa, y=n)) + theme_minimal() +
      xlab("Cooperativa de Trabajo") + ylab("Cantidad de Permisionarios")
    
    ggplotly(plot)
    })
  
  output$cantidadTotalPermisionarios <- renderValueBox({
    valueBox(
      nrow(permisionarios), "Permisionarios Habilitados", icon = icon("users")
      )
  })
  
})
