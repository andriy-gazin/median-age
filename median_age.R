library(ggplot2)
library(tidyr)
library(geofacet)
source('custom_grid.R')

df <- read.csv('median_age.csv', stringsAsFactors = F)

df <- df %>% gather(key = sex, value = median_age, -region, -year)
df$region <- trimws(df$region)

png(filename = 'median_age_no_subtitle.png', width = 1200, height = 1000)

ggplot(df)+
  geom_rect(aes(xmin = 2001, xmax = 2003, ymin = -Inf, ymax = Inf), fill = '#DCDAD7', alpha = 0.05)+
  geom_rect(aes(xmin = 1988, xmax = 1990, ymin = -Inf, ymax = Inf), fill = '#DCDAD7', alpha = 0.05)+
  geom_line(aes(x = year, y = median_age, color = sex), size = 1)+
  facet_geo(~region, grid = ukraine)+
  scale_x_continuous(breaks = seq(1990, 2015, 5), labels = c("'90", "'95", "'00", "'05", "'10", "'15"))+
  scale_color_manual(values = c('#3288bd', '#d53e4f'), labels = c('чоловіки ', 'жінки'))+
  labs(title = 'Медіанний вік населення у 1989-2016 роках',
       subtitle = 'У 1989 та 2002 роках інформація подається за даними переписів населення',
       caption = 'Дані: Державна служба статистики України | Візуалізація: Textura.in.ua')+
  theme_minimal()+
  theme(text = element_text(family = 'Ubuntu Condensed', face = 'plain', color = '#3A3F4A'),
        axis.title = element_blank(),
        axis.text = element_text(size = 12),
        strip.text.x = element_text(size = 16),
        panel.spacing.x = unit(1.25, 'lines'),
        panel.spacing.y = unit(1.50, 'lines'),
        legend.position = 'top',
        legend.text = element_text(size = 16),
        legend.title = element_blank(),
        panel.grid.major = element_line(size = 0.35, linetype = 'dotted', color = '#5D646F'),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = 'bold', size = 40, margin = margin(b = 10, t = 20)),
        plot.subtitle = element_text(size = 20, face = 'plain', margin = margin(b = 30)),
        plot.caption = element_text(size = 16, margin = margin(b = 10, t = 50), color = '#5D646F'),
        plot.background = element_rect(fill = '#EFF2F4'),
        plot.margin = unit(c(2, 2, 2, 2), 'cm'))

dev.off()