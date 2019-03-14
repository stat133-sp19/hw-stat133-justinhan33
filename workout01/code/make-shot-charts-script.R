# title: Make shot charts

# description: Code for the creation of shot charts

# input(s): nba-court.jpg, stephen-curry.csv, klay-thompson.csv, draymond-green.csv, andre-iguodala.csv, kevin-durant.csv, shots-data.csv

# output(s): stephen-curry-shot-chart.pdf, klay-thompson-shot-chart.pdf, draymond-green-shot-chart.pdf, andre-iguodala-shot-chart.pdf, kevin-durant-shot-chart.pdf, gsw-shot-charts.pdf, gsw-shot-charts.png 

library(jpeg)
library(grid)
library(ggplot2)
library(ggpubr)

court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc")
)

curry_shot_chart <- ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + 
  theme_minimal()
thompson_shot_chart <- ggplot(data = thompson) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + 
  theme_minimal()
green_shot_chart <- ggplot(data = green) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + 
  theme_minimal()
iguodala_shot_chart <- ggplot(data = iguodala) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + 
  theme_minimal()
durant_shot_chart <- ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + 
  theme_minimal()

pdf(file = "../images/stephen-curry-shot-chart.pdf",  width = 6.5, height = 5)
curry_shot_chart
dev.off()
pdf(file = "../images/klay-thompson-shot-chart.pdf",  width = 6.5, height = 5)
thompson_shot_chart
dev.off()
pdf(file = "../images/draymond-green-shot-chart.pdf",  width = 6.5, height = 5)
green_shot_chart
dev.off()
pdf(file = "../images/andre-iguodala-shot-chart.pdf",  width = 6.5, height = 5)
iguodala_shot_chart
dev.off()
pdf(file = "../images/kevin-durant-shot-chart.pdf",  width = 6.5, height = 5)
durant_shot_chart
dev.off()

gsw_shot_charts <- ggplot(data = combined_data) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 0.5) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW (2016 season)') + 
  theme_minimal() + 
  facet_wrap(~name)

pdf(file = "../images/gsw-shot-charts.pdf",  width = 8, height = 7)
gsw_shot_charts
dev.off()

png(filename = "../images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 300)
gsw_shot_charts
dev.off()