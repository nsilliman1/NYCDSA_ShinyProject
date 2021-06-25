
shinyServer(function(input, output){
    output$table <- DT::renderDataTable({
        datatable(music_df, rownames = FALSE, options = list(scrollX = TRUE), width = 50) %>% 
        formatStyle(input$selected,
            background="skyblue", fontWeight='bold')
    })
    output$finding1 <- renderPlot(
      music_df %>% group_by(year) %>% summarise(MeanDurationMin= mean(duration_ms/1000/60)) %>%
        ggplot(aes(x = year, y = MeanDurationMin)) +
          geom_line(color = 'blue') +
          theme_bw() +
          xlab("Year") +
          scale_x_continuous(n.breaks = 12) +
          ylab("Minutes")
    )
    output$finding2 <- renderPlot(
      music_df %>%
        ggplot(aes(x = as.integer(key), y = year_bin, fill = year_bin)) +
        geom_density_ridges() +
        theme_bw() +
        xlab("Key") +
        ylab("Density")
    )
    output$finding3 <- renderPlot(
      music_df %>% group_by(year) %>% summarise(MeanLoudness = mean(loudness), MeanAcoustic = mean(acousticness)) %>%
        ggplot(aes(x = year)) +
        geom_line(aes(y = MeanLoudness), color = 'blue') +
        geom_line(aes(y = (MeanAcoustic-7)*1), color = 'red') +
        scale_y_continuous(sec.axis = sec_axis(~(.+7)/1, name = "MeanAcoustic")) +
        theme(
          axis.title.y = element_text(color = 'blue', size=13),
          axis.title.y.right = element_text(color = 'red', size=13)) + 
        scale_x_continuous(n.breaks = 12) +
        xlab("Year")
    )
    output$finding4 <- renderPlot(
      music_df %>% group_by(year, Gender) %>% summarise(n = sum(n())) %>% 
        mutate(Percentage = n/sum(n)) %>% 
        ggplot(aes(x = year, y = Percentage, fill = Gender)) +
        geom_bar(stat = 'identity') +
        theme_bw() +
        xlab("Year") +
        scale_x_continuous(n.breaks = 12) + 
        scale_y_continuous(labels = percent)
    )
    output$explore <- renderPlot(  
      music_df_sum %>% 
        ggplot(
          aes(
            x = eval(parse(text = paste0('music_df_sum','$',as.character(input$xaxis)))),
            y = eval(parse(text = paste0('music_df_sum','$',as.character(input$yaxis))))
          )) +
          geom_point(aes(size = 3, fill = year_bin), pch = 21, color = 'black') +
          xlab(as.character(input$xaxis)) +
          ylab(as.character(input$yaxis)) +
          theme_bw() + 
          guides(size = FALSE) + 
          theme(legend.title = element_text(size=14, face="bold")) +
          guides(fill = guide_legend(override.aes = list(size = 6))) +
          scale_fill_discrete(name = "Decade") +
          scale_fill_brewer(palette="PiYG")
    )
})