# 📊 R Shiny College Dashboard

## 🚀 Overview
This project is an **interactive Shiny dashboard** built with **flexdashboard** to visualize **colleges & universities in Georgia**. It allows users to explore **school type, enrollment, and location** on a dynamic map.

## 🌎 Live Dashboard
You can interact with the dashboard online:  
🔗 **[View Dashboard](https://anthonydenis01.shinyapps.io/Anthony_Denis_Data_Visualization_Final_Exam/)**

## 🔍 Features
✔ Interactive **bar chart** of college enrollments.  
✔ 🗺 **Dynamic map** displaying school locations in Georgia.  
✔ 🎛 **Shiny controls** to filter between **Public & Private** schools.  
✔ 🔄 **Customizable for Other States** – Modify the R code to analyze data for other states like **New York (NY)**.

## 🛠 Customizing for Another State
To visualize **college enrollment data for a different state** (e.g., NY), follow these steps:

1. Open **`app.R`** in RStudio.
2. Locate the **data filtering section**:
   ```r
   college <- college %>% filter(state == "GA")
   states <- map_data("state") %>% filter(region == "georgia")


✅ **Now, the README clearly states that users can modify the R code to visualize another state!** 🚀  

Let me know if you need any more adjustments! 😊
