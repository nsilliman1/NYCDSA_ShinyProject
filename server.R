
shinyServer(function(input, output){
    output$table <- DT::renderDataTable({
        datatable(music_df, rownames=FALSE) %>% 
        formatStyle(input$selected,
            background="skyblue", fontWeight='bold'
        ) 
    })
    output$finding1 <- renderPlot(
      music_df %>% group_by(year) %>% summarise(MeanDurationMin= mean(duration_ms/1000/60)) %>%
        ggplot(aes(x = year, y = MeanDurationMin)) +
          geom_line(color = 'blue') +
          theme_bw() +
          ggtitle("Average Duration of Songs by Year (min)") + 
          xlab("Year") +
          ylab("Minutes")
    )
})
  





  
#   observe({
#     dest <- unique(flights %>%
#                      filter(flights$origin == input$origin) %>%
#                      .$dest)
#     updateSelectizeInput(
#       session, "dest",
#       choices = dest,
#       selected = dest[1])
#   })
#   
#   flights_delay <- reactive({
#     flights %>%
#       filter(origin == input$origin & dest == input$dest) %>%
#       group_by(carrier) %>%
#       summarise(n = n(),
#                 departure = mean(dep_delay),
#                 arrival = mean(arr_delay))
#   })
# 
#   output$delay <- renderPlot(
#     flights_delay() %>%
#       gather(key = type, value = delay, departure, arrival) %>%
#       ggplot(aes(x = carrier, y = delay, fill = type)) +
#       geom_col(position = "dodge") +
#       ggtitle("Average delay")
#   )
# 
#   output$count <- renderPlot(
#     flights_delay() %>%
#       ggplot(aes(x = carrier, y = n)) +
#       geom_col(fill = "lightblue") +
#       ggtitle("Number of flights")
#   )
# }