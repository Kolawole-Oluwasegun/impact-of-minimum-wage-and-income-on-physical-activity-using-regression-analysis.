library(dplyr)
install.packages("kableExtra")
library(kableExtra)
install.packages("stargazer")
library(stargazer)
install.packages("officer")
library(officer)
install.packages("broom")
library(broom)
install.packages("ggplot2")
library(ggplot2)
install.packages("psych")
library(psych)
install.packages("knitr")
library(knitr)
install.packages("flextable")
library(flextable)
install.packages("lmtest")
library(lmtest)
install.packages("sandwich")
library(sandwich)
DATA1 <- read.csv("/Users/HP/Downloads/PHYSICAL.csv")

# Calculate summary statistics
summary_stats <- DATA1 %>%
  summarise(
    mean_exer = mean(exer, na.rm = TRUE),
    sd_exer = sd(exer, na.rm = TRUE),
    min_exer = min(exer, na.rm = TRUE),
    max_exer = max(exer, na.rm = TRUE),
    
    mean_income = mean(income, na.rm = TRUE),
    sd_income = sd(income, na.rm = TRUE),
    min_income = min(income, na.rm = TRUE),
    max_income = max(income, na.rm = TRUE),
    
    mean_employed = mean(employed, na.rm = TRUE),
    sd_employed = sd(employed, na.rm = TRUE),
    min_employed = min(employed, na.rm = TRUE),
    max_employed = max(employed, na.rm = TRUE),
    
    mean_age = mean(age, na.rm = TRUE),
    sd_age = sd(age, na.rm = TRUE),
    min_age = min(age, na.rm = TRUE),
    max_age = max(age, na.rm = TRUE),
    
    mean_genhlth = mean(genhlth, na.rm = TRUE),
    sd_genhlth = sd(genhlth, na.rm = TRUE),
    min_genhlth = min(genhlth, na.rm = TRUE),
    max_genhlth = max(genhlth, na.rm = TRUE),
    
    mean_physhlth = mean(physhlth, na.rm = TRUE),
    sd_physhlth = sd(physhlth, na.rm = TRUE),
    min_physhlth = min(physhlth, na.rm = TRUE),
    max_physhlth = max(physhlth, na.rm = TRUE),
    
    mean_menthlth = mean(menthlth, na.rm = TRUE),
    sd_menthlth = sd(menthlth, na.rm = TRUE),
    min_menthlth = min(menthlth, na.rm = TRUE),
    max_menthlth = max(menthlth, na.rm = TRUE)
  )

# Convert to a long format table
formatted_stats <- tibble::tibble(
  variable = c("Exercise", "Income", "Employed", "Age", "General Health", "Physical Health", "Mental Health"),
  mean = c(summary_stats$mean_exer, summary_stats$mean_income, summary_stats$mean_employed, 
           summary_stats$mean_age, summary_stats$mean_genhlth, summary_stats$mean_physhlth, 
           summary_stats$mean_menthlth),
  sd = c(summary_stats$sd_exer, summary_stats$sd_income, summary_stats$sd_employed, 
         summary_stats$sd_age, summary_stats$sd_genhlth, summary_stats$sd_physhlth, 
         summary_stats$sd_menthlth),
  min = c(summary_stats$min_exer, summary_stats$min_income, summary_stats$min_employed, 
          summary_stats$min_age, summary_stats$min_genhlth, summary_stats$min_physhlth, 
          summary_stats$min_menthlth),
  max = c(summary_stats$max_exer, summary_stats$max_income, summary_stats$max_employed, 
          summary_stats$max_age, summary_stats$max_genhlth, summary_stats$max_physhlth, 
          summary_stats$max_menthlth)
)

# Print the table in a formatted style
kable(formatted_stats, caption = "Summary Statistics", col.names = c("Variable", "Mean", "SD", "Min", "Max"))

# Create a flextable
ft <- flextable(formatted_stats) %>%
  set_caption(caption = "Summary Statistics") %>%
  autofit()

# Save the table to a Word document
doc <- read_docx()
doc <- body_add_flextable(doc, value = ft)
print(doc, target = "Summary_Statistics.docx")


# Histogram for income
ggplot(DATA1, aes(x = income)) +
  geom_histogram(binwidth = 5000, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Income", x = "Income", y = "Frequency")

# Histogram for age
ggplot(DATA1, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "green", color = "black") +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency")

# Bar plot for exercise
ggplot(DATA1, aes(x = factor(exer))) +
  geom_bar(fill = "orange", color = "black") +
  labs(title = "Participation in Physical Activity", x = "Exercise (1 = Yes, 0 = No)", y = "Count")

# Bar plot for employment
ggplot(DATA1, aes(x = factor(employed))) +
  geom_bar(fill = "purple", color = "black") +
  labs(title = "Employment Status", x = "Employed (1 = Yes, 0 = No)", y = "Count")

#Robustness Check analysis
# Subset data for individuals under 50
subset_young <- subset(DATA1, age < 50)

# Subset data for individuals 50 and above
subset_old <- subset(DATA1, age >= 50)

# Fit models for both subsets
model_young <- lm(exer ~ income + employed, data = subset_young)
model_old <- lm(exer ~ income + employed, data = subset_old)

# Summarize results for comparison
summary(model_young)
summary(model_old)


# Perform the OLS regression
ols_model <- lm(exer ~ income + employed + age + genhlth + physhlth + menthlth, data = DATA1)

# Summary of the regression model
summary(ols_model)

# Calculate robust standard errors
robust_se <- coeftest(ols_model, vcov = vcovHC(ols_model, type = "HC1"))

# Display regression coefficients with robust standard errors
print(robust_se)



# Model 1: Income and physical activity
model1 <- lm(exer ~ income, data = DATA1)

# Summary of Model 1
summary(model1)


# Model 2: Income, employment, and physical activity
model2 <- lm(exer ~ income + employed, data = DATA1)

# Summary of Model 2
summary(model2)

# Model 3: Income, employment, age, and physical activity
model3 <- lm(exer ~ income + employed + age, data = DATA1)

# Summary of Model 3
summary(model3)


# Model 4: Full model with health and demographic controls
model4 <- lm(exer ~ income + employed + age + genhlth + physhlth + menthlth, data = DATA1)

# Summary of Model 4
summary(model4)



stargazer(model1, model2, model3, model4, 
          type = "html", 
          title = "Regression Results", 
          dep.var.labels = "Physical Activity Participation",
          covariate.labels = c("Income", "Employment", "Age", "General Health", "Physical Health", "Mental Health"),
          out = "model_results.doc")  # Save output as a Word-compatible file

