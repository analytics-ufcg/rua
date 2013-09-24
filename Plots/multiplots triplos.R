require(ggplot2)
require(grid)

# multiplot code
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}



# plot cpu e mem
files <- c(9, 32, 33)
file_names <- paste("xsys", files, ".csv", sep="")
limits <- c(20, 7, 7.5)
limits2 <- c(10, 6, 7)

for(i in 1:length(file_names)){
     
     dff<- read.csv(file_names[i])
     
     
     g1 <- subset(dff, dff[,4] > limits[i])
     g2 <- subset(dff, dff[,4] <=  limits[i] & dff[,4] >=  limits2[i])
     g3 <- subset(dff, dff[,4] <  limits2[i])
     
     df1 <- data.frame(g1, TYPE="G1")
     
     df2 <- c()
     if(nrow(g2) > 0){
          df2 <- data.frame(g2, TYPE="G2")
     }
	 
	 df3 <- c()
     if(nrow(g3) > 0){
          df3 <- data.frame(g3, TYPE="G3")
     }

     dfff <- rbind(df1, df2)
	 dfff <- rbind(dfff, df3)

     png(filename=paste("pic", files[i], ".png", sep=""), width=800 , height=600)

     p1 <- ggplot(dfff, aes( dfff$UTIS, dfff$MEM_UTIL, colour=TYPE))+ xlab("Tempo") + ylab("Memória") + geom_point() + scale_fill_hue()
     p2 <- ggplot(dfff, aes( dfff$UTIS, dfff$CPU_UTIL, colour=TYPE))+ xlab("Tempo") + ylab("CPU") + geom_point() + scale_fill_hue()
     p3 <- ggplot(dfff, aes( dfff$CPU_UTIL, dfff$MEM_UTIL, colour=TYPE))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue()

     multiplot(p1, p2, p3, cols=2)
     dev.off()
}


