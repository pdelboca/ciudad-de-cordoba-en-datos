plan_metas <- read_csv("https://gobiernoabierto.cordoba.gob.ar/plan-de-metas/plan-1-metas.csv")
colnames(plan_metas) <- colnames(plan_metas) %>% 
  tolower() %>% 
  str_replace(" ", "_")
colnames(plan_metas)[11] <- "lineamiento"

cant_estado_metas <- plan_metas %>% 
  group_by(estado_meta) %>% 
  summarise(cant_estado_meta = n())

metas_por_lineamiento_y_estado <- plan_metas %>%
  group_by(id_lineamiento, lineamiento, estado_meta) %>%
  count() %>%
  ungroup()

#################

permisionarios <- read_csv("https://gobiernoabierto.cordoba.gob.ar/cooperativas-estacionamiento/lista-de-asociados.csv")
colnames(permisionarios) <- colnames(permisionarios) %>% 
  tolower() %>% 
  str_replace(" ", "_") %>%
  str_replace("ó", "o")
