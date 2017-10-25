# Finneas Bit - Sketch
# c. Wed Oct 25 17:05:58 CDT 2017

# Download data via fitbitConfig.R file using curl from CLI

library(jsonlite) ##loads jsonlite to your current session##
library(ggplot2) ##loads ggplot2 to your current session##

d <- file("mydata.json", "r") ###connecting to file; "r" mode is open to read in text mode##
d2 <- readLines(d)
d3 <- fromJSON(d2[16]) ####relevant line is #16, read that in ##
hr <- d3$"activities-heart-intraday"$dataset ##and convert to dataframe##

dim(hr)
write.csv(hr, "mydata.csv")###optional, if you want to save the data so you can open in excel##

hr$Min <- seq.int(nrow(hr)) #adds a column with minutes of workout##
head(hr) ##take a peek at data##
uplimmin <- max(hr$Min)

tiff("MydataGraph.tiff", width=10, height=8, units="in", res=600, pointsize=16)

ggplot(hr, aes(x=Min, y=value, color=value)) + geom_line() + geom_point(size=0.8) + scale_y_continuous(name="Heart rate (bpm)", limits=c(40, 200), breaks=seq(40, 200, by=10)) + scale_x_continuous(name="Time (minutes)", limits=c(min(hr$Min),max(hr$Min)), breaks=seq(0, uplimmin, by=10)) + scale_color_gradient2(name="Heart rate (bpm)", low= "#DBB165", mid="#2E604A", high="#D1362F", midpoint=120) + ggtitle("My heart rate (customize title)") + theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"), plot.title=element_text(size = 16, face = "bold"))
dev.off()
