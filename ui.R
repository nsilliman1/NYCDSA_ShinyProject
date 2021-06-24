
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
              box(title = "Finding 2: Key Variation by Decade", status = 'warning', solidHeader = TRUE,
                  plotOutput("finding2"))
            ),
            fluidRow(
              box(status = 'warning',
                  "Song length has obvioulsy changed over the years. Average song length in the 60s was under 3min, then it lengthend to above 4min
                  in the mid 70s through the mid 00s, dropping down too just under 4min in the 10s. This could have happened for a variety of reasons inlduing 
                  repording and distribution technology, marketing strategy of distributers, and cultural shifts."),
              box(status = 'warning',
                  "Overtime, from the 1960s to the 2010s, it seems there has been a drop in key variation. In the 1960s, there seems to be a 
                  somewhat even distribution of key usage. Then as the decades continued, more concentration seemed to occur. I would think
                  that more varied use of keys would come from more skilled musicians and lead to more complex expressions. This could
                  also be sourced from what is considered 'popular music' in each decade. More exploration is needed
                  in this area.")
            ),
            fluidRow(
              box(title = "Finding 3: Evolution of Loudness vs Acousticness", status = 'warning', solidHeader = TRUE,
                  plotOutput("finding3")),
              box(title = "Finding 4: Change in Group Gender", status = 'warning', solidHeader = TRUE,
                  plotOutput("finding4")),
            ),
            fluidRow(
              box(status = 'warning',
                  "Music overtime has seen a shift away from Acoustic music. This has probably shifted as new elecrtronic expression 
                  increased in the 1990s with new technology. This trend is correlated with an increase in the 'Loudness' of songs
                  over the years."),
              box(status = 'warning',
                  "The gender of groups has flucuated over time. There seems to be a consistenet trend of more and more female
                  artists breaking into the top 100 list. Groups conversly seen a decline from the mid 1960s to the 2010s.")
            )
         ),
        tabItem(tabName = "exploration", 
                fluidRow(
                  box(status = 'warning',
                      selectizeInput(inputId = "xaxis",
                                    label = "X-Axis",
                                    choices = colnames(music_df_sum)[2:length(m)],
                                    selected = 'Duration'),
                      selectizeInput(inputId = "yaxis",
                                    label = "Y-Axis",
                                    choices = colnames(music_df_sum)[2:length(m)],
                                    selected = 'Energy'),
                      plotOutput("explore")
                     )
                  )
        ),
        tabItem(tabName = "dataset", DT::dataTableOutput("table", width = 300))
      )
    )
  )
)