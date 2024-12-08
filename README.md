R Script


# README

## Overview

This project examines the impact of minimum wage and income on physical activity using regression analysis. The analysis involves calculating summary statistics, visualizing key variables, performing regression models with robustness checks, and generating formatted outputs.  

The code is designed to be modular and reproducible, with scripts structured to produce key tables and figures required for analysis. Data is assumed to be saved as `Physical` in the working directory.


## Requirements

The following R packages are required to run the analysis:

- `dplyr`
- `kableExtra`
- `officer`
- `broom`
- `ggplot2`
- `psych`
- `knitr`
- `flextable`
- `lmtest`
- `sandwich`
- `stargazer`

Ensure all these packages are installed using the following command:

```R
install.packages(c("dplyr", "kableExtra", "officer", "broom", "ggplot2", "psych", 
                   "knitr", "flextable", "lmtest", "sandwich", "stargazer"))
```

---

## Files and Directories

### **Folder Structure**
```
Project/
│
├── scripts/
│   ├── analysis.R         # Main analysis script
│
├── data/
│   ├── Physical.RData  # Dataset for analysis
│
├── output/
│   ├── Summary_Statistics.docx     # Generated summary statistics table
│   ├── model_results.doc           # Regression results
│
├── README.md                        # Instructions and details
```

---

## Full Instructions for Replication

### 1. **Set Up the Environment**
   1. Clone this repository or download the files to your local directory.
   2. Open an R session and set the working directory to the project folder. Example:
      ```R
      setwd("path/to/Project")
      ```

### 2. **Load the Dataset**
   Ensure the dataset `Physical` is saved in the `data/` folder. Load it using:
   ```R
   load("data/Physical.RData")
   ```

### 3. **Run the Analysis Script**
   Execute the main analysis script located in the `scripts/` directory:
   ```R
   source("scripts/Physical.R")
   ```

### 4. **Generated Outputs**
   Upon running the script, the following outputs will be created:
   - `Summary_Statistics.docx`: A Word document containing formatted summary statistics.
   - `model_results.doc`: A Word-compatible file summarizing regression models.

### 5. **Script Breakdown**
   The script performs the following steps:
   
   - **Summary Statistics**:
     - Computes key descriptive statistics (mean, SD, min, max) for variables like `exercise`, `income`, `employed`, `age`, and health measures.
     - Saves a formatted table as a Word document.

   - **Visualizations**:
     - Creates histograms for `income` and `age`.
     - Produces bar plots for `exercise` and `employment`.

   - **Regression Analysis**:
     - Performs multiple Ordinary Least Squares (OLS) regression models.
     - Includes robustness checks by age group.
     - Outputs a comparison of models in a Word-compatible format.

---

## Example Outputs

### Summary Statistics Table
Example snippet from the generated table:
| Variable       | Mean  | SD    | Min  | Max  |
|----------------|-------|-------|------|------|
| Exercise       | 0.65  | 0.48  | 0    | 1    |
| Income         | 45000 | 15000 | 1000 | 100000 |

### Regression Results
Snippet from regression output:
| Variable        | Model 1   | Model 2   | Model 3   | Model 4   |
|-----------------|-----------|-----------|-----------|-----------|
| Income          | 0.012**   | 0.009*    | 0.007*    | 0.005     |
| Employment      |           | 0.078**   | 0.070**   | 0.060*    |
| Age             |           |           | -0.002    | -0.003    |
| General Health  |           |           |           | 0.085**   |

---
## Notes
- I ensured the dataset was correctly formatted and handled missing values by using `na.rm = TRUE`.
- Adjustments, such as modifying bin widths in histograms, were made as needed.

## Challenges and How I Addressed Them
- **Missing Packages**: I installed any missing package using `install.packages("package_name")`.
- **Dataset Issues**: I verified the dataset name and location in the working directory.

This README provides an overview of my workflow for replicating this analysis.

