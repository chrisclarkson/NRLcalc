library(plyr)
library(zoo)
library(shiny)
filed=read.table('files')
ui <- fluidPage(
  actionButton("nex","next"),
  actionButton("back","back"),
  column(12,tableOutput('counter')),
  #column(12,tableOutput('tan')),
  sliderInput(inputId="smooth", label="smooth", value=1, min=1, max=40),
  column(6,plotOutput("plot", click = "plot_click1")),
  column(5,plotOutput('lin')),
  sliderInput(inputId="res_y", label="Y resolution", value=5000, min=50, max=15000),
  verbatimTextOutput("info"),
  column(1,actionButton("submit1","add to list")),
  column(6,actionButton("png","png")),
  column(12,tableOutput('table'))
)

server <- function(input, output) {
  value= reactiveVal(1)
  output$counter=renderText({paste(filed[value(),])})
  observeEvent(input$back, {
    newValue <- value() - 1     # newValue <- rv$value - 1
    value(newValue)             # rv$value <- newValue
  })
  
  observeEvent(input$nex, {
    newValue <- value() + 1     # newValue <- rv$value + 1
    value(newValue)             # rv$value <- newValue
  })
  
  
  df <- reactive({
    load_data<-function(wd,sample) {
      path.to_matrix<-paste(wd,sample, sep="/")
      print(path.to_matrix)
      data <- as.data.frame(read.delim(path.to_matrix, header=FALSE, dec=".", sep="\t"))
      data <- data[,colSums(is.na(data))<nrow(data)]
      if (is.null(dim(data))) {
        df <- data.frame( distance=seq(1,length(data)), frequency = data )
      } else {
        df <- data.frame( distance=seq(1,length(rowSums(data))), frequency = rowSums(data))
      }
      #remove first element
      df<-df[-c(1:150),]
      from=nrow(df)-400
      #df=df[-c(from:nrow(df)),]
      print(head(df))
      return(df)
    }
    f=paste(filed[value(),])
    df=load_data('.',f)
    df
  })
  #output$tan=renderTable({print(head(df()))})
  
  
  click_saved1 <- reactiveValues(singleclick = NULL)
  click_saved2 <- reactiveValues(singleclick = NULL)
  observeEvent(eventExpr = input$plot_click1, handlerExpr = { click_saved1$singleclick <- input$plot_click1 })
  observeEvent(eventExpr = input$plot_click2, handlerExpr = { click_saved2$singleclick <- input$plot_click2 })
  observeEvent(eventExpr = input$png, handlerExpr = { 
    df=df()
    x<-df$distance
    y<-df$frequency
    png(paste0(filed[value(),],'.png'),width = 900,height = 500)
    par(mfrow=c(1,2),mar=c(5,5,5,0))
    plot(rollmean(x, input$smooth), rollmean(y, input$smooth), type='l', axes=F, 
         xlab = "Nucleosome distance (bp)", ylab="Nucleosome Occupancy", 
         cex.axis = 2, cex.lab = 2.7,bty='n',yaxt='n',xaxt='n',log='y')
    #lines(s[,ncol(s)], col='red', lty=2)
    axis(2,pos=min(x)-5,at=seq(round_any(min(y),input$res_y),max(y)+1000,by=input$res_y),cex.axis=1.5,lwd = 3)
    axis(1,pos=min(y)-50,at=seq(0,max(x)+300,by=200),cex.axis=1.7,lwd = 3)
    points(rv$m$x[-1],rv$m$y[-1], pch=16, col="red", cex=1)
    m=as.data.frame(cbind(x=seq(1,nrow(rv$m)-1),y=rv$m$x[-1]))
    print(m)
    fit=lm(y~x, data=m)
    print(fit)
    mar.default <- c(5,4,4,2) + 0.1
    par(mar = mar.default + c(0, 4, 0, 0))
    plot(m$x,m$y,xlab = "Peak number", ylab="Peak position",cex.axis = 2, cex.lab = 2.7, col="black", bty='n',yaxt='n',xaxt='n')
    axis(2,at=seq(0,max(y),100),cex.axis=1.5,lwd = 3)
    axis(1,at=seq(0,max(x),1),cex.axis=1.7,lwd = 3)
    abline(fit)
    legend("topleft", bty="n", legend=paste("NRL:",round(coef(fit)[-1], digits = 2), 
                                            "Error:",round(summary(fit)$coefficients[-1 , 2]), digits=2),cex=1.2)
    dev.off()
    write.table(paste(filed[value(),],round(coef(fit)[-1], digits = 2), 
                      round(summary(fit)$coefficients[-1 , 2]),sep='\t'),'NRLs_main.txt',append = T,quote=F,col.names=F,row.names=F)
    write.table(as.data.frame(rv$m[-1,]),paste0(gsub('NRL_aggregate_','',gsub('_CTCF.txt','',filed[value(),])),'_picked_points.txt'),row.names = F,col.names = F, sep='\t')
    #cat(paste(c(top[1,2],top[2,2],top[3,2],'\n'),sep='\t'),sep = '\t',
    #            file='NRL_fft.txt',append=T,quote=F,col.names=F,row.names=F)
  })
  rv=reactiveValues(m=data.frame(x=0,y=0))
  observe({ if (input$nex == 0) 
    return()
    rv$m <- data.frame(x=0,y=0)
  })  
  observe({ if (input$back == 0) 
    return()
    rv$m <- data.frame(x=0,y=0)
  })
  
  output$plot<- renderPlot({
    df=df()
    x<-df$distance
    y<-df$frequency
    par(mar=c(5,5,5,5))
    plot(rollmean(x, input$smooth), rollmean(y, input$smooth), type='l', axes=F, 
         xlab = "Nucleosome distance (bp)", ylab="Nucleosome Occupancy", 
         cex.axis = 2, cex.lab = 2.7,bty='n',yaxt='n',xaxt='n',log='y')
    #lines(s[,ncol(s)], co='red', lty=2)
    axis(2,pos=min(x)-5,at=seq(round_any(min(y),input$res_y),max(y),by=input$res_y),cex.axis=1.5,lwd = 3)
    axis(1,pos=min(y)-50,at=seq(0,max(x)+300,by=200),cex.axis=1.7,lwd = 3)
    points(rv$m$x[-1],rv$m$y[-1], pch=16, col="red", cex=1)
  })
  output$plot1 <- renderPlot({
    df=df()
    par(mar=c(5,5,5,5))
    x<-df$distance
    y<-df$frequency
    #plot(rollmean(x, input$smooth), rollmean(y, input$smooth), type='l', axes=F, xlab = "Nucleosome distance (bp)", ylab="Nucleosome Occupancy", cex.axis = 2, cex.lab = 2.7)
    plot(rollmean(y-x[,ncol(x)], input$smooth))
    axis(side=1, at=seq(0, 2000, by=25))
    axis(side=2)
    points(rv2$m$x[-1],rv2$m$y[-1], pch=16, col="red", cex=1)
  })
  
  output$info <- renderText({
    paste0("x=", input$plot_click1$x, "\ny=", input$plot_click1$y)
  })
  output$table <- renderTable({
    if (is.null(rv$m)) {return()}
    print(rv$m[-1,])
  }, 'include.rownames' = FALSE
  , 'include.colnames' = TRUE
  )
  
  
  observeEvent(input$submit1, {
    if (input$submit1 > 0) {
      rv$m <- rbind(rv$m,unlist(click_saved1$singleclick))
    }
  })
  
  
  output$lin=renderPlot({
    df=df()
    x<-df$distance
    y<-df$frequency
    m=as.data.frame(cbind(x=seq(1,nrow(rv$m)-1),y=rv$m$x[-1]))
    fit=lm(y~x, data=m)
    mar.default <- c(5,4,4,2) + 0.1
    par(mar = mar.default + c(0, 4, 0, 0))
    plot(m$x,m$y,xlab = "Peak number", ylab="Peak position",cex.axis = 2, cex.lab = 2.7, col="black",
         bty='n',yaxt='n',xaxt='n')
    axis(2,at=seq(0,max(y),100),cex.axis=1.5,lwd = 3)
    axis(1,at=seq(0,max(x),1),cex.axis=1.7,lwd = 3)
    abline(fit)
    legend("topleft", bty="n", legend=paste("NRL:",round(coef(fit)[-1], digits = 2), "Error:",round(summary(fit)$coefficients[-1 , 2]), digits=2),cex=1.2)
  })
}
shinyApp(ui, server)
