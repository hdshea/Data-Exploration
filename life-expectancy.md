---
title: 'Data Sets from Our World In Data'
author: "H. David Shea"
date: "21 May 2021"
output:
  html_document:
    theme: spacelab
    code_folding: hide
    keep_md: true
---



# {.tabset .tabset-fade}

## Data sets

This work references data on life expectancy from the Our World In Data organization.  It reference the specific section of the site [_here_](https://ourworldindata.org/life-expectancy).


```r
life_expectancy_data <- tibble(read.csv("Data/life-expectancy.csv")) %>%
  arrange(Entity, Year)
colnames(life_expectancy_data) <- c("Entity", "Code", "Year", "Expectancy")

men_survival_to_age_65 <- tibble(read.csv("Data/men-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(men_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")

women_survival_to_age_65 <- tibble(read.csv("Data/women-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(women_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")
```

## Plotting functions

The code snippet here shows the plotting designs used in following graphics tabs.


```r
# various plot designs used in the analysis

le_plot_single <- function(data) {
  ggplot(data, aes(Year, Expectancy)) +
    geom_line() +
    labs(
      x = "Year", 
      y = "Life Expectancy",
      title = "Life expectancy",
      subtitle = "1770 to 2019",
      caption = "Source: Our World In Data"
    ) +
    theme_minimal() +
    scale_y_continuous(limits = c(20, 90), breaks = seq(20, 90, by = 10)) + 
    theme(legend.position = "none") +
    scale_colour_brewer(palette = "Dark2")
}

le_plot_multi <- function(data, color_lab) {
  ggplot(data, aes(Year, Expectancy, color = Entity)) +
    geom_line() +
    labs(
      x = "Year", 
      y = "Life Expectancy",
      title = "Life expectancy",
      color = color_lab,
      subtitle = "1770 to 2019",
      caption = "Source: Our World In Data"
    ) +
    theme_minimal() +
    scale_y_continuous(limits = c(20, 90), breaks = seq(20, 90, by = 10)) + 
    theme(legend.position = "bottom") +
    scale_colour_brewer(palette = "Dark2")
}

sr_plot <- function(data, title_lab, color_lab) {
  ggplot(data, aes(Year, Percent, color = Entity)) +
    geom_line() +
    labs(
      title = title_lab,
      color = color_lab
    ) +
    theme_minimal() +
    scale_y_continuous(limits = c(20, 100), breaks = seq(20, 100, by = 10)) +
    scale_colour_brewer(palette = "Dark2")
}
```

## Life Expectancy {.tabset .tabset-fade .tabset-pills}

These graphs show period life expectancy at birth:  the average number of years a newborn would live if the pattern of mortality in the given year were to stay the same throughout its life.

### The World


```r
life_expectancy_data %>%
  filter(Entity == "World") %>%
  le_plot_single()
```

<img src="life-expectancy_files/figure-html/life_expectancy_world-1.png" width="70%" style="display: block; margin: auto;" />

### Regions


```r
sample_list <- c("Oceania", "Europe", "Americas", "Asia", "Africa", "World")

life_expectancy_data %>%
  filter(Entity %in% sample_list) %>%
  le_plot_multi("Region")
```

<img src="life-expectancy_files/figure-html/life_expectancy_regions-1.png" width="70%" style="display: block; margin: auto;" />

### Selected Countries


```r
sample_list <- c("Japan", "South Korea", "United Kingdom", "India", "Ethiopia", "South Africa", "United States", "World")

life_expectancy_data %>%
  filter(Entity %in% sample_list) %>%
  filter(Year >= 1865) %>%
  le_plot_multi("Country")
```

<img src="life-expectancy_files/figure-html/life_expectancy_selected-1.png" width="70%" style="display: block; margin: auto;" />

## Survival Rates {.tabset .tabset-fade .tabset-pills}

These graphs show the share of the population that is expected to survive to the age of 65.

### Selected Geographies


```r
men_survival_to_age_65 <- tibble(read.csv("Data/men-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(men_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")

women_survival_to_age_65 <- tibble(read.csv("Data/women-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(women_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")

sample_list <- c("United States", "China", "Philipines", "United Kingdom", "European Union", "India", "World")

m <- men_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  sr_plot("Males", "Geography")

w <- women_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  sr_plot("Females", "Geography")

m + w + plot_layout(ncol = 2, guides = "collect") + 
  plot_annotation(
    title = "Survival Rates",
    subtitle = "1960 to 2016",
    caption = "Source: Our World In Data"
  )
```

<img src="life-expectancy_files/figure-html/survival_rate_selected-1.png" width="90%" style="display: block; margin: auto;" />

### By Income Distribution Group World-wide


```r
sample_list <- c("High income", "Middle income", "Low income", "World")

m <- men_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  sr_plot("Males", "Group")

w <- women_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  sr_plot("Females", "Group")

m + w + plot_layout(ncol = 2, guides = "collect") + 
  plot_annotation(
    title = "Survival Rates",
    subtitle = "1960 to 2016",
    caption = "Source: Our World In Data"
  )
```

<img src="life-expectancy_files/figure-html/survival_rate_income-1.png" width="90%" style="display: block; margin: auto;" />
