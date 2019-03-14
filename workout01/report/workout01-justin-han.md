workout01-justin-han
================
Justin Han

``` r
library(knitr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Narrative
=========

### Introduction

The Golden State Warriors (GSW) are known for their tremendous shooting and record breaking stats. The splash brothers, Stephen Curry and Klay Thompson, are some of the league's most deadly shooters. Stephen Curry broke an NBA record for most three point shots made in a single game (13 three pointers made!) and Klay Thompson broke a record for most points in a quarter (37 points!). If that's not enough, the Golden State Warriors also set a league record with 73 wins! With Kevin Durant, another lethal shooter, all-star, and scoring machine, who signed with the Warriors in the off season, this team is now a living nightmare in the NBA. In this report, we will examine the shooting efficiency of the GSW during the 2016 NBA season.

### Motivation

The purpose for this report is to get a sense of how well the Golden State Warriors shot in the 2016 NBA season.

### Background

Before getting started, data of five Warriors (Stephen Curry, Klay Thompson, Draymond Green, Andre Iguodala, and Kevin Durant) were collected. Through data cleaning and preparation, a combined table of the shots data of the five players was created. Additionally, shot charts of each of the five players were generated in order to provide a visual complement to the numerical data. Lastly, three tables were created, for 2 point shots, 3 point shots, and all shots in general, to display the shooting efficiencies of each player.

### Data

``` r
#Data cleaning and preparation
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

#Create combined table
combined_data <- rbind(curry, thompson, green, iguodala, durant)
head(combined_data)
```

    ##               team_name game_date season period minutes_remaining
    ## 1 Golden State Warriors  12/15/16   2016      3                 3
    ## 2 Golden State Warriors  10/28/16   2016      3                 9
    ## 3 Golden State Warriors   11/1/16   2016      2                 5
    ## 4 Golden State Warriors   12/1/16   2016      3                 5
    ## 5 Golden State Warriors    4/4/17   2016      3                 2
    ## 6 Golden State Warriors  11/19/16   2016      4                 5
    ##   seconds_remaining shot_made_flag                    action_type
    ## 1                51       shot_yes Cutting Finger Roll Layup Shot
    ## 2                14       shot_yes Cutting Finger Roll Layup Shot
    ## 3                 8       shot_yes Cutting Finger Roll Layup Shot
    ## 4                27       shot_yes Cutting Finger Roll Layup Shot
    ## 5                 4       shot_yes Cutting Finger Roll Layup Shot
    ## 6                36       shot_yes Cutting Finger Roll Layup Shot
    ##        shot_type shot_distance               opponent   x  y          name
    ## 1 2PT Field Goal             3        New York Knicks  25 21 Stephen Curry
    ## 2 2PT Field Goal             2   New Orleans Pelicans   9 26 Stephen Curry
    ## 3 2PT Field Goal             2 Portland Trail Blazers -22  2 Stephen Curry
    ## 4 2PT Field Goal             0        Houston Rockets   2  7 Stephen Curry
    ## 5 2PT Field Goal             2 Minnesota Timberwolves   1 26 Stephen Curry
    ## 6 2PT Field Goal             0        Milwaukee Bucks   2  7 Stephen Curry
    ##   minute
    ## 1     33
    ## 2     27
    ## 3     19
    ## 4     31
    ## 5     34
    ## 6     43

### Shot Charts

``` r
knitr::include_graphics("../images/gsw-shot-charts.png")
```

<img src="../images/gsw-shot-charts.png" width="2400" /> These are the shot charts for each of the five players. From these charts, it can be seen that Andre Iguodala attempted the least amount of shots, as opposed to Stephen Curry, who took the most amount of shots during the 2016 NBA season.

### Effective Shooting Percentage

``` r
shots_data <- read.csv("../data/shots-data.csv", header = T, stringsAsFactors = FALSE)

shooting_perc_2pt <- data.frame(arrange(summarise(
  group_by(shots_data, name),
  total_2pt = sum(shot_type == "2PT Field Goal"),
  made = sum(shot_made_flag == "shot_yes" & shot_type == "2PT Field Goal"),
  perc_made = made/total_2pt
), desc = perc_made))

shooting_perc_3pt <- data.frame(arrange(summarise(
  group_by(shots_data, name),
  total_3pt = sum(shot_type == "3PT Field Goal"),
  made = sum(shot_made_flag == "shot_yes" & shot_type == "3PT Field Goal"),
  perc_made = made/total_3pt
), desc = perc_made))

shooting_perc <- data.frame(arrange(summarise(
  group_by(shots_data, name),
  total = length(shot_type),
  made = sum(shot_made_flag == "shot_yes"),
  perc_made = made/total
), desc = perc_made))

shooting_perc_2pt
```

    ##             name total_2pt made perc_made
    ## 1 Draymond Green       346  171 0.4942197
    ## 2  Klay Thompson       640  329 0.5140625
    ## 3  Stephen Curry       563  304 0.5399645
    ## 4   Kevin Durant       643  390 0.6065319
    ## 5 Andre Iguodala       210  134 0.6380952

``` r
shooting_perc_3pt
```

    ##             name total_3pt made perc_made
    ## 1 Draymond Green       232   74 0.3189655
    ## 2 Andre Iguodala       161   58 0.3602484
    ## 3   Kevin Durant       272  105 0.3860294
    ## 4  Stephen Curry       687  280 0.4075691
    ## 5  Klay Thompson       580  246 0.4241379

``` r
shooting_perc
```

    ##             name total made perc_made
    ## 1 Draymond Green   578  245 0.4238754
    ## 2  Stephen Curry  1250  584 0.4672000
    ## 3  Klay Thompson  1220  575 0.4713115
    ## 4 Andre Iguodala   371  192 0.5175202
    ## 5   Kevin Durant   915  495 0.5409836

### Conclusions

Many would think that Stephen Curry had the highest shooting percentage in 2 point and 3 point shots made during the 2016 NBA season. However, by examining the data, it shows that Andre Iguodala actually had the highest 2 point field goal percentage and Klay Thompson had the highest 3 point field goal percentage. Furthermore, Kevin Durant was the most efficient player out of the five, as he had the highest combined shooting percentage. If the shooting percentage were to be ignored, then it is clear that Stephen Curry had the most attempted and made shots out of the five players. Overall, the GSW were a relatively efficient shooting team during the 2016 NBA season.

### References

<https://en.wikipedia.org/wiki/2015%E2%80%9316_Golden_State_Warriors_season>
