### AULA SOBRE O PACOTE FORCATS ###

# A representação de dados categóricos no R consiste:
# 1. Um set de valores.
# 2. Um set ordenado de níveis válidos

eyes <- factor(x = c("blue", "green", "green"),
               levels = c("blue", "brown", "green"))
eyes

## O forcats apresenta funções para trabalhar com FATORES.

gss_cat # Banco de dados disponível no forcats.

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  group_by(relig) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

# A ordem fica assim esquisita porque os levels de relig têm essa ordem.

levels(gss_cat$relig)

### REORDENANDO LEVELS

 # fct_reorder(f, x), onde f é o fator pra reordenar e x é a variável que vai ser o parâmetro para reordenar.

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  group_by(relig) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  group_by(marital) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(marital, tvhours))) +
  geom_point()

## FUNÇÕES DE REORDENAMENTO SIMILARES

gss_cat %>%
  ggplot(aes(marital)) +
  geom_bar()

gss_cat %>%
  ggplot(aes(fct_infreq(marital))) + # Classe mais frequente fica à esquerda.
  geom_bar()

gss_cat %>%
  ggplot(aes(fct_rev(fct_infreq(marital)))) + # Classe mais frequente fica à direita.
  geom_bar()

## MUDANDO O VALOR DOS LEVELS

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  group_by(partyid) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(partyid, tvhours))) +
  geom_point() +
  labs(y = "partyid") # Os levels têm nomes esquisitos. Vamos mudá-los.

# fct_recode(f, "x" = "y" ), onde f é o fator, x é o novo nome do fator, y é o antigo nome do fator.

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  mutate(partyid = fct_recode(partyid, 
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat")) %>%
  group_by(partyid) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(partyid, tvhours))) +
  geom_point() # Há alguns levels similares em sua definição, por isso vamos agrupa-los.

## AGRUPANDO LEVELS

 # fct_collapse(f, x = c("y", "z")), onde f é o fator com os levels, x é o nome do novo level, y e z são os levels que vão ser agrupados no level x.

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  mutate(partyid = fct_collapse(partyid,
                                conservative = c("Strong republican",
                                                 "Not str republican",
                                                 "Ind,near rep"),
                                liberal = c("Strong democrat",
                                            "Not str democrat",
                                            "Ind,near dem"))) %>%
  group_by(partyid) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(partyid, tvhours))) +
  geom_point() + labs(y = "partyid")

# fct_lump() -> colapsa levels com poucos valores em um só level.

gss_cat %>%
  filter(!is.na(tvhours)) %>%
  mutate(partyid = partyid %>%
           fct_collapse(
             conservative = c("Strong republican",
                              "Not str republican", "Ind,near rep"),
             liberal = c("Strong democrat", "Not str democrat",
                         "Ind,near dem")) %>%
          fct_lump()
  ) %>%
  group_by(partyid) %>%
  summarise(tvhours = mean(tvhours)) %>%
  ggplot(aes(tvhours, fct_reorder(partyid, tvhours))) +
  geom_point() + labs(y = "partyid")

