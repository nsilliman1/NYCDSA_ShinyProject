
shinyUI(
  dashboardPage(
    dashboardHeader(title = "Decades in Music"
    ), 
    dashboardSidebar(
      sidebarUserPanel("Navigation"), 
      sidebarMenu(
        menuItem("Home", tabName = "home"),
        menuItem("Findings", tabName = "findings"),
        menuItem("Exploration", tabName = "exploration"),
        menuItem("Dataset", tabName = "dataset")
        )
    ),
    dashboardBody(
      tabItems(
         tabItem(tabName = "home",
            fluidRow(
              tabBox(
                id = "tabset1",
                tabPanel("Analysis Rational", 
                         h4("Analysis on Top 100 Billboard Music Data"),
                         h5("The rational for this projects is to examine how certain characterisitics 
                            of music have changed over decades frm  1960's to the 2010's."),
                         h5("See the next tab for more details on the data."),
                         h5("The sidebar provides navigation to the Analysis. I have provided a 'Findings' tab in which
                            I detail intersting things that I have found within the data while comparing across 
                            decades. The Exploration tab gives the user a chance to pivot aaround the data to become
                            better aquianted with it and see if there are other interesting trends I may have missed.")
                ),
                tabPanel("Data",
                         h4("Data Lineage, Source, and Quality"),
                         h5("This data was sourced from Billboard from a public GitHub repository:"),
                         h5("https://github.com/RosebudAnwuri/TheArtandScienceofData/tree/master/The%20Making%20of%20Great%20Music"),
                         h5("I found the data source through this blog post which provides more detail on the fields used and 
                         data preperation methods:"),
                         h5("https://towardsdatascience.com/billboard-hot-100-analytics-using-data-to-understand-the-shift-in-popular-music-in-the-last-60-ac3919d39b49"),
                         h5("In summary, the source lineage of this data is from a webscrape of Billboard Hot 100 database, which was 
                            then enriched with Spotify's API to pull in additional metrics on the songs (loudness, key, etc.)"),
                         h5("Its important to note that during the scraping process and the data enrichment through APIs, some data was 
                            unreliable and some some records of songs were dropped. As such, I do not have data on the actual Billboard
                            position for the song. However, my purpose here is to examine the trends over decades of these songs, so I
                            will be looking at mostly averages across songs.")
                         
                )
              )
            )
         ),
         tabItem(tabName = "findings", 
            fluidRow(
              box(title = "Finding 1: Song Duration", status = 'warning', solidHeader = TRUE,
                  plotOutput("finding1")),
              box(status = "warning", "Box content")
            ),
            
            fluidRow(
              box(
                title = "Title 1", width = 4, solidHeader = TRUE, status = "primary",
                "Box content"
              ),
              box(
                title = "Title 2", width = 4, solidHeader = TRUE,
                "Box content"
              ),
              box(
                title = "Title 1", width = 4, solidHeader = TRUE, status = "warning",
                "Box content"
              )
            ),
            
            fluidRow(
              box(
                width = 4, background = "black",
                "A box with a solid black background"
              ),
              box(
                title = "Title 5", width = 4, background = "light-blue",
                "A box with a solid light-blue background"
              ),
              box(
                title = "Title 6",width = 4, background = "maroon",
                "A box with a solid maroon background"
              )
            )
         ),
        tabItem(tabName = "exploration", "to be replaced with datatable"),
        tabItem(tabName = "dataset", DT::dataTableOutput("table"))
      )
    )
  )
)


