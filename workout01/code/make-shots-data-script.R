# title: Make shots data

# description: Code for data preparation about made shots

# input(s): stephen-curry.csv, klay-thompson.csv, draymond-green.csv, andre-iguodala.csv, kevin-durant.csv

# output(s): stephen-curry-summary.txt, klay-thompson-summary.txt, draymond-green-summary.txt, andre-iguodala-summary.txt, kevin-durant-summary.txt, shots-data-summary.txt, shots-data.csv

column_types <- c("team_name"="character", "game_date"="character", "season"="integer", "period"="integer", "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character", "action_type"="character", "shot_type"="character", "shot_distance"="integer", "opponent"="character", "x"="integer", "y"="integer")
curry <- read.csv("../data/stephen-curry.csv", header = T, colClasses = column_types, stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", header = T, colClasses = column_types, stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", header = T, colClasses = column_types, stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", header = T, colClasses = column_types, stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", header = T, colClasses = column_types, stringsAsFactors = FALSE)

curry_name <- rep("Stephen Curry", length(curry$team_name))
thompson_name <- rep("Klay Thompson", length(thompson$team_name))
green_name <- rep("Draymond Green", length(green$team_name))
iguodala_name <- rep("Andre Iguodala", length(iguodala$team_name))
durant_name <- rep("Kevin Durant", length(durant$team_name))

curry$name <- curry_name
thompson$name <- thompson_name
green$name <- green_name
iguodala$name <- iguodala_name
durant$name <- durant_name

curry$shot_made_flag[curry$shot_made_flag=="y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag=="n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag=="y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag=="n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag=="y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag=="n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag=="y"] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag=="n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag=="y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag=="n"] <- "shot_no"

curry$minute <- (curry$period * 12) - curry$minutes_remaining
thompson$minute <- (thompson$period * 12) - thompson$minutes_remaining
green$minute <- (green$period * 12) - green$minutes_remaining
iguodala$minute <- (iguodala$period * 12) - iguodala$minutes_remaining
durant$minute <- (durant$period * 12) - durant$minutes_remaining

sink(file = '../output/stephen-curry-summary.txt')
summary(curry[ , ])
sink()
sink(file = '../output/klay-thompson-summary.txt')
summary(thompson[ , ])
sink()
sink(file = '../output/draymond-green-summary.txt')
summary(green[ , ])
sink()
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala[ , ])
sink()
sink(file = '../output/kevin-durant-summary.txt')
summary(durant[ , ])
sink()

combined_data <- rbind(curry, thompson, green, iguodala, durant)
write.csv(
  x = combined_data, 
  file = "../data/shots-data.csv"
)

sink(file = '../output/shots-data-summary.txt')
summary(combined_data[ , ])
sink()

