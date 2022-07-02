# used packages

library(knitr) # tạo bảng
library(tidyverse) # gói bao gồm dplyr, tidyr, ggplot
library(grid) # đồ thị có ô lưới
library(gridExtra) # vẽ nhiều đồ thị cùng lúc
library(kableExtra)# tạo bảng
library(rmarkdown) # paged_table
library(naniar) # xử lý missing values
library(mice) # xử lý missing values
library(reshape2) # chuyển data thành các dạng khác nhau (cột/hàng)
library(maps) # vẽ dạng bản đồ
library(gganimate) # vẽ đồ thị động
library(countrycode) # đọc code của các quốc gia
library(cluster) # phân cụm K medoids
library(factoextra) # vẽ hình

# input datasets
dat <- read.csv("D:/R/athlete_events.csv")
region <- read.csv("D:/R/noc_regions.csv")
continent <- read.csv("D:/R/region.csv")
paged_table(head(dat, n=15))

  # check missing data
gg_miss_var(dat)

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
        plot.title = element_text(face = "bold", hjust = 0.5, margin = margin(b = 20), size=15))

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
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 11))

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
    plot.title = element_text(margin = margin(b = 10), face = "bold", hjust = 0.5, size = 12))

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

dat.cluster <- dat %>% 
  filter(Season == "Summer", Year == 2016)

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
             top = textGrob("Boxlot chiều cao và cân nặng vận động viên năm 2016",
                            gp=gpar(fontsize=12,font=2)))

rm(list = c("height_boxplot", "weight_boxplot"))

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
             top = textGrob("Boxlot chiều cao và cân nặng vận động viên năm 2016",
                                                                      gp=gpar(fontsize=12,font=2)))
rm(list = c("height_boxplot", "weight_boxplot"))

# Missing values
dat.cluster %>% 
  select(-Medal) %>% # some countries did not win any medal
  gg_miss_var()

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

dat.cluster[, "Height"] <- dat.cluster %>% 
  select(-Medal, -Weight) %>% 
  mice(method = "cart", m = 2) %>% # decision tree
  complete() %>% 
  .$Height

dat.cluster[, "Weight"] <- dat.cluster %>% 
  select(Weight, Height) %>% 
  mice(method = "norm.nob") %>% # random regression
  complete() %>% 
  .$Weight

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
    plot.title = element_text(margin = margin(b = 15), face = "bold", hjust = 0.5, size = 11))

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

#3. Clara
res.clus <- dat.cluster %>% 
  select(Height, Weight) %>% 
  clara(k = 3, stand = T, sampsize = 2000)

row.names(res.clus$medoids) <- c("Cluster 1", "Cluster 2", "Cluster 3")
res.clus$medoids[, 2] <- round(res.clus$medoids[, 2], 3)
res.clus$medoids %>% 
  kbl() %>% 
  kable_styling(bootstrap_options = "striped")
res.clus$medoids

dat.cluster <- dat.cluster %>% mutate(
  cluster = factor(res.clus$clustering, levels = c(1, 2, 3)))

dat.cluster %>% 
  ggplot(aes(Height, Weight, col = cluster)) +
  geom_point(show.legend = T)+
  guides(col = guide_legend(title = "Cụm"))+ 
  theme_bw() +
  labs(title = "Đồ thị phân cụm") + 
  theme(
    axis.title.x = element_text(size = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 10, margin = margin(r = 10)),
    plot.title = element_text(margin = margin(b = 10), 
                              face = "bold", hjust = 0.5, size = 12))