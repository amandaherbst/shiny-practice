# user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this Page",
           
           # intro text fluidRow ----
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow
           
           hr(), # add horizontal line for footer underneath
           
           includeMarkdown("text/footer.md")
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel
                        sidebarPanel(
                          
                          # channel type pickerinput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s)",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s)",
                                               choices = c("clear cut forest", "old growth forest"),
                                               selected = c("clear cut forest", "old growth forest"),
                                               individual = FALSE, justified = TRUE, size = "sm",
                                               checkIcon = list(yes = icon("check"),
                                                                no = icon("xmark")))
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            withSpinner(color = "magenta", type = 1)
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel
             # penguin tabPanel ----
             
             tabPanel(title = "Penguins",
                      
                      # penguin sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        sidebarPanel(
                          
                          pickerInput(inputId = "islands_input",
                                      label = "Select island(s)",
                                      choices = unique(penguins$island),
                                      selected = c("Dream"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          sliderInput(inputId = "penguin_slider_input",
                                      label = "Select number of bins",
                                      min = 1,
                                      max = 100,
                                      value = 25)
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ----
                        mainPanel(
                          
                          plotOutput(outputId = "penguin_histogram_output") %>% 
                            withSpinner(color = "forestgreen", type = 4, size = 2)
                          
                        ) # END penguin mainPanel
                        
                      ) # END penguin sidebarLayout
                      
             ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
) # END navbarPage