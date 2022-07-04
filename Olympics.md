---
title: "Olympics"
author: "Giang"
date: "2022-066-02"
output: 
  html_document:
    keep_md: true
---


```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
## ✔ tibble  3.1.7     ✔ dplyr   1.0.9
## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
## ✔ readr   2.1.2     ✔ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```
## 
## Attaching package: 'gridExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     combine
```

```
## 
## Attaching package: 'kableExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     group_rows
```

```
## 
## Attaching package: 'mice'
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```
## The following objects are masked from 'package:base':
## 
##     cbind, rbind
```

```
## 
## Attaching package: 'maps'
```

```
## The following object is masked from 'package:purrr':
## 
##     map
```

```
## 
## Attaching package: 'cluster'
```

```
## The following object is masked from 'package:maps':
## 
##     votes.repub
```

```
## Welcome! Want to learn more? See two factoextra-related books at https://goo.gl/ve3WBa
```


```r
# input datasets
dat <- read.csv("D:/R/athlete_events.csv")
region <- read.csv("D:/R/noc_regions.csv")
continent <- read.csv("D:/R/region.csv")
paged_table(head(dat, n=15))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["ID"],"name":[1],"type":["int"],"align":["right"]},{"label":["Name"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Sex"],"name":[3],"type":["chr"],"align":["left"]},{"label":["Age"],"name":[4],"type":["int"],"align":["right"]},{"label":["Height"],"name":[5],"type":["int"],"align":["right"]},{"label":["Weight"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["Team"],"name":[7],"type":["chr"],"align":["left"]},{"label":["NOC"],"name":[8],"type":["chr"],"align":["left"]},{"label":["Games"],"name":[9],"type":["chr"],"align":["left"]},{"label":["Year"],"name":[10],"type":["int"],"align":["right"]},{"label":["Season"],"name":[11],"type":["chr"],"align":["left"]},{"label":["City"],"name":[12],"type":["chr"],"align":["left"]},{"label":["Sport"],"name":[13],"type":["chr"],"align":["left"]},{"label":["Event"],"name":[14],"type":["chr"],"align":["left"]},{"label":["Medal"],"name":[15],"type":["chr"],"align":["left"]}],"data":[{"1":"1","2":"A Dijiang","3":"M","4":"24","5":"180","6":"80","7":"China","8":"CHN","9":"1992 Summer","10":"1992","11":"Summer","12":"Barcelona","13":"Basketball","14":"Basketball Men's Basketball","15":"NA","_rn_":"1"},{"1":"2","2":"A Lamusi","3":"M","4":"23","5":"170","6":"60","7":"China","8":"CHN","9":"2012 Summer","10":"2012","11":"Summer","12":"London","13":"Judo","14":"Judo Men's Extra-Lightweight","15":"NA","_rn_":"2"},{"1":"3","2":"Gunnar Nielsen Aaby","3":"M","4":"24","5":"NA","6":"NA","7":"Denmark","8":"DEN","9":"1920 Summer","10":"1920","11":"Summer","12":"Antwerpen","13":"Football","14":"Football Men's Football","15":"NA","_rn_":"3"},{"1":"4","2":"Edgar Lindenau Aabye","3":"M","4":"34","5":"NA","6":"NA","7":"Denmark/Sweden","8":"DEN","9":"1900 Summer","10":"1900","11":"Summer","12":"Paris","13":"Tug-Of-War","14":"Tug-Of-War Men's Tug-Of-War","15":"Gold","_rn_":"4"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"21","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1988 Winter","10":"1988","11":"Winter","12":"Calgary","13":"Speed Skating","14":"Speed Skating Women's 500 metres","15":"NA","_rn_":"5"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"21","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1988 Winter","10":"1988","11":"Winter","12":"Calgary","13":"Speed Skating","14":"Speed Skating Women's 1,000 metres","15":"NA","_rn_":"6"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"25","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Speed Skating","14":"Speed Skating Women's 500 metres","15":"NA","_rn_":"7"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"25","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Speed Skating","14":"Speed Skating Women's 1,000 metres","15":"NA","_rn_":"8"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"27","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1994 Winter","10":"1994","11":"Winter","12":"Lillehammer","13":"Speed Skating","14":"Speed Skating Women's 500 metres","15":"NA","_rn_":"9"},{"1":"5","2":"Christine Jacoba Aaftink","3":"F","4":"27","5":"185","6":"82","7":"Netherlands","8":"NED","9":"1994 Winter","10":"1994","11":"Winter","12":"Lillehammer","13":"Speed Skating","14":"Speed Skating Women's 1,000 metres","15":"NA","_rn_":"10"},{"1":"6","2":"Per Knut Aaland","3":"M","4":"31","5":"188","6":"75","7":"United States","8":"USA","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Cross Country Skiing","14":"Cross Country Skiing Men's 10 kilometres","15":"NA","_rn_":"11"},{"1":"6","2":"Per Knut Aaland","3":"M","4":"31","5":"188","6":"75","7":"United States","8":"USA","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Cross Country Skiing","14":"Cross Country Skiing Men's 50 kilometres","15":"NA","_rn_":"12"},{"1":"6","2":"Per Knut Aaland","3":"M","4":"31","5":"188","6":"75","7":"United States","8":"USA","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Cross Country Skiing","14":"Cross Country Skiing Men's 10/15 kilometres Pursuit","15":"NA","_rn_":"13"},{"1":"6","2":"Per Knut Aaland","3":"M","4":"31","5":"188","6":"75","7":"United States","8":"USA","9":"1992 Winter","10":"1992","11":"Winter","12":"Albertville","13":"Cross Country Skiing","14":"Cross Country Skiing Men's 4 x 10 kilometres Relay","15":"NA","_rn_":"14"},{"1":"6","2":"Per Knut Aaland","3":"M","4":"33","5":"188","6":"75","7":"United States","8":"USA","9":"1994 Winter","10":"1994","11":"Winter","12":"Lillehammer","13":"Cross Country Skiing","14":"Cross Country Skiing Men's 10 kilometres","15":"NA","_rn_":"15"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


```r
# check missing data
gg_miss_var(dat)
```

```
## Warning: It is deprecated to specify `guide = FALSE` to remove a guide. Please
## use `guide = "none"` instead.
```

![](README_figs/README-unnamed-chunk-3-1.png)<!-- -->


```r
# The number of sports in each year and season
dat %>% 
  distinct(Year, Season, Sport) %>% # keep unique values
  group_by(Year, Season) %>% 
  summarise(count = n()) %>% 
  ggplot()+
  aes(x = Year, y = count, fill = Season) +
  geom_col() +
  facet_grid(Season ~.) +
  theme_bw()+
  annotate("rect", xmin = 1914, xmax = 1918, ymin = 0, ymax = 35, alpha = 0.2)+
  annotate("rect", xmin = 1939, xmax = 1945, ymin = 0, ymax = 35, alpha = 0.2)+
  annotate("text", x = 1942, y = 20, label = "WWII")+
  annotate("text", x = 1916, y = 20, label = "WWI") +
  scale_x_continuous(breaks = seq(1896, 2016, 8)) +
  labs(title = "The number of sports in each year and season",
       x = "Year", y = "Number")+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.title.y = element_text(margin = margin(r = 15)),
        axis.title.x = element_text(margin = margin(t = 15)),
        plot.title = element_text(face = "bold", hjust = 0.5, 
                                  margin = margin(b = 20), size=15))
```

```
## `summarise()` has grouped output by 'Year'. You can override using the
## `.groups` argument.
```

![](README_figs/README-unnamed-chunk-4-1.png)<!-- -->


```r
# Top 15 common sports
dat %>% 
  distinct(Year, Sport) %>% 
  group_by(Sport) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count)) %>% 
  mutate(top5 = case_when(row_number() <= 5 ~ T, T ~ F)) %>% 
  slice(1:15) %>%  
  ggplot() +
  aes(x = reorder(Sport, count), y = count, fill = top5) +
  geom_col(show.legend = F) + # Do not show note
  scale_fill_manual(values = c("gray", "blue")) +
  coord_flip() +
  labs(title = "Number of year",
    x = "Sport", y = "Number") + 
  theme_bw(base_size = 9) +
  theme(axis.title.x = element_text(size = 12, margin = margin(t = 10)), 
    axis.title.y = element_text(size = 12, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), face = "bold", 
                              hjust = 0.5, size = 11))
```

![](README_figs/README-unnamed-chunk-5-1.png)<!-- -->


```r
# Corelation between the number of sports and that of events
count_year <- dat %>% 
  distinct(Year, Sport) %>% 
  group_by(Sport) %>% 
  summarise(count_year = n())

count_event <- dat %>% 
  filter(Year == 2016) %>%
  distinct(Sport, Event) %>% 
  group_by(Sport) %>% 
  summarise(count_event = n())

count_year %>% 
  left_join(count_event, by = "Sport") %>% 
  drop_na() %>% 
  ggplot() + 
  aes(x = (count_year), y = (count_event)) + 
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm") + 
  theme_bw() + 
  labs(title = "Corelation", 
    x = "Sport",
    y = "Event") + 
  theme(axis.title.x = element_text(size = 10, margin = margin(t = 10)), 
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), face = "bold", 
                              hjust = 0.5, size = 12))
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](README_figs/README-unnamed-chunk-6-1.png)<!-- -->


```r
# Countries with the highest number of athletes (Winter Olympics)
dat %>% 
  select(NOC, Year, ID) %>% 
  group_by(NOC, Year) %>% 
  summarise(count = n()) %>% 
  group_by(NOC) %>% 
  summarise(mean_athl = sum(count)/n(), count_year = n())  %>% 
  filter(count_year > 10) %>% 
  left_join(region, by = "NOC") %>% 
  arrange(desc(mean_athl)) %>% 
  slice(1:9) %>% 
  ggplot() +
  aes(x = reorder(region, mean_athl), y = mean_athl) +
  geom_col(fill = "#124B92") +
  coord_flip() +
  theme_bw() +
  labs(title = "Coutries with the highest number of athletes", 
       y = "Mean",
       x = "Country") +
  theme(axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 12))
```

```
## `summarise()` has grouped output by 'NOC'. You can override using the `.groups`
## argument.
```

![](README_figs/README-unnamed-chunk-7-1.png)<!-- -->


```r
# Gender equality at Summer Olympics
dat %>% 
  filter(Season == "Summer") %>% 
  group_by(Year, Sex) %>%
  summarise(count = n()) %>% 
  spread(Sex, count) %>% 
  mutate(sum = `F` + `M`) %>% 
  mutate(Year = as.factor(Year)) %>% 
  ggplot() +
  geom_col(aes(x = reorder(Year, Year), y = sum), col = "azure4") +  
  geom_col(aes(x = Year, y = sum/2), col = "azure4") +
  geom_col(aes(x = Year, y = `F`), fill = "burlywood1", width = 0.5)+
  geom_text(aes(x = Year, y = `F` + 500, label = paste(round(`F` / sum * 100, 0), "%")), size = 3, color = "dark orange")+
  scale_x_discrete(limits=rev)+
  coord_flip() +
  theme_bw(base_size = 10)+
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 12)) + 
  labs(title = "The percentage of female",
    x = "Year",
    y= "Percentage of female")
```

```
## `summarise()` has grouped output by 'Year'. You can override using the
## `.groups` argument.
```

```
## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning: Removed 1 rows containing missing values (position_stack).
## Removed 1 rows containing missing values (position_stack).
## Removed 1 rows containing missing values (position_stack).
```

```
## Warning: Removed 1 rows containing missing values (geom_text).
```

![](README_figs/README-unnamed-chunk-8-1.png)<!-- -->


```r
# Total medals won by each country (from 1990 to 2016)
dat %>% 
  filter(Year > 1990, Season == "Summer") %>% 
  select(NOC, Medal) %>% 
  drop_na() %>% 
  count(NOC) %>% 
  left_join(region[, 1:2], by = "NOC") %>% 
  drop_na() %>% 
  right_join(map_data("world"), by = c("region")) %>% 
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(aes(fill = n), color = "black", size = 0.2)+
  scale_fill_gradient(low = "white", high="yellow",   guide = "colourbar")  +
  theme_bw() + 
  labs(
    x = "",
    y = "",
    title = "Total medals won by each country (from 1990 to 2016)"
  ) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 12))+  
  guides(fill = guide_colorbar(title = "Total medals"))
```

![](README_figs/README-unnamed-chunk-9-1.png)<!-- -->


```r
# Cluster
dat.cluster <- dat %>% 
  filter(Season == "Summer", Year == 2016)
```


```r
# Check outliers
height_boxplot <- dat.cluster %>% 
  ggplot() +
  geom_boxplot(aes(Height)) +
  coord_flip() +
  xlab("Height") +
  theme_bw(base_size = 9)

weight_boxplot <- dat.cluster %>% 
  ggplot() + 
  geom_boxplot(aes(Weight)) + 
  coord_flip() + 
  xlab("Weight") + 
  theme_bw(base_size = 9)

grid.arrange(height_boxplot, weight_boxplot, ncol = 2, 
             top = textGrob("Boxlot (2016)",
                            gp=gpar(fontsize=12,font=2)))
```

```
## Warning: Removed 176 rows containing non-finite values (stat_boxplot).
```

```
## Warning: Removed 223 rows containing non-finite values (stat_boxplot).
```

![](README_figs/README-unnamed-chunk-11-1.png)<!-- -->

```r
  theme(axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 12))
```

```
## List of 3
##  $ axis.title.x:List of 11
##   ..$ family       : NULL
##   ..$ face         : NULL
##   ..$ colour       : NULL
##   ..$ size         : num 10
##   ..$ hjust        : NULL
##   ..$ vjust        : NULL
##   ..$ angle        : NULL
##   ..$ lineheight   : NULL
##   ..$ margin       : 'margin' num [1:4] 10points 0points 0points 0points
##   .. ..- attr(*, "unit")= int 8
##   ..$ debug        : NULL
##   ..$ inherit.blank: logi FALSE
##   ..- attr(*, "class")= chr [1:2] "element_text" "element"
##  $ axis.title.y:List of 11
##   ..$ family       : NULL
##   ..$ face         : NULL
##   ..$ colour       : NULL
##   ..$ size         : num 10
##   ..$ hjust        : NULL
##   ..$ vjust        : NULL
##   ..$ angle        : NULL
##   ..$ lineheight   : NULL
##   ..$ margin       : 'margin' num [1:4] 0points 10points 0points 0points
##   .. ..- attr(*, "unit")= int 8
##   ..$ debug        : NULL
##   ..$ inherit.blank: logi FALSE
##   ..- attr(*, "class")= chr [1:2] "element_text" "element"
##  $ plot.title  :List of 11
##   ..$ family       : NULL
##   ..$ face         : chr "bold"
##   ..$ colour       : NULL
##   ..$ size         : num 12
##   ..$ hjust        : num 0.5
##   ..$ vjust        : NULL
##   ..$ angle        : NULL
##   ..$ lineheight   : NULL
##   ..$ margin       : 'margin' num [1:4] 0points 0points 10points 0points
##   .. ..- attr(*, "unit")= int 8
##   ..$ debug        : NULL
##   ..$ inherit.blank: logi FALSE
##   ..- attr(*, "class")= chr [1:2] "element_text" "element"
##  - attr(*, "class")= chr [1:2] "theme" "gg"
##  - attr(*, "complete")= logi FALSE
##  - attr(*, "validate")= logi TRUE
```


```r
# Replace outliers by marginal values
weight_q3 <- as.numeric(quantile(dat.cluster$Weight, 0.75, na.rm = T))
weight_q1 <- as.numeric(quantile(dat.cluster$Weight, 0.25, na.rm = T))
weight_iqr <- IQR(dat.cluster$Weight, na.rm = T)

height_q3 <- as.numeric(quantile(dat.cluster$Height, 0.75, na.rm = T))
height_q1 <- as.numeric(quantile(dat.cluster$Height, 0.25, na.rm = T))
height_iqr <- IQR(dat.cluster$Height, na.rm = T)

dat.cluster[!is.na(dat.cluster$Weight) & dat.cluster$Weight >  weight_q3 + 1.5*weight_iqr,
  "Weight"] <- quantile(dat.cluster$Weight, 0.95, na.rm = T)

dat.cluster[!is.na(dat.cluster$Weight) & dat.cluster$Weight < weight_q1 - 1.5*weight_iqr, 
  "Weight"] <- quantile(dat.cluster$Weight, 0.05, na.rm = T)

dat.cluster[!is.na(dat.cluster$Height) & dat.cluster$Height > height_q3 + 1.5*height_iqr, 
  "Height"] <- quantile(dat.cluster$Height, 0.95, na.rm = T)

dat.cluster[!is.na(dat.cluster$Height) & dat.cluster$Height < height_q1 - 1.5*height_iqr, 
  "Height"] <- quantile(dat.cluster$Height, 0.05, na.rm = T)

rm(list = c("weight_q3", "weight_q1", "weight_iqr", "height_q3", "height_q1", "height_iqr"))

height_boxplot <- dat.cluster %>% 
  ggplot() +
  geom_boxplot(aes(Height)) +
  coord_flip() +
  xlab("Height") +
  theme_bw(base_size = 9)

weight_boxplot <- dat.cluster %>% 
  ggplot() + 
  geom_boxplot(aes(Weight)) + 
  coord_flip() + 
  xlab("Weight") + 
  theme_bw(base_size = 9)

grid.arrange(height_boxplot, weight_boxplot, ncol = 2, 
             top = textGrob("Boxlot (2016)", gp=gpar(fontsize=12,font=2)))
```

```
## Warning: Removed 176 rows containing non-finite values (stat_boxplot).
```

```
## Warning: Removed 223 rows containing non-finite values (stat_boxplot).
```

![](README_figs/README-unnamed-chunk-12-1.png)<!-- -->

```r
rm(list = c("height_boxplot", "weight_boxplot"))
```


```r
# Missing values
dat.cluster %>% 
  select(-Medal) %>% # some countries did not win any medal
  gg_miss_var()
```

```
## Warning: It is deprecated to specify `guide = FALSE` to remove a guide. Please
## use `guide = "none"` instead.
```

![](README_figs/README-unnamed-chunk-13-1.png)<!-- -->


```r
# Corelation between weight and height
dat.cluster %>% 
  select(Weight, Height) %>% 
  drop_na() %>% 
  ggplot(aes(x = Height, y = Weight)) +
  geom_point(col = "#777777") +
  geom_smooth(method = "lm")+
  theme_bw() +
  labs(title = "Corelation between height and weight") +
  theme_bw() + 
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)), 
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 15), face = "bold", hjust = 0.5, size = 11)) 
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](README_figs/README-unnamed-chunk-14-1.png)<!-- -->


```r
# Replace missing values
dat.cluster[, "Height"] <- dat.cluster %>% 
  select(-Medal, -Weight) %>% 
  mice(method = "cart", m = 2) %>% # decision tree
  complete() %>% 
  .$Height
```

```
## 
##  iter imp variable
##   1   1  Height
##   1   2  Height
##   2   1  Height
##   2   2  Height
##   3   1  Height
##   3   2  Height
##   4   1  Height
##   4   2  Height
##   5   1  Height
##   5   2  Height
```

```
## Warning: Number of logged events: 10
```

```r
dat.cluster[, "Weight"] <- dat.cluster %>% 
  select(Weight, Height) %>% 
  mice(method = "norm.nob") %>% # random regression
  complete() %>% 
  .$Weight
```

```
## 
##  iter imp variable
##   1   1  Weight
##   1   2  Weight
##   1   3  Weight
##   1   4  Weight
##   1   5  Weight
##   2   1  Weight
##   2   2  Weight
##   2   3  Weight
##   2   4  Weight
##   2   5  Weight
##   3   1  Weight
##   3   2  Weight
##   3   3  Weight
##   3   4  Weight
##   3   5  Weight
##   4   1  Weight
##   4   2  Weight
##   4   3  Weight
##   4   4  Weight
##   4   5  Weight
##   5   1  Weight
##   5   2  Weight
##   5   3  Weight
##   5   4  Weight
##   5   5  Weight
```


```r
# Review corelation
dat.cluster %>% 
  select(Weight, Height) %>% 
  ggplot(aes(x = Height, y = Weight)) +
  geom_point(col = "#777777") +
  geom_smooth(method = "lm") +
  theme_bw() +
  labs(title = "Corelation between height and weight") +
  theme_bw() + 
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)), 
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 15), 
                              face = "bold", hjust = 0.5, size = 11))
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](README_figs/README-unnamed-chunk-16-1.png)<!-- -->


```r
# Use K mediods method to cluster (too many outliers)
#1. Silhouete
dat.cluster %>%
  select(Height, Weight) %>% 
  fviz_nbclust(clara, method = "silhouette") +
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    # axis.text.y = element_blank(),
    plot.title = element_text(margin = margin(b = 10), 
                              face = "bold", hjust = 0.5, size = 12))
```

![](README_figs/README-unnamed-chunk-17-1.png)<!-- -->


```r
#2. Elbow
dat.cluster %>%
select(Height, Weight) %>% 
  sample_frac(0.1) %>% 
  fviz_nbclust(clara, method = "wss") + 
  geom_vline(xintercept = 3, linetype = "dashed", col = "dark gray") +
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    axis.text.y = element_blank(),
    plot.title = element_text(margin = margin(b = 10), 
                              face = "bold", hjust = 0.5, size = 12))
```

![](README_figs/README-unnamed-chunk-18-1.png)<!-- -->
