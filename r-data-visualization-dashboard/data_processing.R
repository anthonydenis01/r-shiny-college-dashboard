library(shiny)
library(tidyverse)
library(maps)

# Load and filter data
college <- read.csv('college.csv')
college <- college %>% filter(state == "GA")
states <- map_data("state") %>% filter(region == "georgia")

# Define UI with two tabs
ui <- navbarPage("Anthony Denis Data Visualization Final Exam",
                 tabPanel("Page 1",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons(
                                inputId = "school_type", 
                                label = "Select School Type", 
                                choices = c("Public", "Private"), 
                                selected = "Public"
                              )
                            ),
                            mainPanel(
                              plotOutput("plot1")
                            )
                          )
                 ),
                 tabPanel("Page 2",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons(
                                inputId = "map_school_type", 
                                label = "Select School Type", 
                                choices = c("Public", "Private"), 
                                selected = "Public"
                              )
                            ),
                            mainPanel(
                              plotOutput("plot2")
                            )
                          )
                 )
)

# Define server logic
server <- function(input, output, session) {
  
  output$plot1 <- renderPlot({
    req(input$school_type)
    filtered_data <- college %>% filter(control == input$school_type)
    
    ggplot(filtered_data, aes(x = reorder(name, undergrads), y = undergrads)) +
      geom_bar(stat = "identity", fill = "lightblue") +
      theme_classic() +
      labs(
        title = "Colleges & Universities in Georgia",
        subtitle = "Source: U.S. Department of Education",
        x = "School Name",
        y = "Number of Undergraduate Students"
      ) +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, face = "italic"),
        axis.text.x = element_text(angle = 45, hjust = 1),
        axis.text.y = element_text(size = 10),
        legend.position = "none"
      )
  })
  
  output$plot2 <- renderPlot({
    req(input$map_school_type)
    filtered_college <- college %>% filter(control == input$map_school_type)
    
    if (nrow(filtered_college) == 0) return(NULL)
    
    ggplot() +
      geom_polygon(data = states, aes(x = long, y = lat, group = group), 
                   fill = "lightyellow", color = "gray") +
      geom_point(
        data = filtered_college, 
        aes(x = lng, y = lat, size = undergrads, color = control), 
        alpha = 0.7
      ) +
      geom_text(
        data = filtered_college, 
        aes(x = lng, y = lat, label = name), 
        check_overlap = TRUE, size = 3, hjust = 0.5, vjust = -1
      ) +
      scale_size_continuous(name = "Undergraduate Population", range = c(3, 10)) +
      scale_color_manual(name = "Institutional Control", values = c("Public" = "red", "Private" = "darkblue")) +
      theme_minimal() +
      labs(
        title = "Colleges & Universities in Georgia",
        subtitle = "Source: U.S. Department of Education",
        x = "Longitude",
        y = "Latitude"
      ) +
      theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, face = "italic"),
        legend.position = "right"
      )
  })
}

# Run the Shiny app
shinyApp(ui, server)