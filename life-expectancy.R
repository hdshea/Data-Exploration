library(tidyverse)

# This script references data on life expectancy for the Our World In Data organization.
# Reference the specific site at https://ourworldindata.org/life-expectancy

# Life Expectancy

life_expectancy_data <- tibble(read.csv("Data/life-expectancy.csv")) %>%
  arrange(Entity, Year)
colnames(life_expectancy_data) <- c("Entity", "Code", "Year", "Expectancy")

life_expectancy_data %>%
  filter(Entity == "World") %>%
  ggplot(aes(Year, Expectancy)) +
  geom_line() +
  labs(
    x = "Year", y = "Life Expectancy",
    title = "Life expectancy, 1770 to 2019",
    subtitle = "The World",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 90), breaks = seq(20, 90, by = 10))

sample_list <- c("Oceania", "Europe", "Americas", "Asia", "Africa", "World")

life_expectancy_data %>%
  filter(Entity %in% sample_list) %>%
  ggplot(aes(Year, Expectancy, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Life Expectancy",
    title = "Life expectancy, 1865 to 2019",
    subtitle = "Regions",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 90), breaks = seq(20, 90, by = 10))

sample_list <- c("Japan", "South Korea", "United Kingdom", "India", "Ethiopia", "South Africa", "United States", "World")

life_expectancy_data %>%
  filter(Entity %in% sample_list) %>%
  filter(Year >= 1865) %>%
  ggplot(aes(Year, Expectancy, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Life Expectancy",
    title = "Life expectancy, 1865 to 2019",
    subtitle = "Selected Countries",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 90), breaks = seq(20, 90, by = 10))

men_survival_to_age_65 <- tibble(read.csv("Data/men-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(men_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")

women_survival_to_age_65 <- tibble(read.csv("Data/women-survival-to-age-65.csv")) %>%
  arrange(Entity, Year)
colnames(women_survival_to_age_65) <- c("Entity", "Code", "Year", "Percent")

sample_list <- c("United States", "China", "Philipines", "United Kingdom", "European Union", "India", "World")

men_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  ggplot(aes(Year, Percent, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Share of Population",
    title = "Male Survival Rate, 1960 to 2016",
    subtitle = "Selected Countries",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 100), breaks = seq(20, 100, by = 10))

women_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  ggplot(aes(Year, Percent, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Share of Population",
    title = "Female Survival Rate, 1960 to 2016",
    subtitle = "Selected Countries",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 100), breaks = seq(20, 100, by = 10))

sample_list <- c("High income", "Middle income", "Low income", "World")

men_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  ggplot(aes(Year, Percent, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Share of Population",
    title = "Male Survival Rate, 1960 to 2016",
    subtitle = "By Income Distribution Group",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 100), breaks = seq(20, 100, by = 10))

women_survival_to_age_65 %>%
  filter(Entity %in% sample_list) %>%
  ggplot(aes(Year, Percent, color = Entity)) +
  geom_line() +
  labs(
    x = "Year", y = "Share of Population",
    title = "Female Survival Rate, 1960 to 2016",
    subtitle = "By Income Distribution Group",
    caption = "Source: Our World In Data"
  ) +
  scale_y_continuous(limits = c(20, 100), breaks = seq(20, 100, by = 10))
