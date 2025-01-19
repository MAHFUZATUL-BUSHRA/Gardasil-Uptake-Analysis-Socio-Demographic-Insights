# Gardasil Vaccine Completion Analysis at JHMI Clinics (2006–2008)
|| Identifying the Association between Gardasil Vaccine Completion Rate and various Socio-demographics Predictors using the Data gathered at Four Clinics of Johns Hopkins Medical Institutions (JHMI) during 2006-2008 ||
### Description:
This project explores the socio-demographic factors influencing Gardasil vaccine completion rates using data from four Johns Hopkins Medical Institutions (JHMI) clinics. Conducted as a retrospective study, it analyzes disparities in vaccine completion based on race, age, insurance type, and clinic location. The project also examines whether the shift to a two-dose regimen would impact completion rates. Key methodologies include exploratory data analysis, hypothesis testing, and logistic regression modeling.
The Questions Solved in this analysis:
#### Racial Disparities in Completion Rates
Are there significant differences in the odds of completing the Gardasil vaccine series between white and black women?

#### Impact of Clinic Location
How does clinic location (urban vs. suburban) influence the odds of completing the vaccine regimen?

#### Age and Completion Rates
Does the likelihood of completing the Gardasil vaccine vary with age? Should we consider age as a continuous variable or compare minors and adults as distinct groups?

#### Association with Insurance Type
Is there a relationship between the type of insurance held by patients and the odds of completing the Gardasil vaccine series?

### Tools Used:
* R for data preparation and analysis.

 
### Dataset Overview

The dataset includes records of young female patients who began the HPV vaccine series during the study period. Two clinics (Odenton and White Marsh) are located in suburban Baltimore, while the other two (Bayview and Johns Hopkins Hospital Outpatient Center) are in Baltimore City.The following variables are included:

* Age: Patient's age in years.
* Race: Patient's race, coded as:
        0: White
        1: Black
        2: Hispanic
        3: Other/Unknown
* Shots: The number of vaccine doses completed within 12 months of the first shot.
* Completed: Whether the patient completed the three-shot regimen within 12 months (0 = No, 1 = Yes).
* InsuranceType: The type of insurance the patient had, coded as:
        0: Medical Assistance
        1: Private Payer (e.g., Blue Cross Blue Shield, Aetna, etc.)
        2: Hospital-based (EHF)
        3: Military (e.g., USFHP, Tricare, MA)
* MedAssist: Whether the patient had any form of medical assistance (0 = No, 1 = Yes).
* Location: The clinic attended, coded as:
        1: Odenton (Suburban)
        2: White Marsh (Suburban)
        3: Johns Hopkins Outpatient Center (Urban)
        4: Bayview (Urban)
  * PracticeType: The type of practice visited, coded as:
        0: Pediatric
        1: Family Practice
        2: OB-GYN

### Key Features:
* Analysis of 1,413 patient records from urban and suburban clinics.
* Exploratory Data Analysis (EDA) using visualizations and descriptive statistics
* Identification of factors like race, age group, and insurance affecting vaccine completion.
* Statistical tests including Chi-square, Z-tests, and Odds Ratios.
* Logistic regression to assess predictors of vaccine completion.
### Results:
#### Data Anomalies Observed

 1.Missing Values in Completion Status:
    Two records (Patient IDs: 217 and 1264) had missing values in the "Completed" variable. Since these patients received only one dose within 12 months, their "Completed" status was updated to No.

 2.Inconsistencies in Completion Data:
    A discrepancy was found where 68 patients completed all three vaccine doses but did not meet the 12-month completion criteria. This suggests these doses were completed outside the recommended timeframe.
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/01.png" alt="Image 01" width="400"> 
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/02.png" alt="Image 02" width="400">

##### A total of 38% of patients completed the three-dose Gardasil vaccine series; however, only 33.2% completed the regimen within the recommended 12-month period.
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/2.png" alt="p" width="400">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Vaccine-Completion-Analysis/blob/main/Pictures/3.png" alt="p" width="400">
 3.Outlier in Age Data:
    One record (Patient ID: 951) shows an age of 34, exceeding the recommended age range of 9-26 years for the Gardasil vaccine. This may be a data entry error or an exception in the study, but the record was retained for analysis.
    
### Exploratory Data Analysis [EDA]
#### Distribution of the Socio-demographic Characteristics of the Patients
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/summary.png" alt="Summary" width="250" height="250">


#### Association of the Completion Rate of the 3-Doses Regimen with various Socio-demographic Variables
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/characteristics.png" alt="Characteristics" width="250" height="250">


#### Bivariate Data Analysis & Hypothesis Testing
#### Summary of the variables
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/4.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">



#### Proportion test: 2-sample test for equality of proportions with continuity correction
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">

#### Chi-square Test of Homogeneity among the Completion Rate of different Insurance Types
       InsuranceType          No         Yes
      Medical Assistance 220 (183.7)   55 (91.3)
         Private Payer   470 (483)   253 (240)
        Hospital-based   45 (56.1)   39 (27.9)
              Military 209 (221.1) 122 (109.9)
 Chi-squared = 31.283,
 Degrees of Freedom = 3,
  P-value = 7.41e-07

#### Difference in the Completion Rate in the Presence of Location
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">
<h4>Odds Ratios</h4>
<h4>Contingency Table between Shots Taken & Completion of 3-Shots within 12-Months</h4>
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/Pictures/5.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/location.png" alt="p" width="250">
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/insurrance.png" alt="p" width="250">
<h4>Multiple Logistic Regression Model</h4>
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/logistic.png" alt="p" width="250">
<h4>Contingency Table between Shots Taken & Completion of 3-Shots within 12-Months</h4>
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/odds.png" alt="p" width="250">

(355 patients out of 963 patients living in the suburban area completed the 3-shots)/ 
(608 patients out of 963 patients living in the suburban area didn’t complete the 3-shots))/ 
((114 patients out of 450 patients living in the urban area completed the 3-shots)/ 
(336 patients out of 450 patients living in the urban area didn’t complete the 3-shots))
= (355/608)/ (114/336)
= 1.72

The Chance of Suburban Patients completing the 3-doses regimen of Gardasil Vaccine is 1.72 times higher than that of patients from Urban Areas.
#### Hosmer-Lemeshow Goodness-of-Fit Test
## 
     Group Size Observed Expected
        1  133       20 19.47033
        2  110       28 22.52485
        3  123       29 30.62004
        4  143       45 38.68650
        5  132       31 41.65828
        6  160       51 55.24058
        7  246       89 90.83540
        8  142       60 58.91820
        9  180       90 86.89509
        10  44       26 24.15073
        
        Statistic =  8.31968 
        degrees of freedom =  8 
        p-value =  0.40288
#### Completion Rate Distribution with 2-Doses
<img src="https://github.com/MAHFUZATUL-BUSHRA/Gardasil-Uptake-Analysis-Socio-Demographic-Insights/blob/main/2%20doses.png" alt="p" width="250">

### Gardasil Vaccine Completion and Impact
The Gardasil vaccine is effective in preventing HPV-related cancers and diseases, yet acceptance and timely completion of the recommended 3-dose regimen remain low. In the study, only 33.2% of participants completed all doses within the recommended 12-month period, while 68 participants completed the series beyond this timeframe. Socio-demographic factors were analyzed, revealing higher completion rates among specific groups.
### Highlights:
* Insights into racial disparities and urban-suburban differences in vaccine uptake.
* Discussion of the implications of switching to a two-dose regimen.
* Recommendations for improving vaccine completion rates.
