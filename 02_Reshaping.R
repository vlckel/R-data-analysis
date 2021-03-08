
################################################################################################################
##                                                  RESHAPING                                                 ##
################################################################################################################
####################################################
## Prague Analytics Team  (c) - Eliska Vlckova
## eliska.vlckova@guycarp.com 
## created 28.11.2019



########## Chapter 1 #################################################################################################################
# usage of reshaping functions melt (wide to long) and dcast (long to wide)

  # need to use reshape package
  install.packages("reshape2")
  library(reshape2)
  
  #load the library with the training dataset
  install.packages("ggplot2")
  library(ggplot2)
  
  head(msleep)     # The msleep (mammals sleep) data set contains the sleeptimes and weights for a set of mammals 


##################################### 
  
  ##### melting - wide to long  
  msleep_melt <- melt(msleep, id.vars = c("name", "genus", "vore"), 
                      measure.vars = c("sleep_total", "sleep_rem")) # measure.vars specify the set of columns we would like to collapse (or combine) together
  
  # By default, variable column is of type factor. Set variable.factor argument to FALSE if you want to return a character vector instead
  
  head(msleep_melt) # By default, the molten columns are automatically named variable and value.
  
  # name the value and variable by yourself
  msleep_melt <- melt(msleep, id.vars = c("name", "genus", "vore"), 
                      measure.vars = c("sleep_total", "sleep_rem"),
                      variable.name = "sleep_type", value.name = "sleep_time")



##################################### 
  ##### dcast - long to wide
  
  # the aim is to collect all "sleep_Type" corresponding to each "name", "genus" and "vone" together under the same row
  # value.var denotes the column to be filled in with while casting to wide format.
  msleep_origin <- dcast(msleep_melt, name + genus + vore ~ sleep_type, value.var = "sleep_time")
  # hint ---  "id.vars" ~ "measure.vars"
  
  
  # aggregate by in dcast with the argument fun.aggregate
  # essential when the formula provided does not identify single observation for each cell
  dcast(msleep_melt, vore ~ ., fun.agg = function(x) sum(!is.na(x)), value.var = "name")
  
  ##################################### 
  ##### reshaping
  
  reshape()  # https://www.rdocumentation.org/packages/stats/versions/3.6.1/topics/reshape

################################################################################################################  
### End. 

