
################################################################################################################
##                                                TRANSFORMATIONS                                             ##
################################################################################################################
####################################################
## Prague Analytics Team  (c) - Eliska Vlckova
## eliska.vlckova@guycarp.com 
## created 27.11.2019



########## Chapter 1 #################################################################################################################


##################################### 
##### MANAGING DATA FRAMES

  # The dplyr package is designed to mitigate a lot of problems like collapsing, re-ordering and filtering and to provide a highly optimized set of routines
  install.packages("dplyr")    #  to install the package / or go through "install" in R GUI
  library(dplyr)               # to use the library

  # dplyr works with pipes and tidy data
  # tidy data: each variable is in its own columns & each observation is in its own row
  # pipes: x %>% f(y) becomes f(x,y)

  #load the library with the training dataset
  install.packages("ggplot2")
  library(ggplot2)
  
  head(msleep)     # The msleep (mammals sleep) data set contains the sleeptimes and weights for a set of mammals 

##################################### 
##### Pipe operator: %>%

  head(select(msleep, name, sleep_total))
  
  msleep %>% 
    select(name, sleep_total) %>% 
    head

##################################### 
##### select

  head(select(msleep, name, sleep_total))        # select the name and the sleep_total columns.
  head(select(msleep, -name))                    # select everything except name
  head(select(msleep, genus:conservation))       # select a range of columns
  head(select_if(msleep, is.numeric ))           # select_if  - to extract numeric columns only

  # use of functions what exists only inside select()
  head(select(msleep, starts_with("sl")))       # select columns starting with *character string
  head(select(msleep, ends_with("wt")))         # select columns what end with character string
  head(select(msleep, contains("sleep")))       # select columns containing character string
  head(select(msleep, matches("sl")))           # select columns that match a regular expression (grep(), sub(), ...)
  head(select(msleep, num_range("sl")))         # ??? Matches a numerical range like x01, x02, x03.
  head(select(msleep, one_of("omni")))          # ??? Matches variable names in a character vector.
  head(select(msleep, everything("om")))        # ??? Matches all variables.
  head(select(msleep, group_cols("sl")))        # ???  columns names that are from a group of names 


##################################### 
  ##### filter
  filter(msleep, sleep_total >= 16)                             # select animals who sleep more than 16 hours
  filter(msleep, sleep_total >= 16,  bodywt >= 1)               # filter the rows for mammals that sleep a total of more than 16 hours and have a body weight of greater than 1 kilogram.
  filter(msleep, order %in% c("Perissodactyla", "Primates"))    # Filter the rows for mammals in the Perissodactyla and Primates taxonomic order


##################################### 
  ##### Arrange or re-order rows
  (msleep %>% arrange(order, name) ) # simply list the name of the column you want to arrange the rows by
  
  (msleep %>% 
    select(name, order, sleep_total) %>%
    arrange(order, sleep_total) )
  
  
  msleep %>% 
    select(name, order, sleep_total) %>%          # select three columns from msleep
    arrange(order, desc(sleep_total)) %>%         # then arrange the rows by sleep_total descending
    filter(sleep_total >= 16) %>%                 # filter for minimum sleep of 16 hours
    head                                          # show the head of the final data frame
  

##################################### 
  #### rename column
  msleep %>%
    rename(animal =  name) %>%
    head
  
  # native R approach
  colnames(msleep)[1] <- "animal"           # rename the first column
  msleep$animal[1] <- "animal"



##################################### 
##### Create new columns using mutate()

  # The mutate() function will add new columns to the data frame
  msleep %>%  
    mutate(rem_proportion = sleep_rem / sleep_total) %>%      # Create a new column called rem_proportion 
    head

  # do the same, but in native functions in R
  msleep$rem_prop <- msleep$sleep_rem / msleep$sleep_total

  # mutate_if 
  msleep %>%
    mutate_if(~sum(is.na(.x)) > 0,                              # only mutate columns with at least one "NA"
              ~if_else(is.na(.x), "missing", as.character(.x))) # replace each NA value with the character "missing"
  

  # transmute() function then drops all non-transformed variables.
  msleep %>%  
    transmute(rem_proportion = sleep_rem / sleep_total) %>%   # Create a new column called rem_proportion 
    head



##################################### 
  ##### Create summaries

  msleep %>% 
    summarise(avg_sleep = mean(sleep_total))

  # There are many other summary statistics you could consider:
  # such sd(), min(), max(), median(), sum(), n() (returns the length of vector)
  # first() (returns first value in vector), last() (returns last value in vector) and n_distinct() (number of distinct values in vector).
    msleep %>% 
    summarise(avg_sleep = mean(sleep_total), 
              min_sleep = min(sleep_total),
              max_sleep = max(sleep_total),
              total = n())                      # returns the lenght of a vector

##################################### 
##### Grouping

  msleep %>% 
    group_by(order) %>%                         # split the msleep data frame by the taxonomic order,
    summarise(avg_sleep = mean(sleep_total),    # then ask for the same summary statistics
              min_sleep = min(sleep_total),     # We expect a set of summary statistics for each taxonomic order.
              max_sleep = max(sleep_total),
              total = n())


########## Chapter 2 #################################################################################################################

  ##################################### 
  ##### combine two objects

  new_animal <- c("Human", "Homo", "carni", "Primates", "domesticated", "7", "1", "", "16", "0.6", "75")  # create variable to be added
  msleep1 <- msleep
  
  
  # To merge two objects by rows use rbind() function, big usage while looping!
  ( msleep <- rbind(msleep1,msleep) )   # merge by rows - must have the same number of columns!
  tail(msleep)
  
  
  # To merge two objects by columns use cbind() function 
  ID <- 1:nrow(msleep)                    # create new vector to be added as columns to the data frame
  ( msleep <- cbind(msleep,ID) )          # merge by columns - must have the same number of rows!
  

  
##################################### 
##### merging and appending data frames

  msleep_part1 <- msleep %>% select(name, genus, vore) # creating two dataframes for later merging
  msleep_part2 <- msleep %>% select(name, sleep_total)


  # Merging means transferring columns from one dataset to another
  msleep_merged <- merge(msleep_part1,msleep_part2, by = "name") 

  # if different column names, use by.x and by.y arguments
  msleep_merged <- merge(msleep_part1,msleep_part2, by.x = "name", by.y = "name") 

  # you can add suffixes - but only when you have any other same-name columns in both tables to get them suffixes 
  # add sleep total to first table and do the same again
  msleep_part1 <- msleep %>% select(name, genus, vore, sleep_total)
  msleep_merged <- merge(msleep_part1,msleep_part2, by = "name", suffixes = c("_part1", "_part2"))

  # keep all values, use "all = TRUE" argument
  msleep_merged <- merge(msleep_part1,msleep_part2, by = "name", all = TRUE)    # outer join
  msleep_merged <- merge(msleep_part1,msleep_part2, by = "name", all.x = TRUE)  # left join
  msleep_merged <- merge(msleep_part1,msleep_part2, by = "name", all.y = TRUE)  # right join


  # Appending means transferring rows from one dataset to another
  #same as rbind

################################################################################################################  
### End. 