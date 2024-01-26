# load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)

# user interface ----
ui <- fluidPage(
  
  # app title ----
  tags$h1("My App Title"),
  
  # app subtitle ----
  h4(strong("Exploring Antarctic Peguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input", 
              # text printed above widget for users to see
              label = "Select a range of body masses (g):",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  
  # Year check box input
  checkboxGroupInput(inputId = "year_input",
                     label = "Select years",
                     choices = c("2007", "2008", "2009"),
                     selected = c("2007", "2008")),
  
  # Year data table output
  DT::dataTableOutput(outputId = "year_datatable_output")
  
)

# server ----
server <- function(input, output) {
  
  # filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  # render penguin scatterplot ----
  output$body_mass_scatterplot_output <- renderPlot({ # code to generate plot
    
    # add ggplot code here
    ggplot(na.omit(body_mass_df()), # reactive dataframe needs ()
           aes(x = flipper_length_mm, y = bill_length_mm,
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange",
                                    "Chinstrap" = "purple", 
                                    "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, 
                                    "Chinstrap" = 17,
                                    "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)",
           y = "Bill length (mm)",
           color = "Penguin Species",
           shape = "Penguin Species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
    
  }) 
  
  # filter years ----
  year_df <- reactive({
    
    penguins %>% 
      filter(year %in% c(input$year_input))
  })
  
  # render DT table ----
  output$year_datatable_output <- DT::renderDataTable({
    
    DT::datatable(year_df())
    
  })
  
}

# combine UI & server into app ----
shinyApp(ui = ui, server = server)