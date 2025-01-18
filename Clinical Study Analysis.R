#Setting up the Working Directory
#Better to keep DATASET and R Code file together in a folder

#setwd("E:/Client Work/Gardashil Project 2")
setwd("D:/Personal. R")

# Loading the necessary packages
library(readxl)
install.packages('readxl')
library(dplyr)
library(tidyr)
library(ggplot2)
install.packages("kableExtra")
library(kableExtra)
install.packages("knitr")
library(knitr)
library(gtsummary)
library(ggstatsplot)
library(gt)
install.packages("glmtoolbox")
library(labelled)
library(flextable)
library(glmtoolbox)

# Read the data from the Excel file
data <- readxl::read_xls("Gardasil-Data.xls")

#Display the Structure & Snapshot of the Dataset
str(data)
glimpse(data)

#A glimpse of the dataset
head(data, 10)

#Adding labels to the categories of predictor variables
data$Race <- factor(data$Race, levels = c(0, 1, 2, 3),
                    labels = c("White", "Black", "Hispanic", "Other/Unknown"))

data$InsuranceType <- factor(data$InsuranceType, levels = c(0, 1, 2, 3),
                             labels = c("Medical Assistance", "Private Payer", "Hospital-based", "Military"))

data$PracticeType <- factor(data$PracticeType, levels = c(0, 1, 2),
                            labels = c("Pediatric", "Family Practice", "OB-GYN"))

data$MedAssist <- factor(data$MedAssist, levels = c(0,1),
                         labels = c("No", "Yes"))


#Re-coding the "Location" Variable into "suburban" and "urban" categories
data$LocationType <- ifelse(data$Location %in% c(1,2), 0, 1)

#Adding New Labels to the Categories
data$LocationType <- factor(data$LocationType, levels = c(0,1),
                        labels = c("Suburban", "Urban"))

data$Location <- factor(data$Location, levels = c(1, 2, 3, 4),
                        labels = c("Odenton", "White Marsh", "Johns Hopkins Outpatient Center", "Bayview"))

table(data$Location)
table(data$LocationType)
table(data$LocationType, data$Location)

median_age <- median(data$Age)
median_age #18

# Create a new variable based on whether the age is above or below the median
data$AgeGroup <- ifelse(data$Age < 18, 0, 1)
data$AgeGroup <- factor(data$AgeGroup, levels = c(0,1),
                         labels = c("Minor", "Adult"))


data$Completed <- factor(data$Completed, levels = c(0,1),
                         labels = c("No", "Yes"))

table(data$Completed) #no = 942, yes = 469

table(data$Shots, data$Completed) #It can be observed that 3 shots have been completed, yet falls under the completion = "yes" category

438+436+68 #no = 942 & yes = 469 
942+469 #In the data structure we saw that total number of records were 1413; Here, it's 1411

#Checking the Number of Missing value in Each Column
colSums(is.na(data)) #Two missing values in the "Completed" column

data %>% 
  filter(is.na(Completed)== TRUE) %>% View() #Two records have "NA" values in Completed variable;
                                            #However, the corresponding Shots variable shows that the patients (217, 1264) took only 1 shots
                                            #Hence, these should be Completed == "no" i.e. imcomplete shots

#Replace those NA values with Completed == 0 [Completed = "no"]

data$Completed = data$Completed %>% replace_na("No")

colSums(is.na(data)) #No missing values in the "Completed" column anymore

table(data$Completed)
table(data$Shots, data$Completed)

data$completed_2dose <- ifelse(data$Shots>= 2, "Yes", "No")
table(data$completed_2dose)
#No: 440; Yes: 973

summary(data)

table(data$InsuranceType)
table(data$MedAssist, data$InsuranceType)


#Adding labels to the variable names
colnames(data)
data <- data %>% 
  labelled::set_variable_labels(
    InsuranceType = "Insurance Type",
    MedAssist = "Medical Assistance",
    Location = "Clinic Location",
    PracticeType = "Practice Type",
    Completed = "Completed 3-Doses within 12 Months or Not",
    AgeGroup = "Age Groups",
    LocationType = "Clinic Location Type",
    completed_2dose = "Completed 2-Doses within 12 Months or Not"
  )
library(writexl)
writexl::write_xlsx(data,"cleaned_data.xlsx") #saving and keeping a version of the cleaned data


#Distribution of the Socio-demographic Characteristics of the Patients

data %>% 
  select("Age","AgeGroup","Race", "LocationType", "PracticeType", "InsuranceType") %>% 
  tbl_summary() %>% 
  modify_header(label = "**Characteristics**") %>% 
  modify_caption("**Table 2. Distribution of the Socio-demographic Characteristics of the Patients**") %>% 
  bold_labels() %>% 
  as_flex_table() %>%
  save_as_docx(path = "Summary Statistics.docx")




#Contingency Table between Shots Taken & Completion of 3-Shots within 12-Months

data %>% 
  select(Completed, Shots) %>% 
  tbl_summary(by = Completed) %>% 
  modify_header(label = "** **") %>% 
  modify_caption("**Table 1. Contingency Table bet No. of Shots Taken & Completion of 3-Shots within 12-Months**") %>% 
  modify_spanning_header(all_stat_cols() ~ "**Completed 3-Shots within 12 Months or Not**") %>% 
  bold_levels() %>% 
  bold_labels() %>% 
  as_flex_table() %>% 
  save_as_docx(path = "contingency table bet shots and completion.docx")


# data %>% 
#   select(Completed, Race) %>% 
#   tbl_summary(by = Completed) %>% 
#   add_p()

### Shots of Gardasil Vaccine Taken
# Create a table with count and percentage of Shots
shots_table <- table(data$Shots)
shots_table
shots_perc <- round(100*shots_table/sum(shots_table),1)
shots_perc

pie(shots_table, labels = paste0(shots_table, " (", shots_perc, "%)"), 
    main = "Shots of Gardasil Vaccine Taken",
    col = c("#E69F00", "#56B4E9", "#009E73"), # custom color palette
    border = NA) # no border

legend("right", legend = c("1-Shot","2-Shots","3-Shots"),
       fill = c("#E69F00", "#56B4E9", "#009E73"), # custom color palette
       border = NA, bty = "n") # no border

# Add a subtitle with the total number of patients
title(sub = paste0("Total Patients: ", nrow(data)), 
      font.sub = 2, cex.sub = 1)


### Completion of 3-doses within 12-Months
# Create a table with count and percentage of Completion
completed_table <- table(data$Completed)
completed_perc <- round(100*completed_table/sum(completed_table),1)
pie(completed_table, labels = paste0(completed_table, " (", completed_perc, "%)"), 
    main = "Completion of 3-doses within 12-Months",
    col = c("#E06469", "#41644A"), # custom color palette
    border = NA) # no border

legend("right", legend = c("No","Yes"),
       fill = c("#E06469", "#41644A"), # custom color palette
       border = NA, bty = "n") # no border

# Add a subtitle with the total number of patients
title(sub = paste0("Total Patients: ", nrow(data)), 
      font.sub = 2, cex.sub = 1)


###
data %>% 
      select(Completed, AgeGroup) %>% 
      tbl_summary(by = Completed, percent = "row")

data %>% 
     select(Completed, Race) %>% 
     tbl_summary(by = Completed, percent = "row")

data %>% 
  select(Completed, LocationType) %>% 
  tbl_summary(by = Completed, percent = "row")

data %>% 
  select(Completed, InsuranceType) %>% 
  tbl_summary(by = Completed, percent = "row")

data %>% 
  select(Completed, PracticeType) %>% 
  tbl_summary(by = Completed, percent = "row")

###Proportion test: 2-sample test for equality of proportions with continuity correction

data %>%
  select(Completed, LocationType) %>%
  tbl_summary(by = Completed, percent = "row") %>%
  add_p(
    test = everything() ~ "prop.test", 
    pvalue_fun = ~style_pvalue(.x, digits = 3)) %>%
  add_n() %>% 
  modify_header(label = "** **") %>%
  modify_caption("**Table 3. Two Sample Proportion Test between Suburban vs Urban Location**") %>% 
  modify_spanning_header(all_stat_cols() ~ "**Completed 3-Shots within 12 Months or Not**") %>%
  modify_footnote(update = everything() ~ NA) %>%
  bold_labels() %>% 
  as_flex_table() %>% 
  save_as_docx(path = "Two Sample Proportion Test.docx")


###Chi-square Test of Homogeneity among the Completion Rate of different Insurance Types
# create a contingency table with observed frequencies
observed <- table(data$InsuranceType, data$Completed)
observed
# calculate expected frequencies under the assumption of independence
expected <- round(outer(rowSums(observed), colSums(observed)) / sum(observed), 2)
expected
# perform chi-squared test
test_result <- chisq.test(observed, p=expected, rescale.p=TRUE)

# print the test results
test_result



# Creating a clustered bar chart
ct <- table(data$Completed, data$InsuranceType, data$LocationType)
# Calculating percentages
pct <- prop.table(ct, 2) * 100
pct

library(ggplot2)
ggplot(as.data.frame(pct), aes(x = Var2, y = Freq, fill = Var1, label = paste0(sprintf("%.1f", Freq), "%"))) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  ggtitle("Association bet Completion and Insurance Type by Clinic's Location") +
  labs(x = "Insurance Type", y = "Percentage (%)") +
  scale_fill_discrete(name = "Completion") +
  facet_grid(rows = vars(Var3)) +
  theme_minimal() +
  theme(plot.title = element_text(size = 12, hjust = 0.5),
        legend.position = "right") 
# +
#   geom_text(position = position_dodge(width = 0.8), size= 3.5, vjust = -0.5)




###Odds Ratio: Completion for Suburban vs Urban

data %>% 
  select(Completed, LocationType) %>% 
  tbl_summary(by = Completed) %>% 
  modify_header(label = "** **") %>% 
  add_overall(last = TRUE,
              statistic = ~"{n}",
              digits = ~ c(0, 0)) %>% 
  modify_header(label = "**Characteristics**") %>% 
  modify_caption("**Table 5. Contingency Table between Location Type & Completion of 3-Shot Regimen**") %>% 
  modify_spanning_header(all_stat_cols() ~ "**Completed 3-Shots within 12 Months or Not**") %>% 
  bold_levels() %>% 
  bold_labels() 
#%>% 
# as_flex_table() %>% 
# save_as_docx(path = "contingency table bet loationtype and completion.docx")


###Odds Ratio: Completion for White vs Black

data %>% 
  select(Completed, Race) %>% 
  tbl_summary(by = Completed) %>% 
  modify_header(label = "** **") %>% 
  add_overall(last = TRUE,
              statistic = ~"{n}",
              digits = ~ c(0, 0)) %>% 
  modify_header(label = "**Characteristics**") %>% 
  modify_caption("**Contingency Table bet Race & Completion of 3-Shot Regimen**") %>% 
  modify_spanning_header(all_stat_cols() ~ "**Completed 3-Shots within 12 Months or Not**") %>% 
  bold_levels() %>% 
  bold_labels() 

###Odds Ratio: Completion for Minor vs Adult

data %>% 
  select(Completed, AgeGroup) %>% 
  tbl_summary(by = Completed) %>% 
  modify_header(label = "** **") %>% 
  add_overall(last = TRUE,
              statistic = ~"{n}",
              digits = ~ c(0, 0)) %>% 
  modify_header(label = "**Characteristics**") %>% 
  modify_caption("** Contingency Table bet Age Groups & Completion of 3-Shot Regimen**") %>% 
  modify_spanning_header(all_stat_cols() ~ "**Completed 3-Shots within 12 Months or Not**") %>% 
  bold_levels() %>% 
  bold_labels() 


### Multiple Logistic Regression Model
model <- glm(Completed ~ AgeGroup + Race + LocationType + InsuranceType, data = data, family = binomial())
# model
# summary(model)

tbl_regression(model, 
               exponentiate = TRUE,
               label = list(
                 AgeGroup ~ "Age Group",
                 Race ~ "Race",
                 LocationType ~ "Location Type",
                 InsuranceType ~ "Insurance Type"
               ),
               tidy_fun = broom.helpers::tidy_parameters) %>% 
  modify_header(label = "**Predictors**") %>% 
  modify_caption("**Table 6. Contingency Table bet Location Type & Completion of 3-Shot Regimen**") %>% 
  bold_labels() %>% 
  as_flex_table() %>% 
  save_as_docx(path = "Logistics Regression Output.docx")

hltest(model)


### If the women only needed 2-doses, would the relationship with completion change?

### Completion of 2-doses within 12-Months
# Create a table with count and percentage of Completion
completed_table <- table(data$completed_2dose)
completed_perc <- round(100*completed_table/sum(completed_table),1)
pie(completed_table, labels = paste0(completed_table, " (", completed_perc, "%)"), 
    main = "Completion of 2-doses within 12-Months",
    col = c("#E06469", "#41644A"), # custom color palette
    border = NA) # no border

legend("right", legend = c("No","Yes"),
       fill = c("#E06469", "#41644A"), # custom color palette
       border = NA, bty = "n") # no border

# Add a subtitle with the total number of patients
title(sub = paste0("Total Patients: ", nrow(data)), 
      font.sub = 2, cex.sub = 1)

