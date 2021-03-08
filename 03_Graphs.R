################################################################################################################
##                                                  GRAPHS                                                    ##
################################################################################################################
####################################################
## Prague Analytics Team  (c) - Karel Marek
## karel.marek@guycarp.com 
## created 15.1.2020


########## Chapter 1 #################################################################################################################

##### Variable types - basic intro #####
  # Identify first what type of data I have and what I want to show
  #
  # Two general types of variables
  #     - Quantitative (numerical) 
  #         - can be counted, measured and expressed using numbers
  #
  #         - Discrete data
  #               - # of students in class, # items sold, # Risks, # Policies
  #               - in R as integer
  #
  #         - Continuous data
  #               - temperature, salary, TSI  
  #               - in R as numeric
  #
  #     - Qualitative (categorical) 
  #         - descriptive, label variables, does not measure, non-statistical, numbers as codes here
  #
  #         - Nominal data
  #               - gender, nationality, Occupancy, LOB  
  #               - in R as factor, character
  #
  #         - Ordinal data
  #               - education, rating, Geo Resolution Code 
  #               - in R as factor, character
  #

########## Chapter 2 #################################################################################################################
  # reading the libraries and setting up
  library(dplyr)
  
  wd <- "z:\\Training_materials\\02_INTERNAL_TRAININGS\\201911 Basic R Training\\Excercises_with_Solutions"
  setwd(wd)
  tsrunup <- read.csv("tsrunup.txt", header = T, sep = "\t", stringsAsFactors = F)
  
  str(tsrunup) # str() function shows the structure of R object - variable type and 1st 10 columns
  summary(tsrunup$DAMAGE_MILLIONS_DOLLARS) # basic statictics about variable

    
##################################### 
##### histogram - shows the distribution of data
  
  hist(tsrunup$DAMAGE_MILLIONS_DOLLARS) # basic histogram, define the column only
  
  tsrunup_v2 <- subset(tsrunup,DAMAGE_MILLIONS_DOLLARS <= 1) # elimination of extreme values using subset to select
  
  hist(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, col = "cadetblue3", main = "Tsunami Property losses", xlab = "Loss mil. $") # col - set color, main - name of the graph, xlab - name of x axis
  hist(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, col = "cadetblue3", main = "Tsunami Property losses", xlab = "Loss mil. $", xlim = c(0,1)) # xlim - set the limit of x axis
  hist(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, col = "cadetblue3", main = "Tsunami Property losses", xlab = "Loss mil. $", xlim = c(0,0.5), breaks = 10) # breaks - set number of breaks 
  
  # Color Palette in R - http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
  
  
##################################### 
##### box plot 
  
# showing data distribution using descriptive statistics measures - min., 1st quartile, median, 3rd quartile, max.
  
  boxplot(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS) # point to column with  data to present
  boxplot(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, col = "cadetblue3", main = "Tsunami Property losses")
  boxplot(tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, col = "cadetblue3", main = "Tsunami Property losses", ylab = "Loss mil. $", horizontal = T) # horizontal - T/F changing the orientation of plot
  
  
##################################### 
##### scatter plot 

# shows values of two quantitative variables, checks (non)linearity
  
  # Is there a linear correlation between losses and #houses damaged?
  plot(tsrunup_v2$HOUSES_DAMAGED,tsrunup_v2$DAMAGE_MILLIONS_DOLLARS) # scatter plot requires two variables for input
  plot(tsrunup_v2$HOUSES_DAMAGED,tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, main = "Property losses and houses damaged linearity", ylab = "Loss mil. $", xlab = "# houses damaged", col = "red", pch = 16) # pch - define plot character
  
  abline(lm(DAMAGE_MILLIONS_DOLLARS ~ HOUSES_DAMAGED, data = tsrunup_v2), col = "red", lwd=4, lty=1) # add regression line - lm() linear model function, lwd - line width, lty - line type 
  
  # plot characters used in R: https://www.datanovia.com/en/blog/pch-in-r-best-tips/
  # line types used in R: http://www.sthda.com/english/wiki/line-types-in-r-lty
  
  cor(tsrunup_v2$HOUSES_DAMAGED,tsrunup_v2$DAMAGE_MILLIONS_DOLLARS, use = "complete.obs") # use = "complete.obs" - if NA's in data it will calculate Pearson correlation coefficient only from complete observations 
  
  # Pearson correlation coefficient - measure of the linear correlation between two variables
  # Value between -1 and 1
  # 1 is total positive linear correlation
  # 0 is no linear correlation
  # -1 is total negative linear correlation
  
  
##################################### 
##### bar plot
  
# shows absolute or relative frequency of selected variable, graph used for both qualitative and quantitative data
  
  # with qualitative data
  tsrunup_v2_measure_freq <- table(tsrunup_v2$TYPE_MEASUREMENT_ID) # Necessary to create frequency table first
  
  barplot(tsrunup_v2_measure_freq) # input data to the graph is the frequency table itself
  barplot(tsrunup_v2_measure_freq, col = "cadetblue3", main = "Measurement type ID", ylim = c(0,70))
  barplot(tsrunup_v2_measure_freq, col = "cadetblue3", main = "Measurement type ID", ylim = c(0,70), names = c("Eyewitness measurement","Tide-gauge measurement", "Runup Height", "Seiche"), cex.names = 0.5) # names - variable name in this case what each ID means, cex - magnification or reduction of plot parts (main, name, axis)
  
  # with quantitative data using aggregates
  tsrunup_v2_sum <- tsrunup_v2 %>%
    group_by(COUNTRY) %>%
    summarize(Damage_Sum = sum(na.omit(DAMAGE_MILLIONS_DOLLARS))) %>%
    arrange(-Damage_Sum)
  
  barplot(tsrunup_v2_sum$Damage_Sum, names = tsrunup_v2_sum$COUNTRY) # names of variable specified in column
  barplot(tsrunup_v2_sum$Damage_Sum, names = tsrunup_v2_sum$COUNTRY, col = heat.colors(9), main = "Tsunami Property losses per Country", ylab = "Loss mil. $", ylim = c(0,20)) # col - color pallete to show Continuous data, necessary to specify number of unique variables heat.colors(x) using number or length
  barplot(tsrunup_v2_sum$Damage_Sum, names = tsrunup_v2_sum$COUNTRY, col = heat.colors(length(tsrunup_v2_sum$COUNTRY)), main = "Tsunami Property losses per Country", ylab = "Loss mil. $", ylim = c(0,20), cex.names = 0.65,cex.axis = 0.65,cex.lab = 0.65, space = 0, las = 2) # las - position of variable name
  
  legend(x = "topright",
         legend = tsrunup_v2_sum$COUNTRY,
         fill = heat.colors(length(tsrunup_v2_sum$COUNTRY)),
         cex = 0.5
         ) 
  # add legend for better understanding of graph, 1st - where to put legend on graph using keywords or coordinates
  # legend - variables name
  # fill - colors, color pallete used 
  
  # R base color palletes can be found here: https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/#r-base-color-palettes
  
  
##################################### 
##### pie plot 

# - slices represent relative frequency of variables
  
  pie(tsrunup_v2_sum$Damage_Sum) # point to the column with data   
  pie(tsrunup_v2_sum$Damage_Sum, labels = tsrunup_v2_sum$COUNTRY) # labels - put appropriate label names to the graph 
  
  pie(tsrunup_v2_sum$Damage_Sum, labels = tsrunup_v2_sum$COUNTRY, main = "Tsunami Property losses per Country", col = rainbow(length(tsrunup_v2_sum$Damage_Sum)), cex = 0.8, radius = 0.6) # radius - indicates the radius of the circle of the pie chart [-1,+1]
  
  # create percent labels
  Damage_Sum_percent <- round(tsrunup_v2_sum$Damage_Sum/sum(tsrunup_v2_sum$Damage_Sum)*100,1) 
  Damage_Sum_percent <- paste(Damage_Sum_percent,"%") # paste() - as concatenate 
  
  pie(tsrunup_v2_sum$Damage_Sum, labels = Damage_Sum_percent, main = "Tsunami Property losses per Country", col = rainbow(length(tsrunup_v2_sum$Damage_Sum)), cex = 0.8, radius = 0.6)
  
  legend("bottom",
         legend = tsrunup_v2_sum$COUNTRY,
         fill = rainbow(9),cex = 0.3,ncol = 2
  )
  
  # ncol - specify number of columns in which the variable in legend will be placed
  
  
##################################### 
##### exporting graph
  
  png("TS_Property_losses_per_country.png") # define name of file
  
  pie(tsrunup_v2_sum$Damage_Sum, labels = Damage_Sum_percent, main = "Tsunami Property losses per Country", col = rainbow(length(tsrunup_v2_sum$Damage_Sum)), cex = 0.8, radius = 0.6)
  
  
  legend("bottom",
         tsrunup_v2_sum$COUNTRY,
         fill = rainbow(9),cex = 0.3,ncol = 2
  )
  
  dev.off # close command